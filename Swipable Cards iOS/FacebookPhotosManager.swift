//
//  FacebookPhotos.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 29/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import Foundation
import FBSDKCoreKit

class FacebookPhotosManager {

    static let shared = FacebookPhotosManager()
    private init(){}
    
    var photos = [FacebookPhoto]()
    
    func getPictures(completion: @escaping (Error?, [FacebookPhoto]?) -> Void){
        let photosPath = "/" + FBSDKAccessToken.current().userID + "/photos"
        let request = FBSDKGraphRequest(graphPath: photosPath, parameters: nil, httpMethod: "GET")
        
        request?.start(completionHandler: { (_, res, err) in
            if err != nil {
                print("Request Error")
                completion(err, nil)
            }
            print(res)
            let photos = (res as! NSDictionary)["data"] as! NSArray
                for photo in photos {
                    let id = (photo as! NSDictionary)["id"] as! String
                    if let title = (photo as! NSDictionary)["name"] as? String {
                        self.photos.append(FacebookPhoto(withID: id, andTitle: title))
                    } else {
                        self.photos.append(FacebookPhoto(withID: id, andTitle: "No Caption"))
                    }
            }
            completion(nil, self.photos)
        })
    }
    
    func getProfileImageAndName(completion: @escaping (Error?, UIImage?, String?) -> Void){
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture,name"], httpMethod: "GET")
        
        request?.start(completionHandler: { (_, res, err) in
            if err != nil {
                print("Request Error")
                completion(err, nil, nil)
            }
            let resDict = (res as! NSDictionary)
            let pictureData = (resDict["picture"] as! NSDictionary)["data"] as! NSDictionary
            let imageUrl = URL(string: pictureData["url"] as! String)
            let name = resDict["name"] as! String
            URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    completion(error, nil, nil)
                }
                let image = UIImage(data: data!)
                completion(nil, image, name)
            }).resume()
            
        })
    
    }
    
    func getImage(forID id: String, completion: @escaping (Error?, UIImage?) -> Void){
        let imagePath = "/" + id
        let request = FBSDKGraphRequest(graphPath: imagePath, parameters: ["fields":"images"], httpMethod: "GET")
    
        request?.start(completionHandler: { (_, res, err) in
            if err != nil {
                print("Request Error")
                completion(err, nil)
            }
            let images = (res as! NSDictionary)["images"] as! NSArray
            let firstImage = images[images.count / 2] as! NSDictionary
            let imageUrl = URL(string: firstImage["source"] as! String)

            URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    completion(error, nil)
                }
                    let image = UIImage(data: data!)
                    completion(nil, image)
            }).resume()
        
        })
        
    }
    
}
