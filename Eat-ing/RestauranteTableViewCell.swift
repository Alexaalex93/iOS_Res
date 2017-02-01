//
//  RestauranteTableViewCell.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit

class RestauranteTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
