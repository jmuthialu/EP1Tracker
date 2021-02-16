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
    var imageName = "pallet"
    var coordinate = CLLocationCoordinate2D()
}
