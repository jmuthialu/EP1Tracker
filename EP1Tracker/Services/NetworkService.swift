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
        guard let palletsUrl = URLBuilder.allPalletsUrl() else { return }
        print("All pallets Url: \(palletsUrl)")
        
        let context = NetworkContext()
        let fetchOrgsOperation = NetworkGetOperation(url: palletsUrl, context: context)
        let jsonCodableOperation = JSONCodableOperation<[Pallet]>(context: context)
        
        jsonCodableOperation.addDependency(fetchOrgsOperation)
        networkOperationQueue.addOperation(fetchOrgsOperation)
        networkOperationQueue.addOperation(jsonCodableOperation)
        networkOperationQueue.addOperation { completion(context.finalDecodedObject, context.error) }
    }
    
    func authenticateUser(user: [String: Any]?,
                          completion: @escaping (_ data: Any?, _ error: Error?) -> Void) {
        guard let authenticateUserUrl = URLBuilder.authenticateUserUrl() else { return }
        print("authenticateUserUrl: \(authenticateUserUrl)")
        
        let context = NetworkContext()
        let authenticateOperation = NetworkPostOperation(url: authenticateUserUrl,
                                                         context: context,
                                                         httpBody: user)
        let jsonCodableOperation = JSONCodableOperation<[User]>(context: context)
        networkOperationQueue.addOperation(authenticateOperation)
        networkOperationQueue.addOperation(jsonCodableOperation)
        networkOperationQueue.addOperation { completion(context.finalDecodedObject , context.error) }
    }
    
    func updatePallet(palletId: String,
                      isLocked: String,
                      completion: @escaping (_ result: [String: Any]?,
                                                                _ error: Error?) -> Void)  {
        
        guard let updateUrl = URLBuilder
                .lockUrlByPalletId(palletId: palletId,
                                   isLocked: isLocked) else { return }
        
        print("updatePallet url: \(updateUrl)")
        
        let context = NetworkContext()
        let updateOperation = NetworkPostOperation(url: updateUrl,
                                                         context: context,
                                                         httpBody: nil)
        let jsonParserOperation = JSONParserOperation(context: context)
        networkOperationQueue.addOperation(updateOperation)
        networkOperationQueue.addOperation(jsonParserOperation)
        networkOperationQueue.addOperation { completion(context.jsonParsedDict, context.error) }
        
    }
}
