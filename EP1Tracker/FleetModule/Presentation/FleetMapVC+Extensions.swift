//
//  FleetMapVC+Extensions.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/16/21.
//

import Foundation
import MapKit

extension FleetMapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView
            .dequeueReusableAnnotationView(withIdentifier: "pallet", for: annotation)
        return annotationView
    }
    
}

extension FleetMapVC: ExpandableContainerViewDelegate {
    
    func toggleListHeight(formFactor: ListFormFactor, animationDuration: Double) {
        if case .compact = formFactor {
            fleetListVC?.tableView.isScrollEnabled = false
        } else if case.expanded = formFactor {
            fleetListVC?.tableView.isScrollEnabled = true
        }
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

extension FleetMapVC: FleetListDelegate {
    
    func selected(pallet: Pallet) {
        let filteredPallets = viewModel.pallets.filter { $0 == pallet }
        if let selectedPallet = filteredPallets.first {
            mapView.selectAnnotation(selectedPallet, animated: false)
            mapView.centerCoordinate = selectedPallet.coordinate
            listContainerView.setHeight(to: ListHeight.compact)
        }
    }
    
}
