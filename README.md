# RD-03D mmWave Radar ESPHome Integration

🎯 RD-03D 24GHz mmWave radar sensörünü ESPHome ile Home Assistant'a entegre edin!

## 🚀 Hızlı Başlangıç

### Donanım Bağlantıları
RD-03D          ESP32/ESP32-S3

VCC (5V)   →    5V
GND        →    GND
TXD        →    GPIO16 (RX) ⚠️ Çapraz!
RXD        →    GPIO17 (TX) ⚠️ Çapraz!

### Kurulum

1. **secrets.yaml** oluşturun:
```yaml
wifi_ssid: "WIFI_ADINIZ"
wifi_password: "WIFI_SIFRENIZ"
```

2. **ESPHome'a yükleyin:**
```bash
esphome run rd-03d-sensor-test.yaml
```

3. **Home Assistant'a ekleyin** - Otomatik keşfedilecek!

## 📖 Dokümantasyon

- 📘 [Test Kılavuzu](TEST_KILAVUZU.md) - Detaylı test adımları
- 📗 [Pin Bağlantı Şeması](PIN_BAGLANTI_SEMASI.md) - Donanım detayları
- 📙 [Kullanım Kılavuzu](RD03D_KULLANIM_KILAVUZU.md) - Genel bilgiler

## 📊 Sensörler

- 📏 **Distance** - Mesafe (cm)
- 📐 **Angle** - Açı (derece)
- 🎯 **Target Detected** - Hedef varlığı
- 📍 **X/Y Position** - Koordinatlar (mm)
- 🏃 **Speed** - Hız (cm/s)

## 🔧 Teknik Özellikler

- **Frekans:** 24 GHz ISM band
- **Menzil:** 0.6 - 8 metre
- **Açı:** ±60° (yatay), ±30° (dikey)
- **Baud Rate:** 256000 bps
- **Güç:** 5V, ≥200mA

## ⚠️ Test Durumu

**Henüz test aşamasında** - Public release için test sonuçları bekleniyor.

## 📝 Lisans

MIT License - Özgürce kullanabilirsiniz!

---

**Made with ❤️ for Home Assistant Community**