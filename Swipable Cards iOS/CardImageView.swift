//
//  CardImageView.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 29/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var activityIndicator: UIActivityIndicatorView?
    
    override func layoutSubviews() {
        
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
//        self.clipsToBounds = true
        self.image = UIImage(named: "SolidGrey")
        self.contentMode = .scaleAspectFill
    }
    
    func loadFromFacebook(withPhotoID id: String){
            FacebookPhotosManager.shared.getImage(forID: id) { (err, img) in
                if err != nil {
                    print(err?.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.image = img
                }
        }
    }

}
