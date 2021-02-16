//
//  UIView+Extension.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import UIKit

extension UIView {
    
    func embedChildView(childView: UIView?)  {
        guard let childView = childView else { return }
        
        self.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: childView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: childView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: childView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: childView.trailingAnchor).isActive = true
        
    }
}
