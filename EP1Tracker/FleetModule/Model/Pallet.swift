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
    var coordinate = CLLocationCoordinate2D()
    
    static func ==(lhs: Pallet, rhs: Pallet) -> Bool {
        return lhs.id == rhs.id
    }
}
