//
//  NetworkOperation.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

class NetworkOperation: Operation {
    
    var url: URL?
    var method = "GET"
    var context: NetworkContext?
    var dispatchQueue = DispatchQueue(label: "networkQueue")
    
    init(url: URL?, context: NetworkContext?, method: String = "GET") {
        super.init()
        self.url = url
        self.method = method
        self.context = context
    }
    
    override func main() {
        guard let url = url else { return }
        guard let context = context else { return }
        
        var request = URLRequest(url: url)
        let dispatchGroup = DispatchGroup()
        
        request.httpMethod = method
        // Values set for POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
