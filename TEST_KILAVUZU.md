# 🎯 RD-03D ESP32-S3 Test Kılavuzu

## 📋 Özellikler

✅ **Arduino Framework** - Kolay ve güvenilir  
✅ **ESP32-S3 DevKit C-1** uyumlu  
✅ **Tam sensör verisi** - Distance, X, Y, Angle, Speed  
✅ **Otomatik frame parsing** - 50ms güncelleme  
✅ **Error tracking** - Frame sayacı ve hata oranı  
✅ **Debug logging** - Detaylı log mesajları  
✅ **Sensör yeniden başlatma butonu**  
✅ **Home Assistant entegrasyonu** - Native API  

---

## 🔌 Donanım Bağlantıları

### RD-03D → ESP32-S3 DevKit C-1

```
┌─────────────┐          ┌──────────────────┐
│   RD-03D    │          │   ESP32-S3       │
├─────────────┤          ├──────────────────┤
│ VCC (5V)    ├─────────►│ 5V               │
│ GND         ├─────────►│ GND              │
│ TXD         ├─────────►│ GPIO16 (RX)      │
│ RXD         ├─────────►│ GPIO17 (TX)      │
└─────────────┘          └──────────────────┘
```

### ⚠️ Önemli Notlar:

1. **TXD ↔ RX çapraz bağlantı** (Sensör TX → ESP RX)
2. **RXD ↔ TX çapraz bağlantı** (Sensör RX → ESP TX)
3. **5V gerekli** - RD-03D 3.3V ile çalışmaz
4. **200mA akım** sağlayın (USB yeterli)

---

## 📝 Kurulum Adımları

### 1. Dosyaları Yerleştirin

ESPHome klasörünüze şu dosyaları koyun:

```
/config/esphome/
├── rd-03d-sensor-test.yaml
└── secrets.yaml
```

### 2. secrets.yaml Düzenleyin

```yaml
wifi_ssid: "SİZİN_WIFI_AĞINIZ"
wifi_password: "SİZİN_WIFI_ŞİFRENİZ"
```

### 3. İlk Yükleme (USB ile)

**Home Assistant Add-on kullanıyorsanız:**
1. ESPHome Dashboard'a gidin
2. "rd-03d-sensor-test" kartını bulun
3. ⋮ (üç nokta) → Install → Plug into this computer
4. USB kablosu ile ESP32-S3'ü bilgisayara bağlayın
5. Serial port'u seçin
6. Install'a tıklayın

**Komut satırı kullanıyorsanız:**
```bash
esphome run rd-03d-sensor-test.yaml
```

### 4. Home Assistant'a Ekleyin

Yükleme tamamlandıktan sonra:
1. Settings → Devices & Services
2. ESPHome entegrasyonuna tıklayın
3. "RD-03D Sensor Test" otomatik keşfedilecek
4. "Configure" → "Submit"

---

## 🔍 Test Etme

### 1. Logları İzleyin

**Home Assistant'ta:**
- ESPHome Dashboard → rd-03d-sensor-test → LOGS

**Komut satırında:**
```bash
esphome logs rd-03d-sensor-test.yaml
```

### 2. Göreceğiniz Log Mesajları

#### ✅ Başarılı başlangıç:
```
[INFO] RD-03D initialized - Single Target Detection Mode activated
[DEBUG] RD03D: Frame: 50, Distance: 123.4 cm, Angle: 15.2°, X: 345 mm, Y: 1178 mm, Speed: 12 cm/s
```

#### ⚠️ Hedef algılanmadığında:
```
[INFO] Status: No Target
```

#### ❌ Bağlantı sorunu:
```
[WARN] RD03D: No data for 5 seconds! Check Connections
```

### 3. Home Assistant'ta Kontrol

**Developer Tools → States** bölümünde aşağıdaki entity'leri görmelisiniz:

```
sensor.rd_03d_sensor_test_distance          → 123.4 cm
sensor.rd_03d_sensor_test_x_position        → 345 mm
sensor.rd_03d_sensor_test_y_position        → 1178 mm
sensor.rd_03d_sensor_test_angle             → 15.2 °
sensor.rd_03d_sensor_test_speed             → 12 cm/s
binary_sensor.rd_03d_sensor_test_target_detected → on
text_sensor.rd_03d_sensor_test_status       → Target Detected
```

---

## 🧪 Test Senaryoları

### Test 1: Temel Algılama
1. Sensörün önünden geçin (1-2 metre mesafede)
2. `binary_sensor.target_detected` → **on** olmalı
3. `sensor.distance` değerini kontrol edin

### Test 2: Mesafe Testi
1. Sensörden farklı mesafelerde durun:
   - 0.5 metre
   - 2 metre
   - 5 metre
   - 8 metre
2. Her mesafede `sensor.distance` değerini not edin
3. Gerçek mesafe ile karşılaştırın

### Test 3: Açı Testi
1. Sensörün soluna geçin → Açı **negatif** (-90° to 0°)
2. Sensörün sağına geçin → Açı **pozitif** (0° to +90°)
3. `sensor.angle` değerlerini gözlemleyin

### Test 4: Minimum Mesafe
1. Sensöre 60 cm'den daha yakın yaklaşın
2. Algılama **kaybolabilir** (normal)
3. 60 cm'den uzaklaşın → Algılama **geri gelir**

### Test 5: Maksimum Mesafe
1. Sensörden yavaşça uzaklaşın
2. 8 metre civarında algılama **zayıflar**
3. 8+ metre → Algılama **kaybolur**

