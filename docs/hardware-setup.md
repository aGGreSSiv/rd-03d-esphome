# 🔌 Hardware Setup Guide

Complete guide for connecting and configuring the RD-03D mmWave radar sensor with ESP32/ESP32-S3.

---

## 📋 Table of Contents

- [Components Required](#components-required)
- [Pin Connections](#pin-connections)
- [Wiring Diagram](#wiring-diagram)
- [Power Requirements](#power-requirements)
- [Mounting Guidelines](#mounting-guidelines)
- [Cable Specifications](#cable-specifications)
- [Verification Steps](#verification-steps)

---

## Components Required

### Essential Components

| Item | Specification | Quantity | Notes |
|------|--------------|----------|-------|
| RD-03D Sensor | 24GHz mmWave | 1 | Ai-Thinker module |
| ESP32-S3 DevKit C-1 | or ESP32 | 1 | S3 recommended |
| Jumper Wires | Female-Female | 4 | <50cm length |
| USB Cable | USB-C or Micro-USB | 1 | For power/programming |
| Power Supply | 5V, ≥500mA | 1 | USB adapter works |

### Optional Components

- Breadboard (for prototyping)
- Mounting bracket
- Enclosure/case
- 100nF + 10µF capacitors (noise filtering)

---

## Pin Connections

### ESP32-S3 DevKit C-1 → RD-03D

```
┌──────────────────────────────────────────┐
│           ESP32-S3 DevKit C-1            │
│                                          │
│  [5V]  ──────────────────────►  [VCC]   │  RD-03D
│                                          │
│  [GND] ──────────────────────►  [GND]   │
│                                          │
│  [GPIO16] (RX) ◄──────────────  [TXD]   │  ⚠️ Crossover!
│                                          │
│  [GPIO17] (TX) ──────────────►  [RXD]   │  ⚠️ Crossover!
│                                          │
└──────────────────────────────────────────┘
```

### Pin Function Table

| RD-03D Pin | Function | ESP32 Pin | Direction | Notes |
|------------|----------|-----------|-----------|-------|
| Pin 1 (VCC) | Power 5V | 5V | Input | ≥200mA required |
| Pin 2 (GND) | Ground | GND | - | Common ground |
| Pin 3 (TXD) | UART TX | GPIO16 (RX) | Output | Sensor → ESP |
| Pin 4 (RXD) | UART RX | GPIO17 (TX) | Input | ESP → Sensor |

### ⚠️ Critical: Crossover Wiring

**Must be crossed:**
- Sensor **TXD** → ESP **RX** (GPIO16)
- Sensor **RXD** → ESP **TX** (GPIO17)

**Do NOT connect:**
- TX → TX ❌
- RX → RX ❌

---

## Wiring Diagram

### RD-03D Connector Pinout

```
Top View (Logo Facing Up):
┌─────────────────────────┐
│   [Ai-Thinker Logo]     │  ← Logo must face up
│                         │
│   ┌─┬─┬─┬─┐             │
│   │1│2│3│4│ ← Connector │
└───┴─┴─┴─┴─┴─────────────┘
     │ │ │ │
     │ │ │ └─ Pin 4: RXD (To ESP TX)
     │ │ └─── Pin 3: TXD (To ESP RX)
     │ └───── Pin 2: GND
     └─────── Pin 1: VCC (5V)
```

### Breadboard Connection

```
        RD-03D
          │
    ┌─────┴─────┐
    │ 1 2 3 4   │
    └─┬─┬─┬─┬───┘
      │ │ │ │
      │ │ │ └──────────┐
      │ │ └─────────┐  │
      │ └────────┐  │  │
      └───────┐  │  │  │
              │  │  │  │
        ┌─────┴──┴──┴──┴────┐
        │  ESP32-S3 DevKit  │
        │                   │
        │  5V  GND  16  17  │
        └───────────────────┘
                │
                └─ USB (PC/Adapter)
```

---

## Power Requirements

### RD-03D Power Specifications

| Parameter | Value | Notes |
|-----------|-------|-------|
| Operating Voltage | 5V ± 0.25V | **3.3V will NOT work** |
| Current Draw (Idle) | ~180mA | Normal operation |
| Current Draw (Peak) | ~250mA | During initialization |
| Minimum Current | ≥200mA | Must be available |

### Power Source Options

#### Option 1: USB Power (Testing) ✅

```
USB Port (5V, 500mA) → ESP32-S3 → RD-03D
```

**Pros:**
- Easy setup
- Sufficient current
- Good for testing

**Cons:**
- Cable length affects voltage
- Not ideal for permanent installation

#### Option 2: External 5V Adapter (Production) ⭐

```
5V/1A Adapter → ESP32-S3 (VIN) → RD-03D
```

**Pros:**
- Reliable
- Stable voltage
- Best for 24/7 operation

**Recommended:** Use 5V/1A (1000mA) adapter

#### Option 3: Battery + Buck Converter (Portable) 🔋

```
3.7V LiPo → 5V Buck Converter → ESP32-S3 → RD-03D
```

**Pros:**
- Portable
- No wires

**Cons:**
- Short battery life (4-6 hours)
- Requires quality buck converter
- More complex setup

---

## Cable Specifications

### Cable Length

| Length | Performance | Use Case |
|--------|-------------|----------|
| 10-20 cm | ✅ Excellent | Recommended |
| 20-30 cm | ✅ Good | Acceptable |
| 30-50 cm | ⚠️ Fair | Maximum recommended |
| >50 cm | ❌ Poor | Signal degradation |

### Cable Quality

**Recommended:**
- 28 AWG or thicker
- Shielded cable for TX/RX (optional but better)
- Quality Female-Female Dupont connectors

**Avoid:**
- Thin, cheap cables
- Long cables
- Damaged connectors

---

## Mounting Guidelines

### Sensor Orientation

```
┌────────────────────────────────────────┐
│        Wall/Ceiling Mount              │
│                                        │
│    ┌──────────────┐                   │
│    │ Ai-Thinker  │  ← Logo facing up │
│    │    [RD-03D]  │                   │
│    └──────┬───────┘                   │
│           │                           │
│           │ 1.5-2m height             │
│           │                           │
│           ▼                           │
│    ┌─────────────────┐                │
│    │                 │                │
│    │  Detection Area │                │
│    │   ±60° horiz.   │                │
│    │   ±30° vert.    │                │
│    │    8m range     │                │
│    │                 │                │
│    └─────────────────┘                │
└────────────────────────────────────────┘
```

### Mounting Height

| Height | Use Case | Coverage |
|--------|----------|----------|
| 1.5m | Wall mount | Good horizontal coverage |
| 2.0m | Recommended | Balanced coverage |
| 2.5m | Ceiling mount | Maximum coverage |

### Placement Tips

✅ **Good Locations:**
- Centered on wall/ceiling
- Clear line of sight
- Away from corners
- 1.5-2m height

❌ **Avoid:**
- Behind metal objects
- Next to WiFi routers
- Near microwave ovens
- Extreme temperatures
- Direct sunlight

---

## Electrical Specifications

### UART Signals

| Parameter | Value |
|-----------|-------|
| Logic Level | 3.3V TTL |
| Baud Rate | 256000 bps |
| Data Bits | 8 |
| Parity | None |
| Stop Bits | 1 |
| Flow Control | None |

> ℹ️ **Note:** Although RD-03D runs on 5V, UART signals are 3.3V TTL - perfect for ESP32!

---

## Verification Steps

### Physical Inspection

1. **Check all connections:**
   ```
   □ VCC → 5V connected
   □ GND → GND connected
   □ TXD → GPIO16 (RX) crossover ✓
   □ RXD → GPIO17 (TX) crossover ✓
   □ All wires firmly seated
   □ No loose connections
   □ Cable length < 50cm
   □ Sensor logo facing up
   ```

2. **Visual inspection:**
   - No bent pins
   - No damaged wires
   - Clean connectors
   - Proper cable routing

### Power Check

Using a multimeter:

```
VCC Pin: Should measure 4.75V - 5.25V
         ✅ 5.0V → Perfect
         ⚠️ 4.5V → Low, check cable/supply
         ❌ 3.3V → WRONG! Needs 5V
```

### Signal Check

Using oscilloscope or logic analyzer:

```
TXD Pin: Should show 3.3V TTL signal at 256000 baud
         Continuous data stream (~50ms period)
         
RXD Pin: Should show command acknowledgment
```

### Current Check

Using multimeter in series:

```
Normal: 180-200 mA ✅
Peak:   250 mA (startup) ✅
Idle:   ~180 mA ✅

❌ 0 mA → No power/short circuit
❌ >300 mA → Sensor fault
```

---

## Troubleshooting Hardware

### No Power

**Symptoms:**
- No LED on ESP32
- No sensor activity

**Solutions:**
1. Check USB cable
2. Try different USB port
3. Measure voltage at VCC pin
4. Check for loose connections

### Intermittent Connection

**Symptoms:**
- Random disconnects
- Missing data frames

**Solutions:**
1. Shorten cables
2. Improve cable quality
3. Add ferrite beads
4. Check for loose wires

### EMI Issues

**Symptoms:**
- False detections
- Erratic readings

**Solutions:**
1. Move away from WiFi router (>30cm)
2. Add ground plane
3. Use shielded cables
4. Add filter capacitors

---

## Advanced Setup

### Noise Filtering

Add capacitors near sensor:

```
VCC ──┬──[100nF]──┬── GND
      │           │
      └──[10µF]───┘
```

### Multiple Sensors

For multiple sensors:
- Keep >2m apart
- Use different GPIO pins
- Configure separate UART instances
- Label each sensor clearly

---

## Safety Notes

⚠️ **Warnings:**

- **ESD Sensitive:** Handle with care
- **5V Only:** Do not apply >5.5V
- **Heat:** Sensor may get warm (normal)
- **RF Emissions:** 24GHz (legal ISM band)

✅ **Certifications:**

- FCC Part 15 compliant
- CE compliant
- RoHS compliant
- ISM Band (license-free)

---

## Technical Drawings

### Sensor Dimensions

```
┌─────────────────────────────────┐
│                                 │
│     15mm × 44mm × 3mm           │
│     Weight: ~8 grams            │
│                                 │
│     Mounting holes: N/A         │
│     Use adhesive or bracket     │
│                                 │
└─────────────────────────────────┘
```

---

## Next Steps

Once hardware is connected:

1. ✅ Verify all connections
2. ✅ Power on ESP32
3. ✅ Upload ESPHome configuration
4. ✅ Check logs for "RD-03D initialized"
5. ✅ Add to Home Assistant

See [Troubleshooting Guide](troubleshooting.md) if you encounter issues.

---

**Hardware setup complete!** 🔧 Ready for [software configuration](../README.md#quick-start).

[⬆ Back to Top](#-hardware-setup-guide)
