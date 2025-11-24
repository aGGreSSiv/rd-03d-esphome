# 🔧 Troubleshooting Guide

Common issues and solutions for RD-03D ESPHome integration.

---

## 📋 Quick Diagnostic Checklist

Before diving into specific issues, run through this checklist:

```
Hardware:
□ All wires firmly connected
□ TX/RX crossover correct (sensor TX → ESP RX)
□ 5V power supply (NOT 3.3V)
□ Cable length < 50cm
□ Sensor logo facing up

Software:
□ ESPHome version 2024.10+
□ YAML configuration correct
□ secrets.yaml has WiFi credentials
□ ESP32 successfully compiled
□ Device shows in Home Assistant

Sensor:
□ "RD-03D initialized" in logs
□ Frame data visible in logs
□ No continuous errors
□ Target detection works
```

---

## 🚨 Common Issues

### Issue 1: "No Data for 5 seconds"

**Symptoms:**
```
[WARN] RD03D: No data for 5 seconds! Check Connections
sensor.status → "No Data - Check Connections"
```

**Root Cause:** UART not receiving data from sensor

**Solutions:**

#### Step 1: Check TX/RX Crossover

Most common mistake! Verify:

```
✅ Sensor TXD → ESP GPIO16 (RX)
✅ Sensor RXD → ESP GPIO17 (TX)

❌ NOT: TXD → TX
❌ NOT: RXD → RX
```

#### Step 2: Check Power

```bash
# Measure voltage at sensor VCC pin
# Should be: 4.75V - 5.25V

✅ 5.0V → Good
⚠️ 4.5V → Low (check cable/supply)
❌ 3.3V → WRONG! Sensor needs 5V
```

#### Step 3: Check Cable Quality

```
• Try shorter cables (<30cm)
• Replace damaged wires
• Ensure firm connections
• Check for broken connectors
```

#### Step 4: Test with Different Pins

```yaml
# Try alternative GPIO pins
uart:
  tx_pin: GPIO19  # Instead of GPIO17
  rx_pin: GPIO18  # Instead of GPIO16
```

---

### Issue 2: "Buffer Overflow"

**Symptoms:**
```
[WARN] RD03D: Buffer overflow! Resetting...
```

**Root Cause:** UART buffer filling faster than processing

**Is This Bad?** 
- **No** - If it happens occasionally (<1% of frames)
- **Yes** - If it happens continuously (>5% of frames)

**Solutions:**

#### Occasional Overflows (Normal)

```yaml
# No action needed!
# This is expected behavior
# System auto-recovers
```

#### Frequent Overflows (Problem)

```yaml
# Increase buffer size
uart:
  rx_buffer_size: 512  # Default is 256
```

Or reduce update frequency:

```yaml
# Slow down main loop
interval:
  - interval: 100ms  # Was 50ms
    then:
      - lambda: |-
          # ... parsing code
```

---

### Issue 3: "Invalid Header"

**Symptoms:**
```
[WARN] RD03D: Invalid header: 0x00 0x00 0x00 0x00
Error Rate: >5%
```

**Root Cause:** Corrupted data frames

**Solutions:**

#### Check Cable Quality

```
Common causes:
• Long cables (>50cm)
• Poor quality wires
• Electromagnetic interference
• Loose connections
```

**Fix:**
1. Use shorter cables (<30cm)
2. Use quality jumper wires
3. Keep away from power cables
4. Add ferrite beads if needed

#### Reinitialize Sensor

Use Home Assistant button:
```
button.reinitialize_sensor → Press
```

Or restart ESP32:
```
button.restart_esp32 → Press
```

#### Check Baud Rate

Verify UART configuration:

```yaml
uart:
  baud_rate: 256000  # Must be exactly this
```

---

### Issue 4: Sensor Values Show "Unknown"

**Symptoms:**
```
sensor.distance → unknown
sensor.angle → unknown
binary_sensor.target_detected → unknown
```

**Root Cause:** Template sensors not receiving data

**Solutions:**

#### Check Logs for Errors

```bash
esphome logs your-config.yaml
```

Look for:
- "RD-03D initialized" ← Should appear
- "Frame #X" ← Should see frame counts
- Any WARN or ERROR messages

#### Verify Sensor Detection

