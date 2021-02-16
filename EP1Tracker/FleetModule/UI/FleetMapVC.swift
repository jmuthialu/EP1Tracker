//
//  FleetMapVC.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/14/21.
//

import UIKit
import Combine
import MapKit

class FleetMapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel = FleetMapVM()
    var listContainerView = ExpandableContainerView()
    var fleetListVC: FleetListVC?
    
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindPublishers()
        viewModel.loadPallets()
        mapView.delegate = self
        mapView.register(PalletAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: "pallet")
                
        DispatchQueue.main.async { [weak self] in
            self?.addListContainerView()
            self?.addFleetListVC()
        }
           
    }
    
    func bindPublishers() {
        viewModel.$pallets
            .sink { [weak self] (pallets) in
                guard pallets.count > 0 else { return }
                DispatchQueue.main.async {
                    self?.setRegion(pallets: pallets)
                    self?.mapView.addAnnotations(pallets)
                    self?.fleetListVC?.viewModel.loadData(pallets: pallets)
                }
            }.store(in: &cancellable)
    }
    
    func setRegion(pallets: [Pallet]) {
        let center = pallets[0].coordinate
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 5000,
                                        longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
    
    func addListContainerView() {
        self.view.addSubview(listContainerView)
        listContainerView.delegate = self
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        listContainerView.leadingAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        listContainerView.trailingAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        listContainerView.bottomAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addFleetListVC() {
        fleetListVC = FleetListVC()
        self.embedChildController(containerView: listContainerView,
                                  childController: fleetListVC)
    }
}

extension FleetMapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView
            .dequeueReusableAnnotationView(withIdentifier: "pallet", for: annotation)
        return annotationView

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let pallet = view.annotation as? Pallet {
            print("Pallet: \(pallet.id)")
        }
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

