//
//  ReceiptView.swift
//  My_Live_RogTests
//
//  Created by 妙中美月 on 2019/05/30.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit


@IBDesignable class ReceiptView: UIView {
    
    //影の設定
    @IBInspectable var shadowOffSetWidth : CGFloat = 0  //影の横幅
    @IBInspectable var shadowOffSetHeight : CGFloat = 5  //影の縦幅
    @IBInspectable var shadowColor : UIColor = UIColor.black  //影の色
    @IBInspectable var shadowOpacity : CGFloat = 0.5  //影の不透明度
    
    override func layoutSubviews() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
