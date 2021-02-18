//
//  User.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import Foundation

class User: Codable {
    var user_id: Int = 0
    var emailId = ""
    var authToken: String?
    
    static func jsonObject(emailId: String?, password: String?) -> [String: Any]? {
        guard let emailId = emailId, let password = password else { return nil }
        return ["emailId": emailId, "password": password]
    }
}
