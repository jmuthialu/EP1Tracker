//
//  SettingsVC.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var emailIdLabel: UILabel!
    
    var user: User? {
        didSet {
            guard let emailId = user?.emailId else { return }
            emailIdLabel.text = emailId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = AuthService.shared.authUser 
    }

    @IBAction func logoffTapped(_ sender: Any) {
        AuthService.shared.logoff()
        self.tabBarController?.removeFromParentController()
    }
    
}
