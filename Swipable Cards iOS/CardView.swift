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
    var imageID: String?
    
    convenience init(withImageId id: String){
        self.init()
        self.imageID = id
        imageView = CardImageView()
    }
    
    override func layoutSubviews() {
        imageView?.loadFromFacebook(withPhotoID: imageID!)
        imageView?.frame = self.frame.applying(CGAffineTransform(scaleX: 1.0, y: 0.8))
        
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shouldRasterize = true
        
        self.addSubview(imageView!)
    }

}
