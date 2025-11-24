# Contributing to RD-03D ESPHome Integration

First off, thank you for considering contributing to this project! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Community](#community)

---

## Code of Conduct

This project follows a simple code of conduct:

- **Be Respectful:** Treat everyone with respect
- **Be Constructive:** Provide helpful feedback
- **Be Patient:** Remember that contributors are volunteers
- **Be Inclusive:** Welcome newcomers and different perspectives

---

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

**Bug Report Template:**

```markdown
**Describe the Bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected Behavior**
What you expected to happen.

**Screenshots/Logs**
If applicable, add screenshots or log outputs.

**Environment:**
 - ESP Board: [e.g., ESP32-S3]
 - ESPHome Version: [e.g., 2024.10.0]
 - Home Assistant Version: [e.g., 2024.11.0]
 - Sensor Model: [e.g., RD-03D]

**Additional Context**
Any other context about the problem.
```

### 💡 Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

**Enhancement Template:**

```markdown
**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Alternative solutions or features you've considered.

**Additional context**
Any other context or screenshots.
```

### 📝 Pull Requests

We actively welcome your pull requests! Here's how:

1. **Fork the repo** and create your branch from `main`
2. **Make your changes** following our style guidelines
3. **Test your changes** thoroughly
4. **Update documentation** if you changed functionality
5. **Submit a pull request** with a clear description

---

## Development Setup

### Prerequisites

- ESPHome installed (via Home Assistant or standalone)
- ESP32 or ESP32-S3 development board
- RD-03D sensor
- Basic understanding of YAML and C++

### Local Testing

1. **Clone your fork:**
   ```bash
   git clone https://github.com/yourusername/rd-03d-esphome.git
   cd rd-03d-esphome
   ```

2. **Create test configuration:**
   ```bash
   cp configs/secrets.yaml.example configs/secrets.yaml
   # Edit with your WiFi credentials
   ```

3. **Validate configuration:**
   ```bash
   esphome config configs/rd-03d-esp32s3.yaml
   ```

4. **Test on hardware:**
   ```bash
   esphome run configs/rd-03d-esp32s3.yaml
   ```

---

## Pull Request Process

### Before Submitting

- ✅ Code compiles without errors
- ✅ Tested on actual hardware
- ✅ Documentation updated
- ✅ CHANGELOG.md updated (if applicable)
- ✅ Commit messages are clear

### PR Template

```markdown
**Description**
Brief description of changes.

**Type of Change**
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Configuration improvement

**Testing**
Describe testing performed:
- [ ] Compiled successfully
- [ ] Tested on ESP32
- [ ] Tested on ESP32-S3
- [ ] Tested with Home Assistant

**Screenshots/Logs**
If applicable, add screenshots or logs.

**Checklist:**
- [ ] My code follows the style guidelines
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have tested my changes
```

---

## Style Guidelines

### YAML Style

```yaml
# Good: Clear, commented, properly indented
sensor:
  - platform: template
    name: "Distance"  # Human-readable name
    id: rd03d_distance  # Internal ID
    unit_of_measurement: "cm"
    accuracy_decimals: 1
```

```yaml
# Bad: No comments, inconsistent spacing
sensor:
- platform: template
  name: Distance
  id:rd03d_distance
  unit_of_measurement:cm
```

### C++ Lambda Style

```cpp
// Good: Clear variable names, commented logic
int16_t target_x = ((int16_t)(rx_buffer[4] | (rx_buffer[5] << 8))) - 0x200;

// Calculate distance using Pythagorean theorem
float distance = sqrt(pow(target_x, 2) + pow(target_y, 2)) / 10.0;
```

```cpp
// Bad: Unclear variables, no comments
int16_t x=(int16_t)(b[4]|b[5]<<8)-0x200;
float d=sqrt(pow(x,2)+pow(y,2))/10.0;
```

### Documentation Style

- Use **clear headings** (H1, H2, H3)
- Include **code examples** where applicable
- Add **emojis sparingly** for visual breaks
- Keep **line length** under 100 characters
- Use **tables** for comparisons
- Include **warnings** for critical information

---

## Commit Message Guidelines

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat:** New feature
- **fix:** Bug fix
- **docs:** Documentation changes
- **style:** Code style changes (formatting)
- **refactor:** Code refactoring
- **test:** Adding tests
- **chore:** Maintenance tasks

### Examples

```bash
# Good
feat(sensor): Add multi-target detection support

Implemented parsing for all three targets in the data frame.
Updated documentation with new sensor entities.

Closes #42

# Simple
fix: Correct GPIO pin numbers in ESP32-S3 config

# Documentation
docs: Add troubleshooting section for buffer overflow
```

---

## Testing

### Hardware Testing Checklist

When testing changes on hardware:

- [ ] Basic detection works (on/off)
- [ ] Distance readings are accurate (±15cm)
- [ ] Angle readings are reasonable (-180° to +180°)
- [ ] No excessive errors in logs (<1% error rate)
- [ ] WiFi connection stable
- [ ] Home Assistant integration working
- [ ] OTA updates successful

### Software Testing

```bash
# Validate YAML
esphome config your-config.yaml

# Check compilation
esphome compile your-config.yaml

# View logs
esphome logs your-config.yaml
```

---

## Documentation Contributions

Documentation is just as important as code!

### Types of Documentation Needed

- **Tutorials:** Step-by-step guides for specific tasks
- **How-to Guides:** Solutions for common problems
- **Reference:** Technical specifications and API docs
- **Explanations:** Conceptual overviews

### Writing Guidelines

- Write in **clear, simple English**
- Use **active voice** ("Connect the sensor" not "The sensor should be connected")
- Include **examples** wherever possible
- Add **screenshots** for UI-related documentation
- Test all code examples before submitting

---

## Community

### Where to Get Help

- **GitHub Issues:** Bug reports and feature requests
- **GitHub Discussions:** Questions and general discussion
- **Home Assistant Forums:** Community support
- **ESPHome Discord:** Real-time chat

### Recognition

All contributors will be:
- Listed in the README
- Thanked in release notes
- Credited in their PR/issue

---

## Project Structure

```
rd-03d-esphome/
├── configs/           # ESPHome configuration files
├── docs/             # Documentation
├── examples/         # Example automations
├── images/           # Screenshots and diagrams
├── CHANGELOG.md      # Version history
├── CONTRIBUTING.md   # This file
├── LICENSE           # MIT License
└── README.md         # Project overview
```

---

## Release Process

Maintainers follow this process for releases:

1. Update `CHANGELOG.md` with all changes
2. Create a new git tag: `git tag -a v1.x.x -m "Version 1.x.x"`
3. Push tag: `git push origin v1.x.x`
4. Create GitHub release with changelog
5. Update README if needed

---

## Questions?

If you have questions about contributing:

1. Check existing **GitHub Issues** and **Discussions**
2. Read the **documentation** in the `docs/` folder
3. Ask in **GitHub Discussions**
4. Create a **new issue** with the "question" label

---

## Thank You! 🎉

Your contributions make this project better for everyone. Whether it's:

- 🐛 Fixing a typo
- 📝 Improving documentation
- 🔧 Adding features
- 🧪 Testing on different hardware

Every contribution is valued and appreciated!

---

**Happy Contributing!** 🚀

[⬆ Back to Top](#contributing-to-rd-03d-esphome-integration)
