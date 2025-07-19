# TODO

## High Priority

- [ ] Update code to use generic paths instead of personal home paths for Bazzite compatibility (immutable OS)
- [ ] **Remove RGB/Lighting Components** - Focus project on power/fan control only
  - [ ] Remove entire `razer_control_gui/src/daemon/kbd/` directory
  - [ ] Remove RGB-related code from `device.rs` (brightness, logo, effects methods)
  - [ ] Remove `brightness` and `logo_state` fields from `PowerConfig` struct
  - [ ] Remove RGB commands from `comms.rs` (SetEffect, SetBrightness, etc.)
  - [ ] Strip RGB UI from `razer-settings.rs` (brightness, logo, color controls)
  - [ ] Remove `driver_sysfs.rs` (RGB-only functionality)
- [ ] **OpenRazer Integration Strategy**
  - [ ] Document coexistence setup with OpenRazer for RGB
  - [ ] Create integration layer for power-state-aware lighting
  - [ ] Add modprobe blacklist instructions for laptop devices
  - [ ] Update README to reflect power-only focus

## Power Management Core
- [ ] Add support for custom fan curves
- [ ] Add support for custom power profiles
- [ ] Improve battery optimization (BHO) features
- [ ] Add thermal monitoring and alerts
- [ ] Add CPU/GPU frequency monitoring

## GUI (Power-Focused)
- [ ] Update GUI to remove all RGB controls
- [ ] Add fan curve editor interface
- [ ] Add power profile management
- [ ] Add thermal monitoring dashboard
- [ ] Add system tray icon for quick power switching
- [ ] Add notifications for power mode changes

## Daemon Improvements
- [ ] Streamline configuration (remove RGB settings)
- [ ] Add power curve profiles
- [ ] Add thermal threshold management
- [ ] Improve AC/battery switching logic
- [ ] Add performance monitoring metrics

## Extended Features
- [ ] Add support for more Razer laptops
- [ ] Add custom thermal profiles
- [ ] Add performance benchmarking integration
- [ ] Add power consumption monitoring
- [ ] Add automatic power profile switching based on workload

## Testing & Quality
- [ ] Add unit tests for power management
- [ ] Add integration tests for fan control
- [ ] Add tests for battery optimization
- [ ] Add thermal stress testing
- [ ] Add power profile switching tests

## Documentation Updates
- [ ] Update documentation to reflect power-only focus
- [ ] Add OpenRazer integration guide
- [ ] Document power profile configuration
- [ ] Add thermal management guide
- [ ] Update installation instructions

## Packaging
- [ ] Add a Flatpak package
