//
//  RestauranteDetailTableViewCell.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit

class RestauranteDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var campoLabel: UILabel!
    @IBOutlet var valorLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
