import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL = "https://api.example.com" // API endpoint'inizi buraya yazın
    
    private init() {}
    
    // Network bilgilerini API'ye gönder
    func sendNetworkInfo(_ networkInfo: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        
        // JSON formatına çevir
        guard let jsonData = try? JSONSerialization.data(withJSONObject: networkInfo) else {
            completion(.failure(NetworkError.invalidData))
            return
        }
        
        // URL request oluştur
        guard let url = URL(string: "\(baseURL)/network-info") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Network request'i gönder
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        completion(.success(responseString))
                    } else {
                        completion(.success("Network info başarıyla gönderildi"))
                    }
                } else {
                    completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                }
            }
        }
        
        task.resume()
    }
    
    // Test amaçlı mock API endpoint
    func sendToMockAPI(_ networkInfo: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        // Simüle edilmiş API çağrısı
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("Mock API'ye gönderilen veri:")
            if let jsonData = try? JSONSerialization.data(withJSONObject: networkInfo),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
            completion(.success("Mock API'ye başarıyla gönderildi"))
        }
    }
}

// Network hataları
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidData
    case invalidResponse
    case serverError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .invalidData:
            return "Geçersiz veri"
        case .invalidResponse:
            return "Geçersiz yanıt"
        case .serverError(let statusCode):
            return "Sunucu hatası: \(statusCode)"
        }
    }
}
