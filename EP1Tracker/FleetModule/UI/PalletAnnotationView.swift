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
        static let nameLabelWidth: CGFloat = 80
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
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
        
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepareForReuse")
        imageView.image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        print("prepareForDisplay")
        
        guard let pallet = annotation as? Pallet,
              let image = UIImage(named: pallet.imageName) else { return }
        imageView.image = image
        nameLabel.text = "Delivery - EP"
    }
    
    func setupLayoutConstraints() {
        let centeringDimension = (Constants.nameLabelWidth - Constants.imageDimension) / 2
        imageView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: centeringDimension).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.widthAnchor
            .constraint(equalToConstant: Constants.imageDimension).isActive = true
        imageView.heightAnchor
            .constraint(equalToConstant: Constants.imageDimension).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        nameLabel.widthAnchor
            .constraint(equalToConstant: Constants.nameLabelWidth).isActive = true
    }
    
}
