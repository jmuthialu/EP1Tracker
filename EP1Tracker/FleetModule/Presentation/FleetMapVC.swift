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
    var fleetListVC: FleetListVC?
    var listContainerView = ExpandableContainerView()
    var foregroundObserver: NSObjectProtocol?
    var cancellable = Set<AnyCancellable>()
    
    struct Constants {
        static let regionDistance: Double = 100000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindPublishers()
        viewModel.loadPallets()
        
        mapView.delegate = self
        mapView.register(PalletAnnotationView.self, forAnnotationViewWithReuseIdentifier: "pallet")
        
        addMapListView()
        addRefreshControl()
        addForegroundObserver()
    }
    
    deinit {
        guard let foregroundObserver = foregroundObserver else { return }
        NotificationCenter.default.removeObserver(foregroundObserver)
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
        guard let center = pallets.first?.coordinate else { return }
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: Constants.regionDistance,
                                        longitudinalMeters: Constants.regionDistance)
        mapView.setRegion(region, animated: false)
    }
    
    func addMapListView() {
        DispatchQueue.main.async { [weak self] in
            self?.addMapListContainerView()
            self?.embedFleetListVC()
        }
    }
    
    func addMapListContainerView() {
        self.view.addSubview(listContainerView)
        listContainerView.delegate = self
        
        // Add Container View
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        listContainerView.leadingAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        listContainerView.trailingAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        listContainerView.bottomAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func embedFleetListVC() {
        fleetListVC = FleetListVC()
        fleetListVC?.delegate = self
        self.embedChildController(containerView: listContainerView.containerView,
                                  childController: fleetListVC)
    }
    
    func addRefreshControl() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                        target: self,
                                        action: #selector(refreshData))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc
    func refreshData() {
        viewModel.loadPallets()
    }
    
    func addForegroundObserver() {
        foregroundObserver = NotificationCenter
            .default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                 object: nil,
                                 queue: .main) { [weak self] notification in
                self?.viewModel.loadPallets()
        }
    }
}
