import React, { useState, useEffect } from 'react';
import {
  SafeAreaView,
  ScrollView,
  Text,
  View,
  TouchableOpacity,
  StyleSheet,
  Alert
} from 'react-native';
import NetInfo from '@react-native-community/netinfo';
import DeviceInfo from 'react-native-device-info';

const App = () => {
  const [networkInfo, setNetworkInfo] = useState({});
  const [status, setStatus] = useState('Hazır');

  useEffect(() => {
    loadNetworkInfo();
  }, []);

  const loadNetworkInfo = async () => {
    try {
      const netState = await NetInfo.fetch();
      const deviceInfo = {
        deviceName: await DeviceInfo.getDeviceName(),
        model: DeviceInfo.getModel(),
        systemName: DeviceInfo.getSystemName(),
        systemVersion: DeviceInfo.getSystemVersion(),
        uniqueId: await DeviceInfo.getUniqueId()
      };

      const info = {
        timestamp: Date.now(),
        deviceInfo,
        networkStatus: {
          isConnected: netState.isConnected,
          type: netState.type,
          isWifiEnabled: netState.isWifiEnabled,
          details: netState.details
        },
        connectionType: netState.type
      };

      setNetworkInfo(info);
    } catch (error) {
      console.error('Network info error:', error);
    }
  };

  const sendToMockAPI = () => {
    setStatus('Mock API\'ye gönderiliyor...');
    
    setTimeout(() => {
      console.log('Mock API\'ye gönderilen veri:', JSON.stringify(networkInfo, null, 2));
      setStatus('Başarılı: Mock API\'ye gönderildi');
      
      setTimeout(() => setStatus('Hazır'), 3000);
    }, 1000);
  };

  const sendToAPI = () => {
    setStatus('API\'ye gönderiliyor...');
    
    fetch('https://api.example.com/network-info', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(networkInfo),
    })
    .then(response => response.text())
    .then(data => {
      setStatus(`Başarılı: ${data}`);
      setTimeout(() => setStatus('Hazır'), 3000);
    })
    .catch(error => {
      setStatus(`Hata: ${error.message}`);
      setTimeout(() => setStatus('Hazır'), 3000);
    });
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentInsetAdjustmentBehavior="automatic">
        <Text style={styles.title}>iOS Network Info</Text>
        
        <View style={styles.textContainer}>
          <Text style={styles.networkText}>
            {JSON.stringify(networkInfo, null, 2)}
          </Text>
        </View>

        <View style={styles.buttonContainer}>
          <TouchableOpacity 
            style={[styles.button, styles.refreshButton]}
            onPress={loadNetworkInfo}
          >
            <Text style={styles.buttonText}>Yenile</Text>
          </TouchableOpacity>

          <TouchableOpacity 
            style={[styles.button, styles.apiButton]}
            onPress={sendToAPI}
          >
            <Text style={styles.buttonText}>API'ye Gönder</Text>
          </TouchableOpacity>

          <TouchableOpacity 
            style={[styles.button, styles.mockButton]}
            onPress={sendToMockAPI}
          >
            <Text style={styles.buttonText}>Mock API</Text>
          </TouchableOpacity>
        </View>

        <Text style={styles.status}>{status}</Text>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginVertical: 20,
  },
  textContainer: {
    margin: 20,
    padding: 15,
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  networkText: {
    fontFamily: 'Courier New',
    fontSize: 12,
  },
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginHorizontal: 20,
    marginVertical: 20,
  },
  button: {
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 8,
    minWidth: 80,
  },
  refreshButton: {
    backgroundColor: '#007AFF',
  },
  apiButton: {
    backgroundColor: '#34C759',
  },
  mockButton: {
    backgroundColor: '#FF9500',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  status: {
    textAlign: 'center',
    marginTop: 20,
    fontSize: 14,
    color: '#666',
  },
});

export default App;
