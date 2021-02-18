//
//  NetworkContext.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

class NetworkContext {
    
    var responseObject: URLResponse?
    
    // Raw network data returned by URLSession call
    var networkData: Data?
    
    // Data decoded into codable objects
    var finalDecodedObject: Any?
    
    // netowrk JSON data is Parsed and converted as dict
    var jsonParsedDict: [String: Any?]?
    
    var error: Error?
}