### Test 6: Açı Limitleri
1. Sensörün yan taraflarına gidin (±60° dışı)
2. Algılama **kaybolmalı**
3. Merkeze dönün → Algılama **geri gelir**

---

## 📊 İstatistikler ve Monitoring

### Frame İstatistikleri

Her 10.000 frame'de otomatik log:
```
[INFO] RD03D: Stats - Total Frames: 10000, Errors: 5, Error Rate: 0.05%
```

**Normal değerler:**
- Error Rate: < 1% ✅ Mükemmel
- Error Rate: 1-5% ⚠️ Kabul edilebilir
- Error Rate: > 5% ❌ Bağlantı sorunlu

### Sensör Yeniden Başlatma

Home Assistant'ta buton var:
- **button.reinitialize_sensor** → Sensörü yeniden başlat
- **button.restart_esp32** → ESP32'yi yeniden başlat

---

## 🐛 Sorun Giderme

### Sorun 1: "No Data for 5 seconds"

**Sebep:** UART bağlantısı yok veya hatalı

**Çözüm:**
1. Kabloları kontrol edin (özellikle TX/RX çaprazlaması)
2. 5V ve GND bağlantılarını kontrol edin
3. ESP32'yi yeniden başlatın
4. USB kablosunu değiştirin (güç sorunları için)

### Sorun 2: "Buffer overflow"

**Sebep:** UART verisi çok hızlı geliyor

**Çözüm:**
1. Normal durum, endişelenmeyin
2. Nadiren oluyorsa sorun yok
3. Sürekli oluyorsa rx_buffer_size artırın (256 → 512)

### Sorun 3: "Invalid header"

**Sebep:** Veri frame'leri bozuk

**Çözüm:**
1. Kablo kalitesini kontrol edin
2. Kabloları kısaltın (< 30 cm ideal)
3. Sensörü yeniden başlatın (button kullanın)

### Sorun 4: Mesafe değerleri çok yüksek/düşük

**Sebep:** Sensör montajı veya offset sorunları

**Çözüm:**
1. Sensörü düz ve sabit monte edin
2. Ai-Thinker logosu üstte olmalı
3. Sensörü yeniden başlatın (kalibrasyon için)
4. Metal/elektronik cihazlardan uzak tutun

### Sorun 5: Sık hedef kaybı

**Sebep:** Normal davranış (sensör karakteristiği)

**Çözüm:**
1. Bu normal! RD-03D bazen kısa süreli kayıplar yaşar
2. Otomasyonlarda gecikme ekleyin:
   ```yaml
   trigger:
     - platform: state
       entity_id: binary_sensor.target_detected
       to: 'off'
       for:
         seconds: 5  # 5 saniye bekle
   ```

### Sorun 6: WiFi'ye bağlanmıyor

**Çözüm:**
1. secrets.yaml'daki SSID/password'u kontrol edin
2. Fallback hotspot'a bağlanın: "Rd-03D-Sensor-Test"
3. Password: "vL6oI5g9csXi"
4. Web arayüzünden WiFi ayarları yapın

---

## 📈 Performans Optimizasyonu

### CPU Kullanımını Azaltma

Eğer ESP32 yavaş çalışıyorsa:

```yaml
interval:
  - interval: 100ms  # 50ms → 100ms yap
    then:
      # ... lambda kodu
```

### Log Seviyesini Düşürme

Prodüksiyon için:

```yaml
logger:
  level: INFO  # DEBUG → INFO yap
```

### Frame Log Sıklığını Değiştirme

Lambda içinde (satır ~84):
```cpp
if (frame_count % 100 == 0) {  // 50 → 100 yap
  ESP_LOGD("RD03D", ...);
}
```

---

## 🎨 Sonraki Adımlar - LED Entegrasyonu

Test başarılı olduktan sonra LED kontrolü ekleyebiliriz:

### Özellik Fikirleri:
1. **Mesafe → Parlaklık**
   - Yaklaştıkça LED parlasın
   - 0-800 cm arası smooth geçiş

2. **Açı → Renk**
   - Sol taraf → Mavi
   - Sağ taraf → Kırmızı
   - Orta → Yeşil

3. **Hareket → Efekt**
   - Yaklaşırken → Fade In
   - Uzaklaşırken → Fade Out
   - Durgun → Pulse efekti

4. **Mesafe Bölgeleri**
   - 0-2m → Kırmızı (çok yakın)
   - 2-5m → Sarı (orta)
   - 5-8m → Yeşil (uzak)

Hangisini istersiniz? 💡

---

## 📌 Hızlı Referans

### Pinler
- RX: GPIO16
- TX: GPIO17

### Baud Rate
- 256000 bps

### Frame Yapısı
- Header: 0xAA 0xFF 0x03 0x00
- Data: 24 byte (3 target × 8 byte)
- Tail: 0x55 0xCC

### Sensör Özellikleri
- Min mesafe: ~60 cm
- Max mesafe: 800 cm
- Açı: ±60° (yatay)
- Güncelleme: ~50ms

### Entity'ler
- Distance: cm
- X/Y: mm
- Angle: derece
- Speed: cm/s
- Target: binary (on/off)
- Status: text

---

## 🆘 Yardım

Sorun mu yaşıyorsunuz?

1. **Logları kontrol edin** - Her şey orada!
2. **Bağlantıları kontrol edin** - %90 sorun burada
3. **Sensörü yeniden başlatın** - Buton kullanın
4. **ESP32'yi yeniden başlatın** - Bazen gerekir

İyi testler! 🚀
