//
//  FleetListVM.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import Foundation
import Combine

class FleetListVM {
    
    @Published var pallets = [Pallet]()
    
    func loadData(pallets: [Pallet]) {
        self.pallets = pallets
    }
    
}
