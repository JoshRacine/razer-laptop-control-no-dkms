#!/usr/bin/env bash

detect_init_system() {
    if pidof systemd 1>/dev/null 2>/dev/null; then
        INIT_SYSTEM="systemd"
    elif [ -f "/sbin/rc-update" ]; then
        INIT_SYSTEM="openrc"
    else
        INIT_SYSTEM="other"
    fi
}

install() {
    echo "Building the project..."
    cargo build --release # TODO: The GUI should be optional. At least for now. Before releasing this, it sould be turned into a feature with an explicit cli switch to install it

    if [ $? -ne 0 ]; then
        echo "An error occurred while building the project"
        exit 1
    fi

    # Stop the service if it's running
    echo "Stopping the service..."
    case $INIT_SYSTEM in
    systemd)
        systemctl --user stop razercontrol
        ;;
    openrc)
        sudo rc-service razercontrol stop
        ;;
    esac

    # Install the files
    echo "Installing the files..."
    mkdir -p ~/.local/share/razercontrol
    mkdir -p ~/.local/bin
    
    # Install binaries to user local directory
    cp target/release/razer-cli ~/.local/bin/
    cp target/release/razer-settings ~/.local/bin/
    cp target/release/daemon ~/.local/share/razercontrol/
    cp data/devices/laptops.json ~/.local/share/razercontrol/
    
    # Install desktop file to user directory
    if [ -d ~/.local/share/applications ]; then
        mkdir -p ~/.local/share/applications
        cp data/gui/razer-settings.desktop ~/.local/share/applications/
        # Update the desktop file to use local paths
        sed -i "s|/usr/bin/razer-settings|$HOME/.local/bin/razer-settings|g" ~/.local/share/applications/razer-settings.desktop
    fi
    
    # Try to install udev rules (may fail on immutable OS, but that's ok)
    if sudo cp data/udev/99-hidraw-permissions.rules /etc/udev/rules.d/ 2>/dev/null; then
        sudo udevadm control --reload-rules
        echo "✓ Installed udev rules"
    else
        echo "⚠ Could not install udev rules (immutable OS?) - you may need to run as root or use Flatpak"
    fi
    
    # Add ~/.local/bin to PATH if not already there
    if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
        echo "Adding ~/.local/bin to PATH in ~/.bashrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo "⚠ Please run 'source ~/.bashrc' or restart your terminal"
    fi

    if [ $? -ne 0 ]; then
        echo "An error occurred while installing the files"
        exit 1
    fi

    # Start the service
    echo "Starting the service..."
    case $INIT_SYSTEM in
    systemd)
        sudo cp data/services/systemd/razercontrol.service /etc/systemd/user/
        systemctl --user enable --now razercontrol
        ;;
    openrc)
        sudo bash <<EOF
            cp data/services/openrc/razercontrol /etc/init.d/
            # HACK: Change the username in the script
            sed -i 's/USERNAME_CHANGEME/$USER/' /etc/init.d/razercontrol

            chmod +x /etc/init.d/razercontrol
            rc-update add razercontrol default
            rc-service razercontrol start
EOF
        ;;
    esac

    echo "Installation complete"
}

uninstall() {
    # Remove the files
    echo "Uninstalling the files..."
    
    # Remove user-local files
    rm -f ~/.local/bin/razer-cli
    rm -f ~/.local/bin/razer-settings
    rm -f ~/.local/share/applications/razer-settings.desktop
    rm -f ~/.local/share/razercontrol/daemon
    rm -f ~/.local/share/razercontrol/laptops.json
    rmdir ~/.local/share/razercontrol 2>/dev/null || true
    
    # Try to remove udev rules (may fail on immutable OS)
    if sudo rm -f /etc/udev/rules.d/99-hidraw-permissions.rules 2>/dev/null; then
        sudo udevadm control --reload-rules
        echo "✓ Removed udev rules"
    else
        echo "⚠ Could not remove udev rules (immutable OS?)"
    fi

    # Stop the service
    echo "Stopping the service..."
    case $INIT_SYSTEM in
    systemd)
        systemctl --user disable --now razercontrol
    sudo bash <<EOF
        rm -f /etc/systemd/user/razercontrol.service
EOF
        ;;
    openrc)
        sudo bash <<EOF
            rc-service razercontrol stop
            rc-update del razercontrol default
            rm -f /etc/init.d/razercontrol
EOF
        ;;
    esac

    echo "Uninstalled"
}

main() {
    if [ "$EUID" -eq 0 ]; then
        echo "Please do not run as root"
        exit 1
    fi

    detect_init_system

    if [ "$INIT_SYSTEM" = "other" ]; then
        echo "Unsupported init system"
        exit 1
    fi

    case $1 in
    install)
        install
        ;;
    uninstall)
        uninstall
        ;;
    *)
        echo "Usage: $0 {install|uninstall}"
        exit 1
        ;;
    esac
}

main $@
