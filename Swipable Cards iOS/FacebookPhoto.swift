//
//  FacebookPhoto.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 30/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import Foundation

class FacebookPhoto {
    var photoID: String
    var title: String

    init(withID id: String, andTitle title: String){
        self.photoID = id
        self.title = title
    }
}
