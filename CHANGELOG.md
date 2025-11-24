# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Multi-target tracking support
- LED effects integration
- MQTT support (optional)
- Web configuration interface
- PCB design files

---

## [1.0.0] - 2025-01-20

### Added
- Initial release
- Single target detection mode
- ESP32 and ESP32-S3 support
- Home Assistant Native API integration
- Real-time sensor data (distance, angle, X/Y position, speed)
- Binary occupancy sensor
- Debug logging with frame statistics
- Error tracking and reporting
- Sensor reinitialization button
- Comprehensive documentation
  - Hardware setup guide
  - Troubleshooting guide
  - Coverage analysis
  - Advanced configuration
- Example Home Assistant automations
- MIT License

### Technical Details
- UART communication at 256000 baud
- 50ms update interval (~20 Hz)
- Automatic single-target mode initialization on boot
- Buffer overflow protection
- Frame validation (header and tail checks)
- 5-second timeout detection

### Tested On
- ESP32-S3 DevKit C-1
- ESPHome 2024.10.5
- Home Assistant 2024.11.x
- RD-03D 24GHz mmWave Radar Sensor

---

## Version History

### [1.0.0] - 2025-01-20
- Initial public release

---

## Release Notes Format

Each release includes:

### Added
- New features or capabilities

### Changed
- Changes to existing functionality

### Deprecated
- Features that will be removed in future releases

### Removed
- Features removed in this release

### Fixed
- Bug fixes

### Security
- Security patches and improvements

---

## How to Report Issues

Found a bug or have a suggestion? Please:

1. Check if the issue already exists in [GitHub Issues](https://github.com/yourusername/rd-03d-esphome/issues)
2. Create a new issue with:
   - Clear description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Environment details (ESP board, ESPHome version, etc.)
   - Logs if applicable

---

## Contribution Guidelines

Want to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Reporting bugs
- Suggesting enhancements
- Submitting pull requests
- Code style guidelines

---

[Unreleased]: https://github.com/yourusername/rd-03d-esphome/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/rd-03d-esphome/releases/tag/v1.0.0
