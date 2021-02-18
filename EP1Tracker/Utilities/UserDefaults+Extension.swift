//
//  UserDefaults+Extension.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import Foundation

struct UserDefaultKeys {
    static let authKey = "authKey"
}

extension UserDefaults {
   
    func setObject<T:Codable>(object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: UserDefaultKeys.authKey)
        } catch {
            print("UserDefault error encoding object: \(error)")
        }
    }
    
    func getObject<T: Codable>(key: String) -> T? {
        do {
            if let data = UserDefaults.standard.data(forKey: UserDefaultKeys.authKey) {
                let object = try JSONDecoder().decode(T.self, from: data)
                return object
            }
        } catch {
            print("UserDefault error decoding object: \(error)")
        }
        return nil
    }
    

}
