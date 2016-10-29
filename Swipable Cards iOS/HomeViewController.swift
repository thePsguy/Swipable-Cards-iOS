//
//  ViewController.swift
//  Swipable Cards iOS
//
//  Created by Pushkar Sharma on 29/10/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit
import Koloda

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cardView: KolodaView!
    
    var photos = [FacebookPhoto]()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        cardView.delegate = self
        cardView.dataSource = self
        refreshImages()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func refreshImages(){
    
        FacebookPhotosManager.shared.getProfileImageAndName { (err, img, name) in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                self.nameLabel.text = name
                self.profileImageView.image = img
            }
        }
        
        FacebookPhotosManager.shared.getPictures { (err, photos) in
            if err != nil {
                print (err?.localizedDescription)
                return
            }
            self.photos = photos!
            self.cardView.reloadData()
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func noTapped(_ sender: AnyObject) {
        self.cardView.swipe(.left)
    }
    
    @IBAction func yesTapped(_ sender: AnyObject) {
        self.cardView.swipe(.right)
    }
    


}

extension HomeViewController: KolodaViewDelegate, KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return photos.count
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        self.refreshImages()
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView = CardView(withImageId: photos[index].photoID, andTitle: photos[index].title)
        return cardView
    }
    

}
