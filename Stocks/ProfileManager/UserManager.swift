import Foundation
import Combine
import UIKit

class UserManager: ObservableObject {
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "savedUser"
    
    @Published var user: User? {
        didSet {
            saveUser()
        }
    }
    
    init() {
        self.user = loadUser()
        if self.user == nil {
            self.user = User(nickname: "", name: "", email: "", phone: "", avatar: "")
            saveUser()
        }
    }
    
    private func saveUser() {
        guard let user = user else {
            userDefaults.removeObject(forKey: userKey)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: userKey)
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    private func loadUser() -> User? {
        guard let data = userDefaults.data(forKey: userKey) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            print("Failed to load user: \(error)")
            return nil
        }
    }
    
    func updateUser(nickname: String? = nil, name: String? = nil, email: String? = nil, phone: String? = nil, avatar: String? = nil) {
        guard var currentUser = user else { return }
        
        if let nickname = nickname {
            currentUser.nickname = nickname
        }
        
        if let name = name {
            currentUser.name = name
        }
        
        if let email = email {
            currentUser.email = email
        }
        
        if let phone = phone {
            currentUser.phone = phone
        }
        
        if let avatar = avatar {
            currentUser.avatar = avatar
        }
        
        self.user = currentUser
    }
    
    func saveImage(_ image: UIImage, forKey key: String) -> String? {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(key).jpg")
            try? data.write(to: filename)
            let path = filename.path
            updateUser(avatar: path)
            return path
        }
        
        return nil
    }
    
    func loadImage(fromPath path: String) -> UIImage? {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
