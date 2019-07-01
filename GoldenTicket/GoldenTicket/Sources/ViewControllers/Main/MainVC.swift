//
//  MainVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var showCollectionView: UICollectionView!
    
    
    var showList : [Show] = []
    var showDetailList : [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setShowData()
        setDetailData()
        // Do any additional setup after loading the view.
        showCollectionView.dataSource = self
        showCollectionView.delegate = self
        
        
    }
}

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return showList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainShowCell", for: indexPath) as! MainShowCell
        
        let show = showList[indexPath.row]
        
        cell.showImage.image = show.showImage
        cell.showLocation.text = show.showLocation
        cell.showTime.text = show.showTime
        cell.showTitle.text = show.showTitle
        
        return cell
    }
    
    
}

extension MainVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
        
        let show = showDetailList[indexPath.row]
        
        dvc.backgroundImg = show.backgroundImage
        dvc.posterImg = show.posterImage
        dvc.showName = show.showTitle
        dvc.showPrice = show.showPrice
        dvc.showTime = show.showTime
        dvc.showLocation = show.showLocation
        dvc.showDetail = show.showDetailImage
        
        present(dvc, animated: true)
        //navigationController?.pushViewController(dvc, animated: true)
        
    }
}


extension MainVC {
    func setShowData() {
        
        let show1 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show2 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show3 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show4 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        showList = [show1, show2, show3, show4]
    }
    
    func setDetailData() {
        
        let showD1 = Detail(background: "backImgInfo", poster: "posterBenhurInfo", title: "뮤지컬 벤허", time: "2019.06.15 17:00~19:00", price: "150,000 -> 20,000", location: "블루스퀘어 인터파크홀", detail: "longMusicalInfo")
        let showD2 = Detail(background: "backImgInfoKillMeNow", poster: "posteKillMeNowInfo", title: "뮤지컬 킬미나우", time: "2019.06.15 17:00~19:00", price: "150,000 -> 20,000", location: "예술의 전당", detail: "longInfoKillMeNow")
        
        showDetailList = [showD1, showD2, showD2, showD1]
    }
}
