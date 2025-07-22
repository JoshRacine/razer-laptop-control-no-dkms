# TODO

## High Priority

- [x] Update code to use generic paths instead of personal home paths for Bazzite compatibility (immutable OS)
- [x] **Remove RGB/Lighting Components** - Focus project on power/fan control only ✅ COMPLETED
  - [x] Remove entire `razer_control_gui/src/daemon/kbd/` directory
  - [x] Remove RGB-related code from `device.rs` (brightness, logo, effects methods)
  - [x] Remove `brightness` and `logo_state` fields from `PowerConfig` struct
  - [x] Remove RGB commands from `comms.rs` (SetEffect, SetBrightness, etc.)
  - [x] Strip RGB UI from `razer-settings.rs` (brightness, logo, color controls)
  - [x] Remove `driver_sysfs.rs` (RGB-only functionality)
  - [x] Fixed UI to conditionally show Battery Health tab only for supported devices
- [ ] **OpenRazer Integration Strategy**
  - [ ] Document coexistence setup with OpenRazer for RGB
  - [ ] Create integration layer for power-state-aware lighting
  - [ ] Add modprobe blacklist instructions for laptop devices
  - [x] Update README to reflect power-only focus

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
