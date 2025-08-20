import Foundation
import UIKit
import Network
import SystemConfiguration
import CoreTelephony

class NetworkInfo {
    
    static let shared = NetworkInfo()
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private init() {
        startMonitoring()
    }
    
    deinit {
        networkMonitor.cancel()
    }
    
    private func startMonitoring() {
        networkMonitor.pathUpdateHandler = { path in
            // Network path değişikliklerini dinle
        }
        networkMonitor.start(queue: queue)
    }
    
    // Tüm network bilgilerini topla
    func getAllNetworkInfo() -> [String: Any] {
        var networkInfo: [String: Any] = [:]
        
        networkInfo["timestamp"] = Date().timeIntervalSince1970
        networkInfo["deviceInfo"] = getDeviceInfo()
        networkInfo["networkStatus"] = getNetworkStatus()
        networkInfo["wifiInfo"] = getWiFiInfo()
        networkInfo["cellularInfo"] = getCellularInfo()
        networkInfo["connectionType"] = getConnectionType()
        networkInfo["reachability"] = getReachabilityInfo()
        
        return networkInfo
    }
    
    // Cihaz bilgileri
    private func getDeviceInfo() -> [String: Any] {
        let device = UIDevice.current
        return [
            "name": device.name,
            "model": device.model,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? "Unknown"
        ]
    }
    
    // Network durumu
    private func getNetworkStatus() -> [String: Any] {
        let currentPath = networkMonitor.currentPath
        return [
            "isConnected": currentPath.status == .satisfied,
            "isExpensive": currentPath.isExpensive,
            "isConstrained": currentPath.isConstrained,
            "availableInterfaces": currentPath.availableInterfaces.map { $0.type.description }
        ]
    }
    
    // WiFi bilgileri
    private func getWiFiInfo() -> [String: Any] {
        // WiFi bilgilerini almak için SystemConfiguration framework kullan
        var info: [String: Any] = [:]
        
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags = SCNetworkReachabilityFlags()
            if SCNetworkReachabilityGetFlags(reachability, &flags) {
                info["isWiFiAvailable"] = flags.contains(.reachable) && !flags.contains(.isWWAN)
            }
        }
        
        return info
    }
    
    // Hücresel network bilgileri
    private func getCellularInfo() -> [String: Any] {
        let networkInfo = CTTelephonyNetworkInfo()
        var cellularInfo: [String: Any] = [:]
        
        if #available(iOS 12.0, *) {
            if let carriers = networkInfo.serviceSubscriberCellularProviders {
                for (key, carrier) in carriers {
                    cellularInfo[key] = [
                        "carrierName": carrier.carrierName ?? "Unknown",
                        "isoCountryCode": carrier.isoCountryCode ?? "Unknown",
                        "mobileCountryCode": carrier.mobileCountryCode ?? "Unknown",
                        "mobileNetworkCode": carrier.mobileNetworkCode ?? "Unknown",
                        "allowsVOIP": carrier.allowsVOIP
                    ]
                }
            }
        }
        
        return cellularInfo
    }
    
    // Bağlantı tipi
    private func getConnectionType() -> String {
        let currentPath = networkMonitor.currentPath
        
        if currentPath.usesInterfaceType(.wifi) {
            return "WiFi"
        } else if currentPath.usesInterfaceType(.cellular) {
            return "Cellular"
        } else if currentPath.usesInterfaceType(.wiredEthernet) {
            return "Ethernet"
        } else if currentPath.usesInterfaceType(.loopback) {
            return "Loopback"
        } else {
            return "Unknown"
        }
    }
    
    // Network erişilebilirlik bilgileri
    private func getReachabilityInfo() -> [String: Any] {
        var info: [String: Any] = [:]
        
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags = SCNetworkReachabilityFlags()
            if SCNetworkReachabilityGetFlags(reachability, &flags) {
                info["isReachable"] = flags.contains(.reachable)
                info["isReachableViaWiFi"] = flags.contains(.reachable) && !flags.contains(.isWWAN)
                info["isReachableViaWWAN"] = flags.contains(.isWWAN)
                info["requiresConnection"] = flags.contains(.connectionRequired)
                info["requiresUserAction"] = flags.contains(.interventionRequired)
            }
        }
        
        return info
    }
}
