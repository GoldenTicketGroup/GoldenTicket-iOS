//
//  WinTicketsVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class WinTicketsVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet var winCollection: UICollectionView!
    
    var winList: [Win] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // collectionView에 들어갈 당첨된 공연의 리스트
        // setWindata()
        
        // likeCollection 의 delegate 와 dataSource 의 위임자를 self 로 지정합니다.
        // winCollection.dataSource = self
        // winCollection.delegate = self
        
    }
    
    // back button 누르면 다시 메인 화면으로 이동하도록.
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
