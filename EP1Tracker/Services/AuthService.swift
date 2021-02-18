//
//  AuthService.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import Foundation

class AuthService {
    
    static var shared = AuthService()
    var authUser: User?
    
    private init() {}
    
    var isUserLoggedIn: Bool {
        if let user: User = UserDefaults.standard.getObject(key: UserDefaultKeys.authKey) {
            print("User logged in: \(user.emailId) - \(String(describing: user.authToken))")
            authUser = user
            return true
        }
        return false
    }
    
    func authenticate(userObject: [String: Any], completion: @escaping (Bool, Error?) -> ()) {
        NetworkService.shared
            .authenticateUser(user: userObject) { [weak self] (users, error) in
            if let error = error {
                print("Auth error: \(error)")
                completion(false, error)
            } else {
                guard let users = users as? [User],
                      let user = users.first else { return }
                print(user.emailId, user.user_id, user.authToken ?? "")
                self?.authUser = user
                UserDefaults.standard.setObject(object: user, key: UserDefaultKeys.authKey)
                completion(true, nil)
            }
        }
    }
    
    func logoff() {
        authUser = nil
        UserDefaults.standard.setValue(nil, forKey: UserDefaultKeys.authKey)
    }
    
}
