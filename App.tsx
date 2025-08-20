import React, {useState, useEffect} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  Alert,
} from 'react-native';
import NetworkInfo from 'react-native-network-info';
import DeviceInfo from 'react-native-device-info';

interface NetworkData {
  deviceInfo: {
    brand: string;
    model: string;
    systemVersion: string;
    appVersion: string;
    buildNumber: string;
  };
  networkInfo: {
    ssid: string;
    bssid: string;
    ipAddress: string;
    subnet: string;
    gateway: string;
    dns: string;
    connectionType: string;
    isConnected: boolean;
  };
  timestamp: string;
}

const App = () => {
  const [networkData, setNetworkData] = useState<NetworkData | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const collectNetworkInfo = async (): Promise<NetworkData> => {
    try {
      // Cihaz bilgileri
      const deviceInfo = {
        brand: await DeviceInfo.getBrand(),
        model: await DeviceInfo.getModel(),
        systemVersion: await DeviceInfo.getSystemVersion(),
        appVersion: await DeviceInfo.getVersion(),
        buildNumber: await DeviceInfo.getBuildNumber(),
      };

      // Network bilgileri
      const ssid = await NetworkInfo.getSSID();
      const bssid = await NetworkInfo.getBSSID();
      const ipAddress = await NetworkInfo.getIPAddress();
      const subnet = await NetworkInfo.getSubnet();
      const gateway = await NetworkInfo.getGatewayIPAddress();
      const dns = await NetworkInfo.getDNSServers();
      
      // Bağlantı tipi
      const connectionType = await NetworkInfo.getConnectionType();
      const isConnected = await NetworkInfo.isConnectionFast();

      const networkInfo = {
        ssid: ssid || 'Unknown',
        bssid: bssid || 'Unknown',
        ipAddress: ipAddress || 'Unknown',
        subnet: subnet || 'Unknown',
        gateway: gateway || 'Unknown',
        dns: dns || 'Unknown',
        connectionType: connectionType || 'Unknown',
        isConnected: isConnected || false,
      };

      return {
        deviceInfo,
        networkInfo,
        timestamp: new Date().toISOString(),
      };
    } catch (error) {
      console.error('Network bilgileri toplanamadı:', error);
      throw error;
    }
  };

  const refreshNetworkInfo = async () => {
    try {
      setIsLoading(true);
      const data = await collectNetworkInfo();
      setNetworkData(data);
      Alert.alert('Başarılı', 'Network bilgileri güncellendi!');
    } catch (error) {
      Alert.alert('Hata', 'Network bilgileri toplanamadı!');
    } finally {
      setIsLoading(false);
    }
  };

  const sendToAPI = async () => {
    if (!networkData) {
      Alert.alert('Hata', 'Önce network bilgilerini toplayın!');
      return;
    }

    try {
      setIsLoading(true);
      
      // Gerçek API endpoint'inizi buraya yazın
      const response = await fetch('https://api.example.com/network-info', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(networkData),
      });

      if (response.ok) {
        Alert.alert('Başarılı', 'Veriler API\'ye gönderildi!');
      } else {
        Alert.alert('Hata', 'API\'ye gönderilemedi!');
      }
    } catch (error) {
      Alert.alert('Hata', 'Bağlantı hatası!');
    } finally {
      setIsLoading(false);
    }
  };

  const sendToMockAPI = async () => {
    if (!networkData) {
      Alert.alert('Hata', 'Önce network bilgilerini toplayın!');
      return;
    }

    try {
      setIsLoading(true);
      
      // Mock API - test için
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      Alert.alert('Başarılı', 'Veriler Mock API\'ye gönderildi! (Test)');
    } catch (error) {
      Alert.alert('Hata', 'Mock API hatası!');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    refreshNetworkInfo();
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor="#f8f9fa" />
      
      <View style={styles.header}>
        <Text style={styles.title}>🌐 Network Info App</Text>
        <Text style={styles.subtitle}>Detaylı Network Bilgileri</Text>
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Butonlar */}
        <View style={styles.buttonContainer}>
          <TouchableOpacity
            style={[styles.button, styles.primaryButton]}
            onPress={refreshNetworkInfo}
            disabled={isLoading}>
            <Text style={styles.buttonText}>
              {isLoading ? '⏳ Güncelleniyor...' : '🔄 Bilgileri Güncelle'}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.button, styles.successButton]}
            onPress={sendToAPI}
            disabled={isLoading || !networkData}>
            <Text style={styles.buttonText}>📤 API'ye Gönder</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.button, styles.infoButton]}
            onPress={sendToMockAPI}
            disabled={isLoading || !networkData}>
            <Text style={styles.buttonText}>🧪 Mock API Test</Text>
          </TouchableOpacity>
        </View>

        {/* Network Bilgileri */}
        {networkData && (
          <View style={styles.infoContainer}>
            <Text style={styles.sectionTitle}>📱 Cihaz Bilgileri</Text>
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>Brand: {networkData.deviceInfo.brand}</Text>
              <Text style={styles.infoText}>Model: {networkData.deviceInfo.model}</Text>
              <Text style={styles.infoText}>OS: {networkData.deviceInfo.systemVersion}</Text>
              <Text style={styles.infoText}>App Version: {networkData.deviceInfo.appVersion}</Text>
              <Text style={styles.infoText}>Build: {networkData.deviceInfo.buildNumber}</Text>
            </View>

            <Text style={styles.sectionTitle}>🌐 Network Bilgileri</Text>
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>SSID: {networkData.networkInfo.ssid}</Text>
              <Text style={styles.infoText}>BSSID: {networkData.networkInfo.bssid}</Text>
              <Text style={styles.infoText}>IP: {networkData.networkInfo.ipAddress}</Text>
              <Text style={styles.infoText}>Subnet: {networkData.networkInfo.subnet}</Text>
              <Text style={styles.infoText}>Gateway: {networkData.networkInfo.gateway}</Text>
              <Text style={styles.infoText}>DNS: {networkData.networkInfo.dns}</Text>
              <Text style={styles.infoText}>Type: {networkData.networkInfo.connectionType}</Text>
              <Text style={styles.infoText}>Connected: {networkData.networkInfo.isConnected ? '✅' : '❌'}</Text>
            </View>

            <Text style={styles.sectionTitle}>⏰ Zaman</Text>
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                {new Date(networkData.timestamp).toLocaleString('tr-TR')}
              </Text>
            </View>
          </View>
        )}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f9fa',
  },
  header: {
    backgroundColor: '#007bff',
    padding: 20,
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 5,
  },
  subtitle: {
    fontSize: 16,
    color: 'rgba(255,255,255,0.8)',
  },
  content: {
    flex: 1,
    padding: 20,
  },
  buttonContainer: {
    marginBottom: 20,
  },
  button: {
    padding: 15,
    borderRadius: 10,
    marginBottom: 10,
    alignItems: 'center',
  },
  primaryButton: {
    backgroundColor: '#007bff',
  },
  successButton: {
    backgroundColor: '#28a745',
  },
  infoButton: {
    backgroundColor: '#17a2b8',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600',
  },
  infoContainer: {
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
    marginTop: 20,
  },
  infoCard: {
    backgroundColor: 'white',
    padding: 15,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  infoText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
    fontFamily: 'monospace',
  },
});

export default App;
