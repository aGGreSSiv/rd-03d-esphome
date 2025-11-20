#!/bin/bash

# RD-03D ESPHome Project - GitHub Upload Script
# Bu script projeyi GitHub'a private repository olarak yükler

echo "🚀 RD-03D ESPHome Project - GitHub Upload"
echo "=========================================="
echo ""

# Renk kodları
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# GitHub kullanıcı adını sor
echo -e "${YELLOW}GitHub kullanıcı adınızı girin:${NC}"
read GITHUB_USERNAME

# Repository adını sor
echo -e "${YELLOW}Repository adını girin (örnek: rd-03d-esphome):${NC}"
read REPO_NAME

echo ""
echo -e "${GREEN}✓${NC} Kullanıcı: $GITHUB_USERNAME"
echo -e "${GREEN}✓${NC} Repository: $REPO_NAME"
echo ""

# Proje klasörü oluştur
PROJECT_DIR="$HOME/rd-03d-esphome-project"
echo -e "${YELLOW}Proje klasörü oluşturuluyor...${NC}"
mkdir -p "$PROJECT_DIR"

# Dosyaları kopyala
echo -e "${YELLOW}Dosyalar kopyalanıyor...${NC}"
cp /mnt/user-data/outputs/rd-03d-sensor-test.yaml "$PROJECT_DIR/"
cp /mnt/user-data/outputs/secrets.yaml.example "$PROJECT_DIR/"
cp /mnt/user-data/outputs/rd03d_esphome.yaml "$PROJECT_DIR/"
cp /mnt/user-data/outputs/TEST_KILAVUZU.md "$PROJECT_DIR/"
cp /mnt/user-data/outputs/PIN_BAGLANTI_SEMASI.md "$PROJECT_DIR/"
cp /mnt/user-data/outputs/RD03D_KULLANIM_KILAVUZU.md "$PROJECT_DIR/"

# README.md oluştur
echo -e "${YELLOW}README.md oluşturuluyor...${NC}"
cat > "$PROJECT_DIR/README.md" << 'EOF'
# RD-03D mmWave Radar ESPHome Integration

🎯 **RD-03D 24GHz mmWave radar sensörünü ESPHome ile Home Assistant'a entegre edin!**

## 📋 Özellikler

- ✅ **Tek hedef algılama** - Mesafe, açı, konum tracking
- ✅ **ESP32 & ESP32-S3 desteği** - Arduino framework
- ✅ **Home Assistant Native API** - MQTT'ye gerek yok
- ✅ **Real-time tracking** - 50ms güncelleme
- ✅ **Detaylı logging** - Debug ve istatistikler
- ✅ **Kolay kurulum** - Tak-çalıştır

## 🚀 Hızlı Başlangıç

### 1. Donanım Bağlantıları

```
RD-03D          ESP32/ESP32-S3
------          --------------
VCC (5V)   →    5V
GND        →    GND
TXD        →    GPIO16 (RX) ⚠️ Çapraz!
RXD        →    GPIO17 (TX) ⚠️ Çapraz!
```

### 2. Kurulum

1. **secrets.yaml** oluşturun:
```yaml
wifi_ssid: "WIFI_ADINIZ"
wifi_password: "WIFI_SIFRENIZ"
```

2. **ESPHome'a yükleyin:**
```bash
esphome run rd-03d-sensor-test.yaml
```

3. **Home Assistant'a ekleyin:**
   - Otomatik keşfedilecek!

## 📖 Dokümantasyon

- 📘 [Test Kılavuzu](TEST_KILAVUZU.md) - Detaylı test adımları
- 📗 [Pin Bağlantı Şeması](PIN_BAGLANTI_SEMASI.md) - Donanım detayları
- 📙 [Kullanım Kılavuzu](RD03D_KULLANIM_KILAVUZU.md) - Genel bilgiler

## 📁 Dosyalar

- `rd-03d-sensor-test.yaml` - ESP32-S3 için optimize (Arduino framework)
- `rd03d_esphome.yaml` - Genel ESP32 versiyonu
- `secrets.yaml.example` - WiFi ayarları şablonu

## 📊 Sensörler

Otomatik oluşturulan sensörler:

