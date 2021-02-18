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
    
    static func baseComponents() -> URLComponents? {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.host
        return components
    }
 
    static func allPalletsUrl() -> URL? {
        guard let baseUrl = baseComponents()?.url else { return nil }
        let epalletsUrl = baseUrl.appendingPathComponent(NetworkConstants.epallets)
        return epalletsUrl
    }

    static func authenticateUserUrl() -> URL? {
        guard let baseUrl = baseComponents()?.url else { return nil }
        let userUrl = baseUrl.appendingPathComponent(NetworkConstants.authenticateUser)
        return userUrl
    }

    static func lockUrlByPalletId(palletId: String, isLocked: String) -> URL? {
        guard var baseComponents = baseComponents() else { return nil }
        baseComponents.path = NetworkConstants.epallets + "/\(palletId)"
        baseComponents.queryItems = [URLQueryItem(name: "lockFlag", value: isLocked)]
        let url = baseComponents.url
        print("urlByPalletId: \(String(describing: url))")
        return url
    }

}
