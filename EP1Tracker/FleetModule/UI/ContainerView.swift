//
//  ContainerView.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/16/21.
//

import UIKit

protocol ExpandableContainerViewDelegate {
    func toggleListHeight(formFactor: ListFormFactor, animationDuration: Double)
}

enum ListFormFactor {
    case compact(CGFloat)
    case expanded(CGFloat)
}

struct ListHeight {
    static let compact = ListFormFactor.compact(200)
    static let expanded = ListFormFactor.expanded(400)
}

class ExpandableContainerView: UIView {
    
    let handlerView = UIView()
    var heightConstraint = NSLayoutConstraint()
    var delegate: ExpandableContainerViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        addSwipeGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addSwipeGestures()
    }
    
    func setupView() {
        self.addSubview(handlerView)
        self.backgroundColor = .systemBackground
        
        handlerView.backgroundColor = .systemGray
        handlerView.layer.cornerRadius = 2
        self.layer.cornerRadius = 5
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        if case let .compact(height) = ListHeight.compact {
            heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
            heightConstraint.isActive = true
        }

        handlerView.translatesAutoresizingMaskIntoConstraints = false
        handlerView.layer.cornerRadius = 2
        handlerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        handlerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        handlerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        handlerView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    func addSwipeGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeDown.direction = .down
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc
    func swipeAction(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            setHeight(to: ListHeight.expanded)
        } else {
            setHeight(to: ListHeight.compact)
        }
    }
    
    func setHeight(to formFactor: ListFormFactor, animationDuration: Double = 0.3) {
        DispatchQueue.main.async { [weak self] in
            if case let .compact(height) = formFactor {
                self?.heightConstraint.constant = height
            } else if case let .expanded(height) = formFactor {
                self?.heightConstraint.constant = height
            }
            self?.delegate?.toggleListHeight(formFactor: formFactor, animationDuration: animationDuration)
        }
    }
}
