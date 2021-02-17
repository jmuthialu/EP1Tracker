//
//  ExpandableContainerView.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/16/21.
//

import UIKit

protocol ExpandableContainerViewDelegate: class {
    func toggleListHeight(formFactor: ListFormFactor, animationDuration: Double)
}

enum ListFormFactor {
    case noshow(CGFloat)
    case compact(CGFloat)
    case expanded(CGFloat)
}

struct ListHeight {
    // noshow also defines the pulloutView's height
    static let noshow = ListFormFactor.noshow(40)
    static let compact = ListFormFactor.compact(200)
    static let expanded = ListFormFactor.expanded(400)
}

class ExpandableContainerView: UIView {
    
    var pullOutView = PulloutIndicatorView()
    var containerView = UIView()
    
    var heightConstraint = NSLayoutConstraint()
    var currentHeight = ListHeight.compact
    weak var delegate: ExpandableContainerViewDelegate?
    
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
        self.backgroundColor = .systemBackground
        
        self.addSubview(pullOutView)
        self.addSubview(containerView)
        
        // Setting initial height to compact size
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        setHeight(to: ListHeight.compact, animationDuration: 0.0)
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        
        var pulloutViewHeight: CGFloat = 0.0
        if case let .noshow(height) = ListHeight.noshow {
            pulloutViewHeight = height
        }
        // Setup pulloutView constraints
        pullOutView.translatesAutoresizingMaskIntoConstraints = false
        pullOutView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pullOutView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pullOutView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pullOutView.heightAnchor.constraint(equalToConstant: pulloutViewHeight).isActive = true
        
        // Setup container view constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: pullOutView.bottomAnchor).isActive = true
        
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
            if case .noshow = currentHeight {
                setHeight(to: ListHeight.compact)
            } else {
                setHeight(to: ListHeight.expanded)
            }
        } else {
            if case .expanded = currentHeight {
                setHeight(to: ListHeight.compact)
            } else {
                setHeight(to: ListHeight.noshow)
            }
        }
    }
    
    func setHeight(to formFactor: ListFormFactor, animationDuration: Double = 0.3) {
        DispatchQueue.main.async { [weak self] in
            if case let .noshow(height) = formFactor {
                self?.heightConstraint.constant = height
                self?.currentHeight = ListHeight.noshow
            } else if case let .compact(height) = formFactor {
                self?.heightConstraint.constant = height
                self?.currentHeight = ListHeight.compact
            } else if case let .expanded(height) = formFactor {
                self?.heightConstraint.constant = height
                self?.currentHeight = ListHeight.expanded
            }
            self?.delegate?.toggleListHeight(formFactor: formFactor, animationDuration: animationDuration)
        }
    }
    
    func getCurrentListHeight() -> CGFloat {
        var listHeight: CGFloat = 0.0
        if case let .compact(height) = currentHeight {
            listHeight = height
        } else if case let .expanded(height) = currentHeight {
            listHeight = height
        }
        return listHeight
    }
}
