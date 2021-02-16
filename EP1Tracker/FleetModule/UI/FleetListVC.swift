//
//  FleetListTVC.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import UIKit
import Combine

class FleetListVC: UIViewController {

    var tableView = UITableView()
    var viewModel = FleetListVM()
    
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        bindPublishers()
    }
    
    func setUpTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        
        let nib = UINib(nibName: "FleetListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FleetListCell")
    }
    
    func bindPublishers() {
        viewModel.$pallets
            .sink { [weak self] (pallets) in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellable)
    }
    
}

extension FleetListVC: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pallets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let listCell = tableView.dequeueReusableCell(withIdentifier: "FleetListCell",
                                                        for: indexPath) as? FleetListCell {
            let pallet = viewModel.pallets[indexPath.row]
            listCell.configure(pallet: pallet)
            return listCell
        }
        return UITableViewCell()
    }
}

extension FleetListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    

