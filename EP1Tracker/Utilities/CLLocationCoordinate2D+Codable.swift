//
//  CLLocationCoordinate2D+Codable.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Decodable {
    
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        self = .init(latitude: latitude, longitude: longitude)
    }
}
