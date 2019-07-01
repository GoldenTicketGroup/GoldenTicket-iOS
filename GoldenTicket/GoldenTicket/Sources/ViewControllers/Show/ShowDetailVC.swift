//
//  ShowDetailVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 01/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ShowDetailVC: UIViewController {

    // detail view에 필요한 정보들.
    var backgroundImg : UIImage?
    var posterImg : UIImage?
    var showName : String?
    var showPrice : String?
    var showTime : String?
    var showLocation : String?
    var showDetail : UIImage?
    
    // 배우들을 보여주는 collection view.
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showPriceLabel: UILabel!
    
    @IBOutlet weak var showTimeLabel: UILabel!
    
    @IBOutlet weak var showLocationLabel: UILabel!

    @IBOutlet weak var showDetailImage: UIImageView!
    
    
    var actorList : [Actor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContent()
        setData()
        // Do any additional setup after loading the view.
        actorCollectionView.dataSource = self
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setContent() {
        backgroundImage.image = backgroundImg
        posterImage.image = posterImg
        showTitle.text = showName
        showPriceLabel.text = showPrice
        showTimeLabel.text = showTime
        showLocationLabel.text = showLocation
        showDetailImage.image = showDetail
    }

}

extension ShowDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actorList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCVCell", for: indexPath) as! ActorCVCell
        
        let actor = actorList[indexPath.row]
        
        cell.actorImage.image = actor.actorImage
        cell.actorName.text = actor.actorName
        cell.castingName.text = actor.castingName
        
        return cell
    }
    
    
}

extension ShowDetailVC {
    
    func setData() {
        let actor1 = Actor(image: "imgCasting01", name: "카이", casting: "유다 벤허")
        let actor2 = Actor(image: "imgCasting02", name: "문종원", casting: "메셀라")
        let actor3 = Actor(image: "imgCasting03", name: "김지우", casting: "에스더")
        let actor4 = Actor(image: "imgCasting04", name: "이병준", casting: "퀸터스")
        
        actorList = [actor1, actor2, actor3, actor4]
    }

}
