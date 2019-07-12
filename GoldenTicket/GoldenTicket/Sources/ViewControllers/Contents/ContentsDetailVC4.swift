//
//  ContentsDetailVC4.swift
//  GoldenTicket
//
//  Created by 안재은 on 12/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ContentsDetailVC4: UIViewController {

    @IBOutlet weak var showPoster: UIImageView!
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    struct Actors {
        var actorImage : UIImage?
        var actorCast : String
        var actorName : String
        
        
        init(image: String, cast: String, name : String){
            self.actorImage = UIImage(named: image)
            self.actorCast = cast
            self.actorName = name
        }
    }
    
    var actorList : [Actors] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPoster.makeRounded(cornerRadius: 20)
        actorCollectionView.dataSource = self
        setActor()
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ContentsDetailVC4 : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCell", for: indexPath) as! ContentsActorCell
        
        let actor = actorList[indexPath.row]
        
        cell.actorImage.image = actor.actorImage
        cell.actorCast.text = actor.actorCast
        cell.actorName.text = actor.actorName
        
        return cell
    }
    
    
}

extension ContentsDetailVC4 {
    func setActor() {
        let actor1 = Actors(image: "imgCasting01", cast: "유다벤허", name: "카이")
        let actor2 = Actors(image: "imgCasting02", cast: "메셀라", name: "문종원")
        let actor3 = Actors(image: "imgCasting03", cast: "에스더", name: "김지우")
        let actor4 = Actors(image: "imgCasting04", cast: "퀀터스", name: "유병준")
        
        actorList = [actor1, actor2, actor3, actor4]
    }
}
