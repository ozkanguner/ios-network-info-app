# iOS Network Info Uygulaması

Bu iOS uygulaması, cihazın network bilgilerini detaylı olarak gösterir ve bu bilgileri bir API'ye gönderebilir.

## Özellikler

- **Network Durumu**: WiFi, Cellular, Ethernet bağlantı durumları
- **Cihaz Bilgileri**: Cihaz adı, model, iOS sürümü
- **Carrier Bilgileri**: Hücresel operatör bilgileri
- **Network Erişilebilirlik**: Network erişim durumu
- **API Entegrasyonu**: Network bilgilerini API'ye gönderme
- **Mock API**: Test amaçlı mock API endpoint

## Gereksinimler

- iOS 15.0+
- Xcode 15.0+
- Swift 5.0+

## Kurulum

1. Projeyi Xcode'da açın
2. Gerekli izinleri ekleyin:
   - Network erişimi için `NSAppTransportSecurity` (Info.plist'te mevcut)
3. Projeyi build edin ve çalıştırın

## Kullanım

### Network Bilgilerini Görüntüleme
- Uygulama açıldığında otomatik olarak güncel network bilgileri gösterilir
- "Yenile" butonuna basarak bilgileri güncelleyebilirsiniz

### API'ye Veri Gönderme
1. **Gerçek API**: "API'ye Gönder" butonuna basın
   - `NetworkService.swift` dosyasında `baseURL` değişkenini kendi API endpoint'iniz ile değiştirin
2. **Mock API**: "Mock API'ye Gönder" butonuna basın
   - Test amaçlı simüle edilmiş API çağrısı yapar

## Dosya Yapısı

```
NetworkInfoApp/
├── AppDelegate.swift          # Uygulama yaşam döngüsü
├── ViewController.swift       # Ana görünüm kontrolcüsü
├── NetworkInfo.swift          # Network bilgilerini toplayan sınıf
├── NetworkService.swift       # API'ye veri gönderen servis
├── Info.plist                # Uygulama ayarları
├── LaunchScreen.storyboard   # Açılış ekranı
└── Assets.xcassets/          # Uygulama ikonları ve renkler
```

## Network Bilgileri

Uygulama aşağıdaki network bilgilerini toplar:

- **Cihaz Bilgileri**: Ad, model, sistem sürümü
- **Network Durumu**: Bağlantı durumu, maliyet, kısıtlamalar
- **WiFi Bilgileri**: WiFi erişilebilirlik
- **Hücresel Bilgiler**: Operatör adı, ülke kodu, MCC/MNC
- **Bağlantı Tipi**: WiFi, Cellular, Ethernet, Loopback
- **Erişilebilirlik**: Network erişim durumu

## API Entegrasyonu

### Gerçek API Kullanımı
```swift
// NetworkService.swift dosyasında
private let baseURL = "https://your-api-endpoint.com"

// API endpoint'i
// POST /network-info
```

### Mock API Kullanımı
```swift
NetworkService.shared.sendToMockAPI(networkInfo) { result in
    // Sonucu işle
}
```

## Build ve Dağıtım

### Simulator'da Test
1. Xcode'da projeyi açın
2. Simulator seçin (iPhone 15, iPad, vb.)
3. Build edin ve çalıştırın

### Gerçek Cihazda Test
1. Apple Developer hesabı gerekli
2. Cihazı Xcode'a bağlayın
3. Signing & Capabilities ayarlarını yapılandırın
4. Build edin ve cihaza yükleyin

### App Store'a Yükleme
1. Archive oluşturun
2. Organizer'da dağıtım seçeneklerini kullanın
3. App Store Connect'e yükleyin

## Güvenlik Notları

- `NSAppTransportSecurity` ayarı HTTP bağlantılarına izin verir
- Production'da HTTPS kullanmanız önerilir
- API anahtarları güvenli şekilde saklanmalıdır

## Sorun Giderme

### Build Hataları
- Swift sürümünün uyumlu olduğundan emin olun
- iOS deployment target'ı kontrol edin
- Gerekli framework'lerin import edildiğinden emin olun

### Network İzinleri
- Info.plist'te gerekli izinlerin mevcut olduğunu kontrol edin
- Simulator'da network erişimi test edin

## Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun
3. Değişikliklerinizi commit edin
4. Pull request gönderin

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## İletişim

Sorularınız için issue açın veya pull request gönderin.
