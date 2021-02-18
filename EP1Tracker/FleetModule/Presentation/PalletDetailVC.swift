//
//  PalletDetailVC.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import UIKit

protocol PalletDelegate: class {
    func lockToggled()
}

class PalletDetailVC: UIViewController {

    @IBOutlet weak var palletTitleLabel: UILabel!
    @IBOutlet weak var lockSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lockErrorLabel: UILabel!
    
    var pallet = Pallet()
    weak var delegate: PalletDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockErrorLabel.text = ""
        palletTitleLabel.text = pallet.title
        pallet.isLocked ?
            lockSwitch.setOn(true, animated: true):
            lockSwitch.setOn(false, animated: false)
    }
    
    @IBAction func switchTapped(_ sender: Any) {
        
        activityIndicator.startAnimating()
        lockErrorLabel.text = ""
        let isLocked = lockSwitch.isOn ? true: false
        
        pallet.lock(isLocked: isLocked) { [weak self] error in
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let _ = error {
                    self?.lockErrorLabel.text = "Locking functionality failed!! Please try again."
                } else {
                    self?.delegate?.lockToggled()
                }   
            }
        }
    }    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
