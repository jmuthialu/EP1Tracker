//
//  URLBuilder.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 4/6/20.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let scheme = "https" 
    static let host = "eptracker.azurewebsites.net"
    static let epallets = "/epallets"
    static let authenticateUser = "/users/authenticate"
}

struct URLBuilder {
    
    static func baseURL() -> URL? {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.host
        return components.url
    }
 
    static func allPalletsUrl() -> URL? {
        guard let baseUrl = baseURL() else { return nil }
        let epalletsUrl = baseUrl.appendingPathComponent(NetworkConstants.epallets)
        return epalletsUrl
    }

    static func authenticateUserUrl() -> URL? {
        guard let baseUrl = baseURL() else { return nil }
        let userUrl = baseUrl.appendingPathComponent(NetworkConstants.authenticateUser)
        return userUrl
    }
    
}
