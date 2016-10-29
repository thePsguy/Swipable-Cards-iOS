//
//  CardView.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 29/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit

class CardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imageView: CardImageView?
    var labelView : CardLabelView?
    var imageID: String?
    
    let imageRatio: CGFloat = 0.85
    
    convenience init(withImageId id: String,andTitle title: String){
        self.init()
        self.imageID = id
        imageView = CardImageView()
        labelView = CardLabelView(withText: title)
    }
    
    override func layoutSubviews() {
        imageView?.loadFromFacebook(withPhotoID: imageID!)
        imageView?.frame = self.frame.applying(CGAffineTransform(scaleX: 1.0, y: imageRatio))
    
        labelView?.frame = CGRect(x: self.bounds.minX, y: (self.imageView?.bounds.maxY)!, width: self.bounds.width, height: self.bounds.height * (1 - imageRatio))
        labelView?.layoutSubviews()
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 10
        self.layer.shouldRasterize = true
        
        self.addSubview(imageView!)
        self.addSubview(labelView!)
    }

}
