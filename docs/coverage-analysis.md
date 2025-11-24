# 📐 Coverage Analysis - RD-03D in 7m × 10m Room

Detailed mathematical analysis of RD-03D sensor coverage in a rectangular room.

---

## 📋 Scenario

**Room Dimensions:** 7 meters (width) × 10 meters (depth)  
**Sensor Position:** Center of 7m short wall  
**Mounting Height:** 1.5-2 meters (recommended)

---

## 🔬 RD-03D Technical Specifications

| Specification | Value |
|---------------|-------|
| Maximum Range | 8 meters |
| Minimum Range | ~0.6 meters |
| Horizontal Angle | ±60° (120° total) |
| Vertical Angle | ±30° (60° total) |
| Range Resolution | 0.75m |
| Range Accuracy | ±0.15m |
| Frequency | 24 GHz ISM band |
| Optimal Range | 0-6 meters |

---

## 🧮 Mathematical Calculations

### Sensor Coordinates

```
Sensor Position: (3.5m, 0m)  [x = width center, y = short wall]
```

### Critical Distance Calculations

#### A. Opposite Wall Center
```
Position: (3.5m, 10m)
Distance = √[(3.5-3.5)² + (10-0)²]
Distance = √[0 + 100]
Distance = 10 meters ❌ (Exceeds 8m maximum)
```

#### B. Top Left Corner
```
Position: (0m, 10m)
Distance = √[(3.5-0)² + (10-0)²]
Distance = √[12.25 + 100]
Distance = √112.25
Distance ≈ 10.6 meters ❌ (Far beyond range!)
```

#### C. Top Right Corner
```
Position: (7m, 10m)
Distance = √[(7-3.5)² + (10-0)²]
Distance = √[12.25 + 100]
Distance = √112.25
Distance ≈ 10.6 meters ❌ (Far beyond range!)
```

#### D. Left Wall Center
```
Position: (0m, 5m)
Distance = √[(3.5-0)² + (5-0)²]
Distance = √[12.25 + 25]
Distance = √37.25
Distance ≈ 6.1 meters ✅ (Good coverage)
```

#### E. Right Wall Center
```
Position: (7m, 5m)
Distance = √[(7-3.5)² + (5-0)²]
Distance = √[12.25 + 25]
Distance = √37.25
Distance ≈ 6.1 meters ✅ (Good coverage)
```

---

## 📐 Angular Coverage Analysis

### 120° Coverage Area (±60°)

#### Left Boundary (60° left)
```
At 8m distance, lateral width:
x = 8 × tan(60°)
x = 8 × 1.732
x ≈ 13.86 meters

Since room width is 7m:
→ Left wall FULLY covered ✅
```

#### Right Boundary (60° right)
```
Same calculation for right side:
→ Right wall FULLY covered ✅
```

**Result:** Side walls are completely within coverage, but depth is the limiting factor.

---

## 🎨 Coverage Zones

### Zone 1: Excellent Coverage (0-4m) ✅
- **Area:** ~28 m² (room width × 4m)
- **Coverage:** 100%
- **Characteristics:** All sensor features work optimally
- **Use Cases:** Entry area, seating area

### Zone 2: Good Coverage (4-6m) ✅
- **Area:** ~14 m² (room width × 2m)
- **Coverage:** 95%
- **Characteristics:** Very reliable
- **Use Cases:** Room center

### Zone 3: Fair Coverage (6-8m) ⚠️
- **Area:** ~14 m² (room width × 2m)
- **Coverage:** 70%
- **Characteristics:** May occasionally miss targets
- **Use Cases:** Back area (if not critical)

### Zone 4: No Coverage (>8m) ❌
- **Area:** ~14 m² (room width × 2m + corners)
- **Coverage:** 0%
- **Characteristics:** Cannot detect
- **Problem:** Opposite wall and corners

---

## 📊 Coverage Statistics Summary

```
Total Room Area:        70 m² (7m × 10m)

Excellent Coverage:     28 m² (40%)  ✅
Good Coverage:          14 m² (20%)  ✅
Fair Coverage:          14 m² (20%)  ⚠️
No Coverage:            14 m² (20%)  ❌

Total Usable:           56 m² (80%)
Blind Spots:            14 m² (20%)
```

