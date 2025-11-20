# RD-03D mmWave Radar ESPHome Integration

Attention: Since I'm not a programmer, this has been created with the help of artificial intelligence. I will try to answer your requests and questions for my own improvement, but you can also do this yourselves by using AI tools. I spent time getting this sensor to work because it doesn't have a proper Esphome file. Unfortunately, most of these sensor types are junk; most of them can't deliver what they promise in their datasheets, or they all have a finicky side. The one that has worked most flawlessly so far has been the LD2410B. The reason I want to replace it is the range; I needed more distance. At the end of the day, it might be necessary to switch to higher quality products with proper documentation behind them, like those from DFRobot or SeedStudio. Since these tests were done with products bought from the Chinese market, I may not have reached a happy ending. :)

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
