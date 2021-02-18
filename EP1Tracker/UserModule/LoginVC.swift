//
//  LoginVC.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/17/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var tapRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.tapRecognizer = recognizer
        self.view.addGestureRecognizer(recognizer)
        
        if AuthService.shared.isUserLoggedIn {
            embedMainApp()
        }
    }
    
    func initializeUI() {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorLabel.text = ""
    }

    @IBAction func loginTapped(_ sender: Any) {
        let emailId = emailTextField.text
        let password = passwordTextField.text
           
        resignLoginFirstResponders()
        guard let userObject =
                User.jsonObject(emailId: emailId, password: password) else { return }
        
        AuthService.shared.authenticate(userObject: userObject) { [weak self] (authStatus, error) in
            if let _ = error {
                self?.handleAuthValidation(isAuthenticated: false)
            } else if authStatus {
                self?.handleAuthValidation(isAuthenticated: true)
            }
        }
    }
    
    func handleAuthValidation(isAuthenticated: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isAuthenticated {
                self?.initializeUI()
                self?.embedMainApp()
            } else {
                self?.errorLabel.text = "Login failed. Please try again."
            }
        }
    }
    
    func embedMainApp() {
        // Remove gesture recognizer to prevent intefering with child VC operation
        if let tapRecognizer = tapRecognizer {
            self.view.removeGestureRecognizer(tapRecognizer)
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let childVC = sb.instantiateViewController(identifier: "TabBarController")
        embedChildController(containerView: self.view,
                             childController: childVC)
    }
    
    @objc
    func viewTapped() {
        resignLoginFirstResponders()
    }
    
}

extension LoginVC: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func resignLoginFirstResponders() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
