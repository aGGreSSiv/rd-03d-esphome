# RD-03D mmWave Radar ESPHome Entegrasyon Kılavuzu

## 📋 Gereksinimler

- ESP32 geliştirme kartı
- RD-03D mmWave radar sensörü
- Atlama kabloları (Female-Female)
- ESPHome yüklü bir sistem (Home Assistant Add-on veya standalone)

## 🔌 Donanım Bağlantıları

### RD-03D Pin Bağlantıları:

```
RD-03D Pin    →    ESP32 Pin
-----------        -----------
VCC (5V)      →    5V
GND           →    GND
TXD           →    GPIO16 (RX)
RXD           →    GPIO17 (TX)
```

⚠️ **ÖNEMLI:** 
- Sensör TXD → ESP32 RX (çapraz bağlantı)
- Sensör RXD → ESP32 TX (çapraz bağlantı)
- Sensör 5V ile çalışır

## 📝 Kurulum Adımları

### 1. YAML Dosyasını Düzenle

`rd03d_esphome.yaml` dosyasını açın ve aşağıdaki bölümleri düzenleyin:

```yaml
wifi:
  ssid: "SİZİN_WIFI_AĞINIZ"
  password: "SİZİN_WIFI_ŞİFRENİZ"
```

### 2. İlk Yükleme (USB ile)

Terminal veya komut satırında:

```bash
esphome run rd03d_esphome.yaml
```

İlk yüklemede USB kablosu ile bağlantı gereklidir. Sonraki güncellemeler OTA (Over-The-Air) ile yapılabilir.

### 3. Home Assistant'a Ekle

ESPHome cihaz yüklendikten sonra:
1. Home Assistant → Ayarlar → Cihazlar ve Servisler
2. "ESPHome" entegrasyonuna tıklayın
3. Yeni keşfedilen cihazı ekleyin (rd03d-sensor)

## 📊 Sensörler ve Kullanımları

### Oluşturulan Sensörler:

1. **RD03D Distance** (cm) 
   - Hedefin sensöre olan mesafesi
   - 0.5 - 800 cm arası
   - Kullanım: Otomasyon tetikleyicisi olarak

2. **RD03D X Position** (mm)
   - Hedefin X koordinatı
   - Sensöre göre yatay konum

3. **RD03D Y Position** (mm)
   - Hedefin Y koordinatı  
   - Sensöre göre derinlik/uzaklık

4. **RD03D Angle** (derece)
   - Hedefin açısal pozisyonu
   - -180° ile +180° arası
   - Sağ/sol taraf belirleme için

5. **RD03D Speed** (cm/s)
   - Hedefin hareket hızı

6. **RD03D Target Detected** (binary)
   - Hedef algılandı mı? (Evet/Hayır)
   - Occupancy sensörü olarak çalışır

7. **RD03D Status** (text)
   - Sistem durumu: "Target Detected", "No Target", "No Data"

## 🎯 Home Assistant Otomasyon Örnekleri

### Örnek 1: Hedef Algılandığında LED Yak

```yaml
automation:
  - alias: "LED Aç - RD03D Hedef Algıladı"
    trigger:
      - platform: state
        entity_id: binary_sensor.rd03d_target_detected
        to: 'on'
    action:
      - service: light.turn_on
        target:
          entity_id: light.salon_led
```

### Örnek 2: Mesafeye Göre LED Parlaklığı (İleride Eklenecek)

```yaml
automation:
  - alias: "LED Parlaklık - Mesafeye Göre"
    trigger:
      - platform: state
        entity_id: sensor.rd03d_distance
    action:
      - service: light.turn_on
        target:
          entity_id: light.salon_led
        data:
          brightness: >
            {% set distance = states('sensor.rd03d_distance') | float %}
            {% set max_distance = 800 %}
            {% if distance > 0 %}
              {{ ((max_distance - distance) / max_distance * 255) | int }}
            {% else %}
              0
            {% endif %}
```

### Örnek 3: Hedef 5 Saniye Yoksa LED Söndür

