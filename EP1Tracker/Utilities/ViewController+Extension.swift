//
//  ViewController+Extension.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import UIKit

extension UIViewController {
    
    func embedChildController(containerView: UIView?,
                              childController: UIViewController?,
                              animationTime: Double = 0.0) {
        
        guard let childController = childController else { return }
        guard let containerView = containerView else { return }
        
        addChild(childController)
        
        self.beginAppearanceTransition(true, animated: false)
        containerView.embedChildView(childView: childController.view)
        UIView.animate(withDuration: animationTime) {
            self.view.layoutIfNeeded()
            self.endAppearanceTransition()
            self.didMove(toParent: self)
        }
    }
    
    func removeFromParentController() {
        willMove(toParent: nil)
        beginAppearanceTransition(false, animated: false)
        view.removeFromSuperview()
        removeFromParent()
        endAppearanceTransition()
        didMove(toParent: nil)
    }

}
