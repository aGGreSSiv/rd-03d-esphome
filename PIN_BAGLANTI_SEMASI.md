# 🔌 RD-03D Pin Bağlantı Şeması ve Teknik Detaylar

## ESP32-S3 DevKit C-1 Pin Bağlantıları

```
┌─────────────────────────────────────────────────────────┐
│                  ESP32-S3 DevKit C-1                    │
│                                                         │
│  [5V]  ────────────────────────────────►  [5V - VCC]   │
│                                           RD-03D        │
│  [GND] ────────────────────────────────►  [GND]        │
│                                                         │
│  [GPIO16] (RX) ◄────────────────────────  [TXD]        │
│                    (Çapraz bağlantı!)                   │
│  [GPIO17] (TX) ─────────────────────────► [RXD]        │
│                    (Çapraz bağlantı!)                   │
└─────────────────────────────────────────────────────────┘

⚠️ DİKKAT: TX/RX çapraz bağlanmalı!
   • Sensör TXD → ESP32 RX (GPIO16)
   • Sensör RXD → ESP32 TX (GPIO17)
```

---

## RD-03D Sensör Pinout

### 1x4P-1.25mm Konnektör (Soldan Sağa)

```
Sensör Üstten Bakış:
┌───────────────────────────┐
│   [Ai-Thinker Logo]       │  ← Logo üstte olmalı
│                           │
│   ┌─┬─┬─┬─┐               │
│   │1│2│3│4│ ← Konnektör   │
└───┴─┴─┴─┴─┴───────────────┘
     │ │ │ │
     │ │ │ └─ Pin 4: RXD (ESP'ye TX bağlanır)
     │ │ └─── Pin 3: TXD (ESP'den RX bağlanır)
     │ └───── Pin 2: GND
     └─────── Pin 1: VCC (5V)
```

### Pin Detayları:

| Pin | Fonksiyon | Açıklama | ESP32 Bağlantısı |
|-----|-----------|----------|------------------|
| 1   | VCC       | 5V güç girişi (≥200mA) | 5V |
| 2   | GND       | Toprak | GND |
| 3   | TXD       | UART TX çıkışı | GPIO16 (RX) |
| 4   | RXD       | UART RX girişi | GPIO17 (TX) |

---

## ESP32-S3 Pin Seçimi

### Neden GPIO16 ve GPIO17?

✅ **Güvenli pinler** - Özel fonksiyonu yok  
✅ **UART desteği** - Hardware UART kullanılabilir  
✅ **Boot sırasında sabit** - Flash download'a karışmaz  
✅ **Çakışma yok** - PSRAM, JTAG gibi özelliklerle çakışmaz  

### Alternatif Pin Seçenekleri (ESP32-S3)

Eğer GPIO16/17 kullanılamıyorsa:

| RX (Sensör TXD) | TX (Sensör RXD) | Notlar |
|-----------------|-----------------|--------|
| GPIO16 | GPIO17 | ✅ Önerilen (kullandığımız) |
| GPIO18 | GPIO19 | ✅ İyi alternatif |
| GPIO20 | GPIO21 | ✅ İyi alternatif |
| GPIO9 | GPIO10 | ⚠️ PSRAM ile çakışabilir |
| GPIO43 | GPIO44 | ❌ USB kullanır |

---

## Kablo Gereksinimleri

### Kablo Uzunluğu:
- **İdeal:** 10-20 cm
- **Maksimum:** 50 cm (daha uzunu sinyal bozulmasına sebep olur)
- **Kullanın:** Dupont Female-Female jumper kablolar

### Kablo Kalitesi:
- ✅ 28 AWG veya daha kalın
- ✅ Ekranlı kablo (RX/TX için önerilir)
- ❌ Ucuz, ince kablolar kaçının

### Bağlantı Kontrol Listesi:
```
□ VCC → 5V bağlı
□ GND → GND bağlı
□ TXD → GPIO16 (RX) çapraz bağlı ✓
□ RXD → GPIO17 (TX) çapraz bağlı ✓
□ Kablolar sağlam oturmuş
□ Kablo uzunluğu < 50 cm
□ Sensör logo üstte
```

---

## Güç Gereksinimleri

### RD-03D Güç Özellikleri:

| Parametre | Değer | Notlar |
|-----------|-------|--------|
| Çalışma Voltajı | 5V ± 0.25V | 3.3V ÇALIŞMAZ! |
| Akım Tüketimi | ≥200mA | USB yeterli |
| Peak Akım | ~250mA | Başlangıçta |
| Boşta Akım | ~180mA | Normal çalışma |

### Güç Kaynağı Seçenekleri:

**1. USB üzerinden (Önerilen - Test için):**
```
USB Port (5V, 500mA) → ESP32-S3 → RD-03D
✅ Kolay
✅ Yeterli akım
⚠️ Uzun kablo kullanırsanız voltaj düşer
```

**2. Harici 5V Adaptör (Prodüksiyon için):**
```
5V/1A Adaptör → ESP32-S3 (VIN) → RD-03D
✅ Güvenilir
✅ Kararlı voltaj
✅ Uzun süre çalışma için ideal
```

**3. LiPo + Buck Converter (Taşınabilir):**
```
3.7V LiPo → 5V Buck Converter → ESP32-S3 → RD-03D
✅ Taşınabilir
⚠️ Pil ömrü kısa (~4-6 saat)
⚠️ Güvenilir buck converter gerekli
```

