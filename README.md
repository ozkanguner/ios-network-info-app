# 🌐 Network Info App (React Native)

Modern ve kullanıcı dostu bir React Native uygulaması ile detaylı network bilgilerini toplayın ve API'ye gönderin.

## ✨ Özellikler

### 📱 Cihaz Bilgileri
- **Brand**: Cihaz markası (Samsung, Apple, Xiaomi, vb.)
- **Model**: Cihaz modeli
- **OS Version**: İşletim sistemi versiyonu
- **App Version**: Uygulama versiyonu
- **Build Number**: Build numarası

### 🌐 Network Bilgileri
- **SSID**: WiFi ağ adı
- **BSSID**: WiFi router MAC adresi
- **IP Address**: Cihaz IP adresi
- **Subnet**: Alt ağ maskesi
- **Gateway**: Gateway IP adresi
- **DNS**: DNS sunucu adresleri
- **Connection Type**: Bağlantı tipi (WiFi, Cellular, vb.)
- **Connection Status**: Bağlantı durumu

### 📤 API Entegrasyonu
- **Real API**: Gerçek API endpoint'e veri gönderme
- **Mock API**: Test için mock API
- **Error Handling**: Hata yönetimi
- **Loading States**: Yükleme durumları

## 🚀 Kurulum

### Gereksinimler
- Node.js >= 20.19.4
- npm >= 9.0.0
- React Native CLI

### Adımlar

1. **Repository'yi klonlayın:**
```bash
git clone https://github.com/ozkanguner/ios-network-info-app.git
cd ios-network-info-app/NetworkInfoAppRN
```

2. **Dependencies'leri yükleyin:**
```bash
npm install
```

3. **iOS için (macOS gerekli):**
```bash
cd ios
pod install
cd ..
npx react-native run-ios
```

4. **Android için:**
```bash
npx react-native run-android
```

## 📦 Kullanılan Paketler

- **react-native-network-info**: Network bilgilerini toplama
- **react-native-device-info**: Cihaz bilgilerini toplama
- **React Native**: Cross-platform mobil uygulama geliştirme

## 🎨 UI/UX Özellikleri

- **Modern Design**: Temiz ve profesyonel görünüm
- **Responsive Layout**: Tüm ekran boyutlarına uyumlu
- **Color Scheme**: Tutarlı renk paleti
- **Interactive Elements**: Dokunmatik butonlar ve geri bildirimler
- **Loading States**: Kullanıcı deneyimi için yükleme göstergeleri

## 🔧 Konfigürasyon

### API Endpoint
`App.tsx` dosyasında API endpoint'i güncelleyin:

```typescript
const response = await fetch('https://YOUR_API_ENDPOINT/network-info', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(networkData),
});
```

### Network Permissions
Android için `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
```

iOS için `ios/NetworkInfoAppRN/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Network bilgilerini toplamak için konum izni gerekli</string>
```

## 📱 Kullanım

1. **Uygulamayı Açın**: Otomatik olarak network bilgileri toplanır
2. **Bilgileri Güncelleyin**: "🔄 Bilgileri Güncelle" butonuna tıklayın
3. **API'ye Gönderin**: "📤 API'ye Gönder" butonuna tıklayın
4. **Test Edin**: "🧪 Mock API Test" ile test edin

## 🏗️ Build ve Deploy

### Development Build
```bash
# Android
npx react-native run-android

# iOS (macOS gerekli)
npx react-native run-ios
```

### Production Build
```bash
# Android APK
cd android
./gradlew assembleRelease

# iOS Archive (macOS gerekli)
cd ios
xcodebuild -workspace NetworkInfoAppRN.xcworkspace -scheme NetworkInfoAppRN -configuration Release archive
```

## 🔍 Troubleshooting

### Yaygın Sorunlar

1. **Network bilgileri toplanamıyor:**
   - İzinleri kontrol edin
   - Cihazı yeniden başlatın

2. **Build hatası:**
   - Node.js versiyonunu kontrol edin (>=20.19.4)
   - Dependencies'leri temizleyin: `npm clean-install`

3. **iOS build hatası:**
   - Xcode versiyonunu kontrol edin
   - Pod'ları güncelleyin: `cd ios && pod install`

## 📊 Performans

- **Startup Time**: < 2 saniye
- **Memory Usage**: < 50MB
- **Network Requests**: Optimized HTTP calls
- **UI Responsiveness**: 60fps smooth animations

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 📞 İletişim

- **GitHub**: [@ozkanguner](https://github.com/ozkanguner)
- **Repository**: [ios-network-info-app](https://github.com/ozkanguner/ios-network-info-app)

## 🙏 Teşekkürler

- React Native ekibine
- Network Info ve Device Info paket geliştiricilerine
- Tüm open source katkıda bulunanlara

---

**⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!**
