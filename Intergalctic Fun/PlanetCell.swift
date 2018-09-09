//
//  PlanetCell.swift
//  Intergalctic Fun
//
//  Created by Alaina Rogacki on 9/8/18.
//  Copyright © 2018 Alaina Rogacki. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        planetImage.layer.cornerRadius = 10
    }
    
    func configureCell(planet: String) {
        planetImage.image = UIImage(named: planet)
        planetName.text = planet.capitalized
    }

}
