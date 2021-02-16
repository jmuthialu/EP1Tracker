//
//  JSONCodableOperation.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

class JSONCodableOperation<T: Decodable>: Operation {
    
    var context: NetworkContext?
    
    init(context: NetworkContext?) {
        super.init()
        self.context = context
    }
    
    override func main() {
        guard let context = context else { return }
        guard let networkData = context.networkData, context.error == nil else { return }
        
        let decoder = JSONDecoder()
        do {
            context.finalDecodedObject = try decoder.decode(T.self, from: networkData)
        } catch {
            print("Decode error: \(error)")
            context.error = error
        }
    }
}
