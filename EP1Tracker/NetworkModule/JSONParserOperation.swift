//
//  JSONParserOperation.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

/// Use this to get dictionary instead of coding to an object
class JSONParserOperation: Operation {
    
    var context: NetworkContext?
    
    init(context: NetworkContext?) {
        super.init()
        self.context = context
    }
    
    override func main() {
        guard let context = context else { return }
        guard let networkData = context.networkData, context.error == nil else { return }
        
        guard let jsonDict =
                try? JSONSerialization.jsonObject(with: networkData, options: []) as? [String : Any] else {
            print("JSONParserOperation Error: Could not parse"); return
        }
        context.jsonParsedDict = jsonDict
    }
}