- 📏 **Distance** - Mesafe (cm)
- 📐 **Angle** - Açı (derece)
- 🎯 **Target Detected** - Hedef varlığı (binary)
- 📍 **X/Y Position** - Koordinatlar (mm)
- 🏃 **Speed** - Hız (cm/s)
- 📝 **Status** - Durum bilgisi

## 🔧 Teknik Özellikler

- **Frekans:** 24 GHz ISM band
- **Menzil:** 0.6 - 8 metre
- **Açı:** ±60° (yatay), ±30° (dikey)
- **Baud Rate:** 256000 bps
- **Güç:** 5V, ≥200mA
- **Güncelleme:** ~50ms (20 Hz)

## 🐛 Sorun Giderme

| Sorun | Çözüm |
|-------|-------|
| "No Data" | TX/RX çapraz bağlantılarını kontrol edin |
| "Buffer overflow" | Normal, endişelenmeyin |
| "Invalid header" | Kablo kalitesini/uzunluğunu kontrol edin |
| Sık hedef kaybı | Otomasyonlarda gecikme ekleyin (5s) |

## 🎨 Gelecek Özellikler

- [ ] LED fade in/out kontrolü
- [ ] Çoklu hedef desteği
- [ ] MQTT desteği
- [ ] Web arayüzü
- [ ] Konfigürasyon wizard

## 📝 Lisans

MIT License - Özgürce kullanabilirsiniz!

## 🤝 Katkıda Bulunma

Test sonuçlarınızı, önerilerinizi ve pull request'lerinizi bekliyoruz!

## ⚠️ Dikkat

- 5V gereklidir (3.3V ile çalışmaz!)
- TX/RX pinleri çapraz bağlanmalıdır
- Minimum algılama mesafesi ~60 cm
- Metal/elektronik cihazlardan uzak tutun

## 📞 İletişim

Sorularınız için GitHub Issues kullanın!

---

**Made with ❤️ for Home Assistant Community**
EOF

# .gitignore oluştur
echo -e "${YELLOW}.gitignore oluşturuluyor...${NC}"
cat > "$PROJECT_DIR/.gitignore" << 'EOF'
# ESPHome
.esphome/
secrets.yaml
*.bin

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
EOF

# LICENSE oluştur (MIT)
echo -e "${YELLOW}LICENSE oluşturuluyor...${NC}"
cat > "$PROJECT_DIR/LICENSE" << 'EOF'
MIT License

Copyright (c) 2025 RD-03D ESPHome Integration

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Git repository oluştur
echo ""
echo -e "${YELLOW}Git repository oluşturuluyor...${NC}"
cd "$PROJECT_DIR"

# Git varsa kontrol et
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git kurulu değil! Lütfen git kurun:${NC}"
    echo "   sudo apt-get install git"
    exit 1
fi

git init
git add .
git commit -m "Initial commit: RD-03D ESPHome integration"

echo ""
echo -e "${GREEN}✓ Git repository oluşturuldu!${NC}"
echo ""
echo -e "${YELLOW}Şimdi GitHub'da repository oluşturun:${NC}"
echo ""
echo "1. https://github.com/new adresine gidin"
echo "2. Repository name: $REPO_NAME"
echo "3. Description: RD-03D mmWave Radar ESPHome Integration"
echo "4. ⚠️  ${RED}Private${NC} seçin (Public DEĞİL!)"
echo "5. Initialize with README: ${RED}İŞARETLEMEYİN${NC} (bizde zaten var)"
echo "6. 'Create repository' butonuna tıklayın"
echo ""
echo -e "${YELLOW}Repository oluşturduktan sonra aşağıdaki komutları çalıştırın:${NC}"
echo ""
echo -e "${GREEN}cd $PROJECT_DIR${NC}"
echo -e "${GREEN}git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git${NC}"
echo -e "${GREEN}git branch -M main${NC}"
echo -e "${GREEN}git push -u origin main${NC}"
echo ""
echo -e "${YELLOW}Not: GitHub kullanıcı adı/şifre veya Personal Access Token isteyecek${NC}"
echo ""
echo "📁 Proje klasörü: $PROJECT_DIR"
echo ""
echo -e "${GREEN}✅ Hazır! Yukarıdaki adımları takip edin.${NC}"
