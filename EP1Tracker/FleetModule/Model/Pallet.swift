//
//  Pallet.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//

import Foundation
import MapKit

class Pallet: NSObject, MKAnnotation, Decodable {
    var id: Int = 0
    var model = ""
    var status = ""
    var title: String?
    var imageName = ""
    var isLocked = false
    var coordinate = CLLocationCoordinate2D()
    
    static func ==(lhs: Pallet, rhs: Pallet) -> Bool {
        return lhs.id == rhs.id
    }
    
    func lock(isLocked: Bool, completion: @escaping (Error?) -> Void) {
        // Convert to string as Query param does not take bool
        let lockString = isLocked ? "true": "false"
        
        NetworkService.shared.updatePallet(palletId: String(id),
                                           isLocked: lockString) { (error) in
            if let error = error {
                print("Lock Error: \(error)")
                completion(error)
            } else {
                print("Lock successfully set to \(lockString)!!")
                completion(nil)
            }
        }
    }
    
}
