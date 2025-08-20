import UIKit

class ViewController: UIViewController {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let networkInfoTextView = UITextView()
    private let refreshButton = UIButton(type: .system)
    private let sendToAPIButton = UIButton(type: .system)
    private let sendToMockButton = UIButton(type: .system)
    private let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNetworkInfo()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // ScrollView setup
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        titleLabel.text = "iOS Network Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Network Info Text View
        networkInfoTextView.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        networkInfoTextView.isEditable = false
        networkInfoTextView.layer.borderColor = UIColor.systemGray4.cgColor
        networkInfoTextView.layer.borderWidth = 1
        networkInfoTextView.layer.cornerRadius = 8
        networkInfoTextView.backgroundColor = .systemGray6
        contentView.addSubview(networkInfoTextView)
        networkInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Refresh Button
        refreshButton.setTitle("Yenile", for: .normal)
        refreshButton.backgroundColor = .systemBlue
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.layer.cornerRadius = 8
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        contentView.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Send to API Button
        sendToAPIButton.setTitle("API'ye Gönder", for: .normal)
        sendToAPIButton.backgroundColor = .systemGreen
        sendToAPIButton.setTitleColor(.white, for: .normal)
        sendToAPIButton.layer.cornerRadius = 8
        sendToAPIButton.addTarget(self, action: #selector(sendToAPIButtonTapped), for: .touchUpInside)
        contentView.addSubview(sendToAPIButton)
        sendToAPIButton.translatesAutiresizingMaskIntoConstraints = false
        
        // Send to Mock Button
        sendToMockButton.setTitle("Mock API'ye Gönder", for: .normal)
        sendToMockButton.backgroundColor = .systemOrange
        sendToMockButton.setTitleColor(.white, for: .normal)
        sendToMockButton.layer.cornerRadius = 8
        sendToMockButton.addTarget(self, action: #selector(sendToMockButtonTapped), for: .touchUpInside)
        contentView.addSubview(sendToMockButton)
        sendToMockButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Status Label
        statusLabel.text = "Hazır"
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textAlignment = .center
        statusLabel.textColor = .secondaryLabel
        contentView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Network Info Text View
            networkInfoTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            networkInfoTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            networkInfoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            networkInfoTextView.heightAnchor.constraint(equalToConstant: 300),
            
            // Refresh Button
            refreshButton.topAnchor.constraint(equalTo: networkInfoTextView.bottomAnchor, constant: 20),
            refreshButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Send to API Button
            sendToAPIButton.topAnchor.constraint(equalTo: networkInfoTextView.bottomAnchor, constant: 20),
            sendToAPIButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: 10),
            sendToAPIButton.widthAnchor.constraint(equalToConstant: 120),
            sendToAPIButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Send to Mock Button
            sendToMockButton.topAnchor.constraint(equalTo: networkInfoTextView.bottomAnchor, constant: 20),
            sendToMockButton.leadingAnchor.constraint(equalTo: sendToAPIButton.trailingAnchor, constant: 10),
            sendToMockButton.widthAnchor.constraint(equalToConstant: 140),
            sendToMockButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Status Label
            statusLabel.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadNetworkInfo() {
        let networkInfo = NetworkInfo.shared.getAllNetworkInfo()
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: networkInfo, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            networkInfoTextView.text = jsonString
        }
    }
    
    @objc private func refreshButtonTapped() {
        statusLabel.text = "Yenileniyor..."
        loadNetworkInfo()
        statusLabel.text = "Güncellendi"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.statusLabel.text = "Hazır"
        }
    }
    
    @objc private func sendToAPIButtonTapped() {
        let networkInfo = NetworkInfo.shared.getAllNetworkInfo()
        statusLabel.text = "API'ye gönderiliyor..."
        
        NetworkService.shared.sendNetworkInfo(networkInfo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self?.statusLabel.text = "Başarılı: \(message)"
                case .failure(let error):
                    self?.statusLabel.text = "Hata: \(error.localizedDescription)"
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self?.statusLabel.text = "Hazır"
                }
            }
        }
    }
    
    @objc private func sendToMockButtonTapped() {
        let networkInfo = NetworkInfo.shared.getAllNetworkInfo()
        statusLabel.text = "Mock API'ye gönderiliyor..."
        
        NetworkService.shared.sendToMockAPI(networkInfo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self?.statusLabel.text = "Başarılı: \(message)"
                case .failure(let error):
                    self?.statusLabel.text = "Hata: \(error.localizedDescription)"
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self?.statusLabel.text = "Hazır"
                }
            }
        }
    }
}
