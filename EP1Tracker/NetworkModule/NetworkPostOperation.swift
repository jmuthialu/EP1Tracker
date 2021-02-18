//
//  NetworkPostOperation.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import Foundation

import Foundation

class NetworkPostOperation: Operation {
    
    var url: URL?
    var context: NetworkContext?
    var httpBody: [String: Any]?
    var dispatchQueue = DispatchQueue(label: "networkQueue")
    
    init(url: URL?, context: NetworkContext?, httpBody: [String: Any]?) {
        super.init()
        self.url = url
        self.httpBody = httpBody
        self.context = context
    }
    
    override func main() {
        guard let url = url else { return }
        guard let context = context else { return }
        
        var request = URLRequest(url: url)
        let dispatchGroup = DispatchGroup()
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let httpBody = self.httpBody {
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody)
        }
        
        dispatchGroup.enter()        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
              print("Network error occured: \(error)")
            }
            var statusError: NSError?
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Status code error: \(httpResponse.statusCode)")
                statusError = NSError(domain: "Authentication Failure", code: 100, userInfo: nil)
            }
            
            context.error = error ?? statusError
            context.networkData = data
            context.responseObject = response
            dispatchGroup.leave()
        }
        dataTask.resume()
        dispatchGroup.wait()
    }
    
}