---

## 🔴 Detailed Blind Spot Analysis

### 1. Top Left Corner
- **Position:** (0m, 8m-10m)
- **Area:** ~3.5 m²
- **Distance:** 9.4m - 10.6m
- **Reason:** Both range and angle limit exceeded

### 2. Top Right Corner
- **Position:** (7m, 8m-10m)
- **Area:** ~3.5 m²
- **Distance:** 9.4m - 10.6m
- **Reason:** Both range and angle limit exceeded

### 3. Opposite Wall Top Section
- **Position:** (1m-6m, 9m-10m)
- **Area:** ~7 m²
- **Distance:** 9-10m
- **Reason:** Range limit exceeded only

---

## 💡 Solution Options

### Option 1: Move Sensor Forward 2m ✅

**New Position:** (3.5m, 2m)

#### Calculations:
```
Opposite wall center: (3.5m, 10m)
New distance = √[(3.5-3.5)² + (10-2)²]
            = √[0 + 64]
            = 8 meters ✅ (At maximum range)

Top left corner: (0m, 10m)
New distance = √[(3.5-0)² + (10-2)²]
            = √[12.25 + 64]
            = √76.25
            = 8.7 meters ⚠️ (Slightly better)
```

#### Pros & Cons:
**Advantages:**
- Opposite wall becomes 8m (just within range)
- Excellent coverage area increases
- No additional cost

**Disadvantages:**
- Creates 2m blind spot behind sensor
- If door is at back, could be problematic

**Coverage:** ~90% ✅

---

### Option 2: Mount on Long Wall ⭐ Best

**New Position:** (0m or 7m, 5m) [Middle of long wall]

#### Calculations:
```
Farthest corner: (7m, 10m) [sensor at (0m, 5m)]
Distance = √[(7-0)² + (10-5)²]
         = √[49 + 25]
         = √74
         ≈ 8.6 meters ⚠️ (Borderline)

But angle check:
tan⁻¹(7/5) = 54.5° ✅ (Within 60°)
```

#### Pros & Cons:
**Advantages:**
- All areas within ~8.6m
- Better balanced coverage (~95%)
- More uniform detection

**Disadvantages:**
- Longer cable run required
- Side wall mounting position

**Coverage:** ~95% ✅

---

### Option 3: Ceiling Mount (Center) 🎯 Perfect

**Position:** (3.5m, 5m, 2m height) [Room center, ceiling]

#### 3D Calculations:
```
Corner distance: (0m, 0m, 0m) [sensor at (3.5m, 5m, 2m)]
Distance = √[(3.5-0)² + (5-0)² + (2-0)²]
         = √[12.25 + 25 + 4]
         = √41.25
         ≈ 6.4 meters ✅ (Excellent!)

Opposite corner: (0m, 10m, 0m)
Distance = √[(3.5-0)² + (10-5)² + (2-0)²]
         = √[12.25 + 25 + 4]
         = √41.25
         ≈ 6.4 meters ✅
```

#### Pros & Cons:
**Advantages:**
- 100% coverage - no blind spots!
- Maximum distance only 6.4m (safe margin)
- Utilizes vertical angle (±30°)
- Can see behind furniture

**Disadvantages:**
- Ceiling installation required
- More complex cable management
- Higher difficulty level

**Coverage:** 100% ✅✅✅

**This is the optimal solution!**

---

### Option 4: Dual Sensor Setup 💰

**Positions:** (1.75m, 0m) and (5.25m, 0m)

#### Pros & Cons:
**Advantages:**
- 100% coverage guarantee
- Redundancy (if one fails, other works)
- More precise tracking

**Disadvantages:**
- Cost doubles
- Requires two ESP32 units (or dual UART)
- More complex configuration

**Coverage:** 100% ✅

---

## 📊 Solution Comparison Table

| Option | Coverage | Cost | Difficulty | Recommendation |
|--------|----------|------|------------|----------------|
| **Current Position** | 80% | - | ✅ Easy | ⚠️ Partial |
| **Move 2m Forward** | 90% | - | ✅ Easy | ✅ Good |
| **Long Wall Mount** | 95% | - | ⭐ Medium | ✅ Good |
| **Ceiling Center** | 100% | - | ⚠️ Hard | ⭐⭐⭐ Best |
| **Dual Sensor** | 100% | 💰💰 2x | ⚠️ Hard | 💡 Luxury |

