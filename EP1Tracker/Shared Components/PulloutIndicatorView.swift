//
//  PulloutIndicatorView.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/16/21.
//

import UIKit

class PulloutIndicatorView: UIView {

    let pulloutView = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.addSubview(pulloutView)
        
        self.backgroundColor = .systemBackground
        pulloutView.backgroundColor = .systemGray
        setupPulloutConstraints()
    }

    func setupPulloutConstraints() {
        pulloutView.translatesAutoresizingMaskIntoConstraints = false
        pulloutView.layer.cornerRadius = 2
        pulloutView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        pulloutView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pulloutView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pulloutView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