Wave in front of sensor and check logs:

```
[INFO] RD03D: Frame: 50, Distance: 123.4 cm, ...
```

If no frames appear → Hardware issue (see Issue 1)

#### Wait for First Detection

On first boot:
- Sensors may show "unknown" initially
- Wait for first target detection
- Values will populate once target seen

---

### Issue 5: False Detections / Ghost Targets

**Symptoms:**
```
binary_sensor.target_detected → Flickers on/off
Detections when room is empty
Random distance readings
```

**Root Cause:** Environmental interference or normal sensor behavior

**Solutions:**

#### Add Automation Delays

```yaml
automation:
  - alias: "Light ON - Motion"
    trigger:
      - platform: state
        entity_id: binary_sensor.target_detected
        to: 'on'
        for:
          seconds: 2  # Wait 2 seconds
    action:
      - service: light.turn_on
        target:
          entity_id: light.living_room

  - alias: "Light OFF - No Motion"
    trigger:
      - platform: state
        entity_id: binary_sensor.target_detected
        to: 'off'
        for:
          seconds: 30  # Wait 30 seconds
    action:
      - service: light.turn_off
        target:
          entity_id: light.living_room
```

#### Improve Mounting

```
✅ Point away from:
   • Windows (glass reflections)
   • Metal surfaces
   • Fans/moving objects
   • Other sensors

✅ Mount with:
   • Logo facing up
   • Clear line of sight
   • Stable position
   • 1.5-2m height
```

#### Normal Behavior

RD-03D characteristics:
- May briefly lose target
- Sensitive to small movements
- Can detect through thin walls
- Affected by metal objects

---

### Issue 6: Distance Readings Inaccurate

**Symptoms:**
```
Actual distance: 2m
Sensor reading: 2.5m (off by 50cm)
```

**Root Cause:** Sensor calibration or mounting

**Solutions:**

#### Check Sensor Orientation

```
Logo must face UP
If sideways or upside down → Readings will be wrong
```

#### Verify Mounting Angle

```
Best: Perpendicular to target (0° angle)
Okay: Slight angle (±15°)
Bad: Sharp angle (>30°)
```

#### Expected Accuracy

```
Accuracy: ±15cm (spec: ±15cm)
Resolution: 75cm steps

Example:
Actual: 2.00m
Reading: 1.85m - 2.15m ✅ Normal
Reading: 1.50m or 2.50m ❌ Issue
```

#### Reinitialize Sensor

```yaml
# Press button in Home Assistant
button.reinitialize_sensor
```

---

### Issue 7: WiFi Connection Fails

**Symptoms:**
```
[ERROR] WiFi: Connection failed
ESP32 creates fallback hotspot
Can't add to Home Assistant
```

**Solutions:**

#### Check credentials

```yaml
# secrets.yaml
wifi_ssid: "YourWiFiName"      # Check for typos
wifi_password: "YourPassword"  # Check for typos
```

#### Use Fallback Hotspot

1. Look for WiFi network: `"Rd-03D-Sensor-Test"`
2. Connect with password: `"vL6oI5g9csXi"`
3. Configure WiFi via web interface
4. Device will reconnect

#### Check WiFi Band

```
✅ 2.4 GHz → Supported
❌ 5 GHz → NOT supported by ESP32
```

#### Signal Strength

```bash
# Check signal in logs
[INFO] WiFi: Signal strength: -48 dB ← Good
[WARN] WiFi: Signal strength: -80 dB ← Weak
```

**Solution:** Move closer to router or add WiFi extender

---

### Issue 8: OTA Update Fails

**Symptoms:**
```
[ERROR] OTA: Upload failed
[ERROR] OTA: Connection timeout
```

**Solutions:**

#### Use USB for Critical Updates

```bash
# Safer than OTA for major changes
esphome run your-config.yaml
```

#### Check Network Stability

```
• Ensure ESP32 online
• Check Home Assistant can ping device
• Verify no firewall blocking
```

#### Increase Timeout

```yaml
ota:
  - platform: esphome
    password: "your_password"
    safe_mode: true  # Enable safe mode
```

---

## 🔍 Advanced Diagnostics

### Enable Debug Logging

```yaml
logger:
  level: DEBUG  # Most verbose
```