---

## Elektriksel Özellikler

### UART Sinyalleri:

| Parametre | Değer |
|-----------|-------|
| Logic Level | 3.3V (TTL) |
| Baud Rate | 256000 bps |
| Data Bits | 8 |
| Parity | None |
| Stop Bits | 1 |
| Flow Control | None |

**NOT:** RD-03D 5V ile çalışmasına rağmen UART sinyalleri 3.3V TTL seviyesindedir. ESP32-S3 ile direkt uyumlu!

---

## Montaj Önerileri

### Sensör Yönlendirmesi:

```
┌────────────────────────────────────────┐
│        Duvar/Tavan Montajı             │
│                                        │
│    ┌──────────────┐                   │
│    │ Ai-Thinker  │  ← Logo üstte     │
│    │    [RD-03D]  │                   │
│    └──────┬───────┘                   │
│           │                           │
│           │ 1.5-2m                    │
│           │ yükseklik                 │
│           ▼                           │
│    ┌─────────────────┐                │
│    │                 │                │
│    │  Algılama Alanı │                │
│    │   ±60° yatay    │                │
│    │   ±30° dikey    │                │
│    │    8m mesafe    │                │
│    │                 │                │
│    └─────────────────┘                │
└────────────────────────────────────────┘
```

### Montaj Noktaları:

1. **Yükseklik:** 1.5 - 2 metre (ideal)
2. **Yönlendirme:** Logo üstte, anten aşağı bakmalı
3. **Açı:** Düz (0°) veya hafif aşağı eğik (10-15°)
4. **Uzaklık:** Metal/elektroniklerden >30cm uzak

### Kaçınılacak Yerler:
❌ Metal nesnelerin arkası  
❌ Büyük ekranların yanı  
❌ WiFi router'ların hemen yanı  
❌ Mikrodalga fırın yakını  
❌ Çok sıcak/soğuk ortamlar (−40°C ~ +85°C dışı)  

---

## Test Kurulumu

### Breadboard Kurulumu (Prototip için):

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
                └─ USB (PC/Şarj Adaptörü)
```

### Kablosuz Kurulum (Final):

Sensör ve ESP32 mesafe kazanmak için ayrılabilir:
- RD-03D → Tavana monte
- ESP32 → Güç kaynağına yakın yere
- Aralarında 30-50 cm kablo

---

## Sorun Giderme - Elektriksel

### Voltaj Kontrol:

Multimetre ile ölçün:
```
VCC Pin'i: 4.75V - 5.25V olmalı
           ✅ 5.0V → İdeal
           ⚠️ 4.5V → Düşük, kablo değiştir
           ❌ 3.3V → YANLIŞ! 5V gerekli
```

### Sinyal Kontrol:

Oscilloscope veya logic analyzer ile:
```
TXD Pin'i: 3.3V TTL sinyali, 256000 baud
           Sürekli veri akışı olmalı (~50ms periyot)
```

### Akım Kontrol:

Multimetre ile (seri bağlayarak):
```
Normal: 180-200 mA
Peak:   250 mA (başlangıç)
Bekleme: ~180 mA

❌ 0 mA → Kısa devre veya bağlantı yok
❌ >300 mA → Sensör arızalı
```

---

## EMC ve Girişim Önleme

### Elektromanyetik Uyumluluk:

RD-03D 24GHz radyo dalgaları kullanır:

**İyi komşular:** ✅
- WiFi (2.4/5 GHz)
- Bluetooth (2.4 GHz)
- Zigbee (2.4 GHz)

**Kötü komşular:** ⚠️
- Diğer 24GHz radar sensörler (>2m uzak tutun)
- Güçlü metal yansıtıcılar (yanlış algılamalara sebep olur)

### Girişim Azaltma:

1. **UART kabloları:** Burulmuş (twisted) kablo kullanın
2. **Güç kabloları:** Filtre kondansatör ekleyin (100nF + 10µF)
3. **Topraklama:** GND bağlantısını kısa tutun

---

## Teknik Spesifikasyonlar Özeti

| Özellik | Değer |
|---------|-------|
| Model | RD-03D |
| Frekans | 24.00 - 24.25 GHz (ISM Band) |
| Modülasyon | FMCW |
| Anten | 1T2R (1 TX, 2 RX) PCB Anten |
| Max Menzil | 8 metre |
| Min Menzil | ~60 cm |
| Açı (Yatay) | ±60° (120° toplam) |
| Açı (Dikey) | ±30° (60° toplam) |
| Menzil Çözünürlüğü | 0.75 m |
| Menzil Doğruluğu | ±0.15 m |
| Güncelleme Hızı | ~20 Hz (50ms) |
| Hedef Sayısı | 3 (multi-target mode) |
| Güç | 5V, ≥200mA |
| UART | 256000 bps, 8N1, 3.3V TTL |
| Konnektör | 1×4P-1.25mm |
| Boyut | 15 × 44 mm |
| Ağırlık | ~8 gram |
| Çalışma Sıcaklığı | -40°C ~ +85°C |
| Saklama Sıcaklığı | -40°C ~ +125°C |
| Nem | <90% RH |

---

## Sertifikalar ve Uygunluk

- ✅ 24GHz ISM Band (Lisanssız)
- ✅ FCC Part 15 uyumlu
- ✅ CE uyumlu
- ✅ RoHS uyumlu

---

Bu bilgilerle donanım kurulumunuz eksiksiz! 🔧
