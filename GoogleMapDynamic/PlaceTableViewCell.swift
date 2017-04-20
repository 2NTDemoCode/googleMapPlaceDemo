//
//  PlaceTableViewCell.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 4/4/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var longLabel: UILabel!
    
    @IBOutlet weak var ratLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var webLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
