//
//  FleetMapVM.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//

import Foundation
import Combine

class FleetMapVM {
    
    @Published var pallets = [Pallet]()
    
    func loadPallets() {
        NetworkService.shared.getAllPallets { [weak self] (pallets, error) in
            guard let ePallets = pallets as? [Pallet],
                  error == nil else { return }
            self?.pallets = ePallets
        }
    }
}