```yaml
automation:
  - alias: "LED Kapat - RD03D Hedef Yok"
    trigger:
      - platform: state
        entity_id: binary_sensor.rd03d_target_detected
        to: 'off'
        for:
          seconds: 5
    action:
      - service: light.turn_off
        target:
          entity_id: light.salon_led
```

## 🔧 Sorun Giderme

### Sensör Veri Göndermiyorsa:

1. **UART Bağlantılarını Kontrol Edin:**
   - TX/RX pinleri doğru çaprazlanmış mı?
   - 5V ve GND bağlantıları sağlam mı?

2. **ESPHome Loglarını İnceleyin:**
   ```bash
   esphome logs rd03d_esphome.yaml
   ```
   
3. **Sensör Modunu Kontrol Edin:**
   - ESPHome boot sırasında single target mode komutu gönderiyor
   - "Single Target Detection Mode Activated" log mesajını arayın

4. **Baud Rate Kontrolü:**
   - RD-03D varsayılan baud rate: 256000
   - YAML dosyasında doğru ayarlandığından emin olun

### Yanlış Veriler Alıyorsanız:

1. **Sensör Montajını Kontrol Edin:**
   - Ai-Thinker logosu üstte olmalı
   - Sensör düz ve sabit monte edilmeli
   - Montaj sırasında kalibrasyonu bozabilir

2. **Çevresel Faktörler:**
   - Metal veya elektronik cihazlardan uzak tutun
   - Minimum algılama mesafesi: ~60 cm
   - Maksimum etkili mesafe: 8 metre

3. **Frame Timeout:**
   - 5 saniye veri gelmezse "No Data" durumu
   - Normal çalışmada sürekli veri akışı olmalı

## 📐 Sensör Özellikleri

- **Frekans:** 24 GHz ISM band
- **Maksimum Mesafe:** 8 metre (normal yönde)
- **Algılama Açısı:** Yatay ±60°, Dikey ±30°
- **Menzil Çözünürlüğü:** 0.75m
- **Menzil Doğruluğu:** 0.15m
- **Güç:** 5V, ≥200mA
- **UART Baud Rate:** 256000 bps
- **Minimum Algılama Mesafesi:** ~60 cm

## 🎛️ İleri Seviye Ayarlar

### Debug Modunu Aktifleştirme:

YAML dosyasında logger seviyesini DEBUG'a alın:

```yaml
logger:
  level: DEBUG
```

Sonra logları izleyin:
```bash
esphome logs rd03d_esphome.yaml
```

Her frame'de şu tarz log mesajları göreceksiniz:
```
[D][RD03D:xxx] Distance: 245.3 cm, Angle: 15.2°, X: 634 mm, Y: 2345 mm
```

### Update Interval Değiştirme:

Varsayılan 50ms'dir. Daha az CPU kullanımı için artırabilirsiniz:

```yaml
interval:
  - interval: 100ms  # 50ms yerine 100ms
    then:
      # ... kod devam eder
```

## 🚀 Sonraki Adımlar

Şimdilik sensör verilerini başarıyla okuyorsunuz. LED kontrolü için:

1. ESPHome'da PWM LED çıkışı tanımlayın
2. Mesafe değerine göre parlaklık hesaplayan lambda yazın  
3. Fade in/out efekti için transition ayarları kullanın

Bunları da isterseniz hazırlayabiliriz!

## ❓ Sık Sorulan Sorular

**S: Multi-target modu kullanabilir miyim?**
C: Evet! Farklı bir komut göndermeniz gerekir. Şu anda single-target için optimize edilmiş durumda.

**S: Sensör sık sık hedef kaybediyor?**
C: Normal bir durum. Sensör kısa süreli kayıplar yaşayabilir. Otomasyonlarda "for: seconds: 5" gibi gecikmeler ekleyin.

**S: Maksimum mesafeyi değiştirebilir miyim?**
C: Evet, ancak firmware ayarları yapmanız gerekir. Şu anda 8 metre maksimum.

**S: ESP8266 ile çalışır mı?**
C: Teoride evet, ancak ESP32 önerilir. UART ve bellek gereksinimleri nedeniyle ESP32 daha kararlı.

---

**Oluşturma Tarihi:** 2025
**Version:** 1.0
**Yazar:** Claude (Anthropic)
