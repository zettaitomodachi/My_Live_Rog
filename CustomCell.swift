//
//  CustomCell.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/12/01.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var LiveTitle: UILabel!
    @IBOutlet weak var Artist: UILabel!
    @IBOutlet weak var LiveImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
