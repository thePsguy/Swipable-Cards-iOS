//
//  CardLabelView.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 30/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit

class CardLabelView: UIView {

    var label: UILabel?

    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer

        self.backgroundColor = .white
        let width = self.bounds.width
        let height = self.bounds.height
        label?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        label?.textColor = .gray
        label?.textAlignment = .center
        label?.font = label?.font.withSize(12)
        
        self.addSubview(label!)
    }
    
    convenience init(withText text: String){
        self.init()
        label = UILabel()
        label?.text = text
    }

}
