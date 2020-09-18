//
//  UserTableViewCell.swift
//  MoyaSample
//
//  Created by Murali Yarramsetti on 06/08/20.
//  Copyright © 2020 Murali Yarramsetti. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
