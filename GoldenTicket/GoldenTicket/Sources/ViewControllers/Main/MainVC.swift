//
//  MainVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchButton: CustomButton!
    
    @IBOutlet weak var showCollectionView: UICollectionView!
    
    
    var showList : [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 검색 버튼 그림자 추가
//        searchButton.layer.shadowColor = UIColor.black16.cgColor
//        searchButton.layer.shadowOffset = CGSize(width: 0, height: 0)
//        searchButton.layer.shadowRadius = 3
//        searchButton.layer.shadowOpacity = 1
//
//        // show data
//        showCollectionView.dataSource = self
//
        setNavigationBarClear()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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



extension MainVC {
    func setShowData() {
        
        let show1 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show2 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show3 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show4 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        showList = [show1, show2, show3, show4]
    }
}
