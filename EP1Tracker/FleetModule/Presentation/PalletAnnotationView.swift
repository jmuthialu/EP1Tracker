//
//  PalletAnnotationView.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import UIKit
import MapKit

class PalletAnnotationView: MKAnnotationView {
    
    struct Constants {
        static let imageDimension: CGFloat = 35
        static let titleLabelWidth: CGFloat = 80
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .secondarySystemBackground
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        // If frame size is not set, it will of zero size and will not respond to tap events
        self.frame = CGRect(x: 0, y: 0, width: Constants.titleLabelWidth, height: Constants.titleLabelWidth)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        setupLayoutConstraints()
        configureAccessoryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let pallet = annotation as? Pallet,
              let image = UIImage(named: pallet.imageName) else { return }
        imageView.image = image
        titleLabel.text = pallet.title
    }
    
    func setupLayoutConstraints() {

        // Set ImageView constraints
        let centeringDimension = (Constants.titleLabelWidth - Constants.imageDimension) / 2
        imageView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: centeringDimension).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.widthAnchor
            .constraint(equalToConstant: Constants.imageDimension).isActive = true
        imageView.heightAnchor
            .constraint(equalToConstant: Constants.imageDimension).isActive = true
        
        // Set titleLabel constraints
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        titleLabel.widthAnchor
            .constraint(equalToConstant: Constants.titleLabelWidth).isActive = true
    }
    
    func configureAccessoryView() {
        canShowCallout = true
        let accessoryView = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        accessoryView.setImage(UIImage(named: "truck"), for: .normal)
        rightCalloutAccessoryView = accessoryView
    }
    
}
