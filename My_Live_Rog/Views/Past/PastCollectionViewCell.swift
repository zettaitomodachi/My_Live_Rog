//
//  PastCollectionViewCell.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/12/02.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class PastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var liveImageView: UIImageView!
    @IBOutlet var liveDateLabel: UILabel!
    @IBOutlet var liveTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!

    // viewcontrollerでいうviewdidload
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