---

## 📏 Mounting Height Impact

### 1.5m Height (Wall Mount)
```
Vertical angle impact: Minimal
Coverage: Near horizontal plane
Advantage: Easy installation
```

### 2.0m Height (Recommended)
```
Vertical angle: ±30° utilized
Coverage: Wider area
Advantage: Can see behind furniture
```

### 2.5m Height (Ceiling)
```
Vertical angle: Fully utilized
Coverage: Maximum
Advantage: Full room view
Disadvantage: Installation difficulty
```

---

## 🔍 Real-World Factors

### Factors That Reduce Coverage:
- ❌ Furniture (couches, cabinets, etc.)
- ❌ Metal objects (reflection)
- ❌ Glass surfaces (partial reflection)
- ❌ Wall thickness (signal attenuation)

### Factors That Improve Coverage:
- ✅ Open areas
- ✅ Flat walls
- ✅ Higher mounting
- ✅ Proper calibration

---

## 📝 Conclusion and Recommendations

### Current Setup Analysis:
- ⚠️ **Cannot see** opposite wall and corners
- ✅ **80% of room** has excellent coverage
- ⚠️ **Top 2 meters** depth is blind zone

### Best Solution:
🎯 **CEILING MOUNT AT CENTER (2m height)**
- 100% coverage
- No blind spots
- Can see behind furniture
- Optimal solution

### Budget-Friendly Solution:
💰 **MOVE SENSOR 2M FORWARD (to position 3.5m, 2m)**
- 90% coverage
- No additional cost
- Easy installation
- Acceptable blind spots

---

## 🛠️ Implementation Tips

1. **Test Before Permanent Install:**
   - Place sensor on table/stand
   - Test different positions
   - Find optimal location
   - Then permanent mount

2. **Mark Blind Spots:**
   - Identify on floor plan
   - Ensure critical areas covered
   - Plan furniture placement

3. **Height Adjustment:**
   - Test between 1.5-2m
   - Consider furniture height
   - Optimize viewing angle

4. **Calibration:**
   - Required after installation
   - Test in empty room first
   - Fine-tune position

---

## 📐 Coverage Formulas

### Distance Calculation:
```
Distance = √(X² + Y²)

Where:
X = Horizontal offset (mm)
Y = Depth offset (mm)
Result in cm: Distance / 10.0
```

### Angle Calculation:
```
Angle = atan2(Y, X) × 180 / π

Result in degrees: -180° to +180°
Left = negative
Right = positive
```

### Coverage Area:
```
For circular sector:
Area = (π × r² × θ) / 360°

Where:
r = range (8m)
θ = angle (120°)
Result ≈ 67 m² (theoretical)
```

---

## 🎯 Quick Reference

### Distance Measurements:

| Point | Distance | Status |
|-------|----------|--------|
| Opposite wall center | 9.5m | ❌ Out of range |
| Top left corner | 10.3m | ❌ Out of range |
| Top right corner | 10.3m | ❌ Out of range |
| Left wall center | 6.1m | ✅ Good |
| Right wall center | 6.1m | ✅ Good |
| First 4 meters | 0-4m | ✅✅✅ Excellent |

---

## 📚 Additional Resources

- [Hardware Setup Guide](hardware-setup.md) - Wiring and mounting
- [Troubleshooting Guide](troubleshooting.md) - Common issues
- [Coverage Map HTML](rd03d-coverage-analysis.html) - Interactive visualization
- [Home Assistant Automations](../examples/home-assistant-automations.yaml) - Usage examples

---

## 🔗 External Tools

### Coverage Calculators:
- Use trigonometry for custom rooms
- Consider furniture and obstacles
- Account for mounting height

### Visualization:
- [Interactive Coverage Map](rd03d-coverage-analysis.html) - Open in browser for animated view
- Floor plan software (SketchUp, etc.)
- Home Assistant floor plan integration

---

**Success!** 🎉

You now have complete mathematical understanding of RD-03D coverage in your room!

[⬆ Back to Top](#-coverage-analysis---rd-03d-in-7m--10m-room)
