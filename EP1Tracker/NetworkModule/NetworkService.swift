//
//  NetworkService.swift
//  Ep1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//  Copyright © 2021 Jay Muthialu. All rights reserved.
//

import Foundation

class NetworkService {
    
    static var shared = NetworkService()
    var networkOperationQueue: OperationQueue
    
    init() {
        networkOperationQueue = OperationQueue()
        networkOperationQueue.name = "Network Queue"
        networkOperationQueue.maxConcurrentOperationCount = 1
    }

    func getAllPallets(completion: @escaping (_ data: Any?, _ error: Error?) -> Void) {
        guard let palletsUrl = URLBuilder.getAllPallets() else { return }
        print("All pallets Url: \(palletsUrl)")
        
        let context = NetworkContext()
        let fetchOrgsOperation = NetworkOperation(url: palletsUrl, context: context)
        let jsonCodableOperation = JSONCodableOperation<[Pallet]>(context: context)
        
        jsonCodableOperation.addDependency(fetchOrgsOperation)
        networkOperationQueue.addOperation(fetchOrgsOperation)
        networkOperationQueue.addOperation(jsonCodableOperation)
        networkOperationQueue.addOperation { completion(context.finalDecodedObject, context.error) }
    }
}
