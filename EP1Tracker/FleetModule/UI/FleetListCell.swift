//
//  FleetListCell.swift
//  EP1Tracker
//
//  Created by Jay Muthialu on 2/15/21.
//

import UIKit

class FleetListCell: UITableViewCell {

    @IBOutlet weak var palletLabel: UILabel!
    @IBOutlet weak var palletImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(pallet: Pallet) {
        palletLabel.text = pallet.model
        if let image = UIImage(named: pallet.imageName) {
            palletImageView.image = image
        }
    }
    
}