View logs:
```bash
esphome logs your-config.yaml
```

### Monitor Frame Statistics

Every 10,000 frames you'll see:

```
[INFO] RD03D: Stats - Total: 10000, Errors: 5 (0.05%)
```

**Acceptable error rates:**
- <1%: ✅ Excellent
- 1-5%: ⚠️ Acceptable
- >5%: ❌ Problem - check hardware

### Raw UART Debug

Enable UART debug:

```yaml
uart:
  debug:
    direction: BOTH
    dummy_receiver: true
    after:
      delimiter: [0x55, 0xCC]
    sequence:
      - lambda: |-
          UARTDebug::log_hex(direction, bytes, ':');
```

This shows raw hex data:

```
[DEBUG] <<< AA:FF:03:00:A4:82:EA:82:00:00:68:01:...
```

---

## 🛠️ Testing Tools

### Hardware Tests

#### Continuity Test (Multimeter)

```
Test each wire for continuity:
VCC: ESP 5V ← → Sensor VCC (should beep)
GND: ESP GND ← → Sensor GND (should beep)
```

#### Voltage Test

```
Sensor VCC: 4.75V - 5.25V ✅
ESP 3.3V: 3.2V - 3.4V ✅
```

#### Current Test

```
Connect multimeter in series with VCC
Normal draw: 180-200mA ✅
```

### Software Tests

#### Compilation Test

```bash
esphome compile your-config.yaml
# Should complete without errors
```

#### Validation Test

```bash
esphome config your-config.yaml
# Checks YAML syntax
```

---

## 📊 Error Code Reference

| Error | Meaning | Solution |
|-------|---------|----------|
| Buffer overflow | UART too fast | Increase buffer or slow update |
| Invalid header | Corrupted data | Check cables, reinit sensor |
| Frame too short | Incomplete frame | Normal, auto-recovers |
| No data for 5s | No UART data | Check TX/RX crossover |
| Connection failed | WiFi issue | Check credentials |
| OTA failed | Network issue | Use USB instead |

---

## 🔄 Reset Procedures

### Soft Reset (Sensor Only)

```yaml
# Use button in Home Assistant
button.reinitialize_sensor → Press
```

### Full Reset (ESP32)

```yaml
# Restart entire device
button.restart_esp32 → Press
```

### Factory Reset

1. Re-upload configuration:
```bash
esphome run your-config.yaml
```

2. Or press boot button on ESP32 for 10 seconds

---

## 📞 Getting Help

### Before Asking for Help

1. ✅ Read this troubleshooting guide
2. ✅ Check logs for errors
3. ✅ Verify hardware connections
4. ✅ Test with default configuration

### Information to Provide

When creating an issue, include:

```markdown
**Hardware:**
- ESP Board: [e.g., ESP32-S3 DevKit C-1]
- Sensor: [e.g., RD-03D]
- Power: [e.g., USB 5V/500mA]
- Cable length: [e.g., 20cm]

**Software:**
- ESPHome version: [e.g., 2024.10.5]
- Home Assistant version: [e.g., 2024.11.0]
- Configuration: [attach YAML or relevant parts]

**Issue:**
- Description: [clear description]
- When it started: [after update? fresh install?]
- Steps to reproduce: [1, 2, 3...]

**Logs:**
```
[paste relevant log excerpt]
```

**What I've tried:**
- [ ] Checked wiring
- [ ] Restarted device
- [ ] Reinitialized sensor
- [ ] Checked cables
- [ ] Read troubleshooting guide
```

### Where to Ask

- 🐛 **GitHub Issues:** Bug reports
- 💬 **GitHub Discussions:** Questions
- 🏠 **Home Assistant Forums:** Community help
- 💬 **ESPHome Discord:** Real-time chat

---

## 📚 Additional Resources

- [Hardware Setup Guide](hardware-setup.md)
- [Advanced Configuration](advanced-configuration.md)
- [Coverage Analysis](coverage-analysis.md)
- [Home Assistant Automations](../examples/home-assistant-automations.yaml)

---

**Still having issues?** [Create an issue](https://github.com/yourusername/rd-03d-esphome/issues) with details!

[⬆ Back to Top](#-troubleshooting-guide)
