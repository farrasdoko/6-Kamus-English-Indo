//
//  TableViewCell.swift
//  Kamus English Indo
//
//  Created by Gw on 09/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelIndo: UILabel!
    @IBOutlet weak var labelEnglish: UILabel!
    @IBOutlet weak var labelID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

