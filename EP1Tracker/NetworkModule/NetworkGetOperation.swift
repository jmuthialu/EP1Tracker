//
//  NetworkGetOperation.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

class NetworkGetOperation: Operation {
    
    var url: URL?
    var context: NetworkContext?
    var dispatchQueue = DispatchQueue(label: "networkQueue")
    
    init(url: URL?, context: NetworkContext?) {
        super.init()
        self.url = url
        self.context = context
    }
    
    override func main() {
        guard let url = url else { return }
        guard let context = context else { return }
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
              print("Network error occured: \(error)")
            }
            context.error = error
            context.networkData = data
            context.responseObject = response
            dispatchGroup.leave()
        }
        dataTask.resume()
        dispatchGroup.wait()
    }
    
}
