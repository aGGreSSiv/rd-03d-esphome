# RD-03D mmWave Radar ESPHome Integration

<div align="center">

![RD-03D Sensor](https://img.shields.io/badge/Sensor-RD--03D-blue?style=for-the-badge)
![ESPHome](https://img.shields.io/badge/ESPHome-2024.10+-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Home Assistant](https://img.shields.io/badge/Home%20Assistant-Compatible-blue?style=for-the-badge)

**Integrate RD-03D 24GHz mmWave radar with Home Assistant via ESPHome**

[Features](#-features) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [Support](#-support)

</div>

---

## ⚠️ Disclaimer

This project was created with AI assistance. While I've tested it personally, I'm not a professional developer. The RD-03D sensor has limited documentation and may not perform as advertised in its datasheet. For production use, consider well-documented alternatives like DFRobot or Seeed Studio sensors. The LD2410B has been more reliable in my testing, but lacks the 8m range of the RD-03D.

---

## ✨ Features

- 🎯 **Single Target Tracking** - Distance, angle, position, and speed detection
- 🔌 **ESP32 & ESP32-S3 Support** - Arduino framework for stability
- 🏠 **Native Home Assistant Integration** - No MQTT required
- ⚡ **Real-time Updates** - 50ms refresh rate (~20 Hz)
- 📊 **Comprehensive Sensors** - Distance, X/Y coordinates, angle, speed
- 🔍 **Debug Logging** - Detailed frame statistics and error tracking
- 🔄 **Auto-recovery** - Sensor reinitialization button
- 📡 **8m Range** - Horizontal ±60°, Vertical ±30°
- 🛠️ **Easy Setup** - Plug and play with Home Assistant

---

## 📋 Table of Contents

- [Hardware Requirements](#-hardware-requirements)
- [Quick Start](#-quick-start)
- [Configuration](#️-configuration)
- [Sensors](#-sensors)
- [Documentation](#-documentation)
- [Troubleshooting](#-troubleshooting)
- [Examples](#-examples)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔧 Hardware Requirements

### Required Components

| Component | Specification | Notes |
|-----------|--------------|-------|
| **Sensor** | RD-03D 24GHz mmWave Radar | Ai-Thinker module |
| **MCU** | ESP32 or ESP32-S3 | ESP32-S3 DevKit C-1 tested |
| **Power** | 5V, ≥200mA | 3.3V will NOT work |
| **Cables** | Female-Female jumper wires | <50cm recommended |

### Pin Connections

```
RD-03D          ESP32/ESP32-S3
------          --------------
VCC (5V)   →    5V
GND        →    GND
TXD        →    GPIO16 (RX)    ⚠️ Crossover!
RXD        →    GPIO17 (TX)    ⚠️ Crossover!
```

> ⚠️ **Critical:** TX/RX pins must be crossed (sensor TX → ESP RX, sensor RX → ESP TX)

---

## 🚀 Quick Start

### 1. Hardware Setup

1. Connect RD-03D to ESP32 following the [pin diagram](#pin-connections)
2. Ensure 5V power supply (USB is sufficient for testing)
3. Mount sensor with Ai-Thinker logo facing up

### 2. Software Installation

**For Home Assistant ESPHome Add-on:**

```bash
# 1. Copy configuration file
cp configs/rd-03d-esp32s3.yaml /config/esphome/

# 2. Create secrets.yaml
cp configs/secrets.yaml.example /config/esphome/secrets.yaml

# 3. Edit your WiFi credentials
nano /config/esphome/secrets.yaml
```

**For Standalone ESPHome:**

```bash
# Install via command line
esphome run configs/rd-03d-esp32s3.yaml
```

### 3. Add to Home Assistant

Device will be automatically discovered after first boot:
1. Go to **Settings** → **Devices & Services**
2. Click **ESPHome** integration
3. Configure **"RD-03D Sensor Test"**

---

## ⚙️ Configuration

### Basic Setup

Edit `secrets.yaml`:

```yaml
wifi_ssid: "YourWiFiSSID"
wifi_password: "YourWiFiPassword"
```

### Advanced Options

See [docs/advanced-configuration.md](docs/advanced-configuration.md) for:
- Custom GPIO pins
- Update interval tuning
- Debug logging
- Multi-sensor setups

---

## 📊 Sensors

The integration provides the following entities in Home Assistant:

| Entity | Unit | Description | Device Class |
|--------|------|-------------|--------------|
| `sensor.distance` | cm | Distance to target | distance |
| `sensor.x_position` | mm | Horizontal position | - |
| `sensor.y_position` | mm | Depth/range position | - |
| `sensor.angle` | ° | Angular position (-180 to +180) | - |
| `sensor.speed` | cm/s | Movement speed | - |
| `sensor.distance_resolution` | mm | Detection resolution | - |
| `binary_sensor.target_detected` | - | Presence detection | occupancy |
| `text_sensor.status` | - | System status | - |

### Additional System Sensors

- WiFi Signal Strength
- IP Address
- Uptime
- ESPHome Version

---

## 📖 Documentation

- 📘 [Hardware Setup Guide](docs/hardware-setup.md) - Detailed wiring and mounting
- 🔧 [Troubleshooting Guide](docs/troubleshooting.md) - Common issues and solutions
- 📐 [Coverage Analysis](docs/coverage-analysis.md) - Range and angle calculations
- ⚙️ [Advanced Configuration](docs/advanced-configuration.md) - Customization options

---

## 🐛 Troubleshooting

### Quick Fixes

| Issue | Solution |
|-------|----------|
| "No Data" | Check TX/RX crossover wiring |
| "Buffer overflow" | Normal, usually harmless |
| "Invalid header" | Check cable quality/length |
| False triggers | Add 5s delay in automations |

For detailed troubleshooting, see [docs/troubleshooting.md](docs/troubleshooting.md)

---

## 📝 Examples

### Basic Automation - Turn on Light

```yaml
automation:
  - alias: "Light ON - Motion Detected"
    trigger:
      - platform: state
        entity_id: binary_sensor.rd_03d_target_detected
        to: 'on'
    action:
      - service: light.turn_on
        target:
          entity_id: light.living_room
```

### Distance-based Brightness

```yaml
automation:
  - alias: "LED Brightness by Distance"
    trigger:
      - platform: state
        entity_id: sensor.rd_03d_distance
    action:
      - service: light.turn_on
        target:
          entity_id: light.living_room
        data:
          brightness: >
            {% set distance = states('sensor.rd_03d_distance') | float %}
            {% set max_dist = 800 %}
            {{ ((max_dist - distance) / max_dist * 255) | int }}
```

More examples in [examples/home-assistant-automations.yaml](examples/home-assistant-automations.yaml)

---

## 🎯 Technical Specifications

| Parameter | Value |
|-----------|-------|
| **Frequency** | 24.00 - 24.25 GHz (ISM Band) |
| **Max Range** | 8 meters |
| **Min Range** | ~0.6 meters |
| **Detection Angle** | ±60° horizontal, ±30° vertical |
| **Range Resolution** | 0.75m |
| **Accuracy** | ±0.15m |
| **Update Rate** | ~20 Hz (50ms) |
| **Power** | 5V, ≥200mA |
| **UART** | 256000 bps, 8N1, 3.3V TTL |
| **Connector** | 1×4P-1.25mm |

---

## 🛠️ Firmware Configuration

The sensor is automatically configured for **Single Target Detection Mode** on boot. The firmware sends initialization commands via UART to optimize performance for home automation use cases.

### Frame Structure

- **Header:** `0xAA 0xFF 0x03 0x00`
- **Data:** 24 bytes (3 targets × 8 bytes)
- **Tail:** `0x55 0xCC`

---

## 📸 Screenshots

<!-- Add screenshots here -->
<div align="center">

*Home Assistant Dashboard with RD-03D Sensors*

*Coverage Area Visualization*

</div>

> 📷 Add your own screenshots by creating an `images/` folder

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### How to Contribute

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔀 Open a Pull Request

---

## 🗺️ Roadmap

- [ ] Multi-target tracking support
- [ ] LED fade effects integration
- [ ] MQTT support (optional)
- [ ] Web configuration interface
- [ ] Additional sensor models support
- [ ] PCB design for easy mounting

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Home Assistant Community** - For inspiration and support
- **ESPHome Project** - For the excellent framework
- **AI Assistance** - Claude (Anthropic) for development help

---

## ⚡ Support

- 🐛 **Bug Reports:** [Open an issue](https://github.com/yourusername/rd-03d-esphome/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/yourusername/rd-03d-esphome/discussions)
- 📧 **Contact:** Create an issue for questions

---

## ⚠️ Important Notes

- ⚡ **5V Required:** Sensor will NOT work with 3.3V
- 🔀 **Crossover Wiring:** TX/RX pins must be crossed
- 📏 **Min Distance:** ~60cm minimum detection range
- 🏷️ **Orientation:** Ai-Thinker logo should face up
- 🛡️ **EMI:** Keep away from metal objects and strong electronics

---

<div align="center">

**⭐ Star this repo if you find it helpful!**

Made with ❤️ for the Home Assistant Community

[⬆ Back to Top](#rd-03d-mmwave-radar-esphome-integration)

</div>
