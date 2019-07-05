//
//  MainVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero
import SideMenu

class MainVC: UIViewController {
    
    @IBOutlet weak var showCollectionView: UICollectionView!
    
    @IBOutlet weak var lotteryCollectionView: UICollectionView!
    
    @IBOutlet weak var monthShowButton: UIButton!
    
    @IBOutlet weak var monthMusicalButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var showList : [Show] = []
    var showDetailList : [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setShowData()
        setDetailData()
        setupSideMenu()
        // Do any additional setup after loading the view.
        showCollectionView.dataSource = self
        showCollectionView.delegate = self
        
        monthShowButton.layer.shadowOpacity = 1
        monthShowButton.layer.shadowRadius = 6
        monthShowButton.layer.shadowColor = UIColor.black16.cgColor
        monthShowButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        monthMusicalButton.layer.shadowOpacity = 1
        monthMusicalButton.layer.shadowRadius = 6
        monthMusicalButton.layer.shadowColor = UIColor.black16.cgColor
        monthMusicalButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        searchButton.layer.cornerRadius = 20
        searchButton.layer.shadowOpacity = 1
        searchButton.layer.shadowRadius = 2
        searchButton.layer.shadowColor = UIColor.black16.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
    
    // 티켓 버튼 누를 시 당첨된 티켓 / 당첨 되지 않았다는 뷰를 보여주는 함수.
    @IBAction func showTicket(_ sender: Any) {
        
        let storyboardNone = UIStoryboard.init(name: "NoTicket", bundle: nil)
        let dvcN = storyboardNone.instantiateViewController(withIdentifier: "NoTicket")
        present(dvcN, animated: true)
        
//        let storyboardWin = UIStoryboard.init(name: "WinTicket", bundle: nil)
//        guard let dvc = storyboardWin.instantiateViewController(withIdentifier: "TicketVC") as? TicketVC else{
//            return
//        }
//        present(dvc, animated: true)
        
    }
    
    @IBAction func onClickSearchButton(_ sender: Any) {
        let storyboardSearch = UIStoryboard.init(name: "Search", bundle: nil)
        guard let dvc = storyboardSearch.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
            return
        }
        present(dvc, animated: true)
    }
    
    // side Menu bar 의 제스쳐를 지정해주는 함수.
    func setupSideMenu() {
        
        // Side Menu 의 애니메이션을 지정
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        // Side Menu 의 이펙트를 지정
        SideMenuManager.default.menuBlurEffectStyle = nil
        
        // Side Menu 가 보일 때 기존 ViewController 의 투명도
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        // Side Menu 의 투명도
        SideMenuManager.default.menuShadowOpacity = 0.3
        // Side Menu 가 보일 때 기존 ViewController 의 크기
        SideMenuManager.default.menuAnimationTransformScaleFactor = 1
        // Side Menu 의 Width
        SideMenuManager.default.menuWidth = 311
        // Side Menu 의 Status Bar 에 대한 침범 여부를 결정
        SideMenuManager.default.menuFadeStatusBar = false
        
    }
    
    
    @IBAction func monthShow(_ sender: Any) {
        
        let storyboardContent = UIStoryboard.init(name: "Contents", bundle: nil)
        let dvc = storyboardContent.instantiateViewController(withIdentifier: "contentsVC")
        present(dvc, animated: true)
        
    }
    
    @IBAction func monthMusical(_ sender: Any) {
        
        
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
        //dvc.showPrice = show.showPrice
        dvc.showBeforePrice = show.showBeforePrice
        dvc.showAfterPrice = show.showAfterPrice
        dvc.showTime = show.showTime
        dvc.showLocation = show.showLocation
        dvc.showDetail = show.showDetailImage
        
        present(dvc, animated: true)
        //navigationController?.pushViewController(dvc, animated: true)
    }
}


// 테스트용 더미 데이터 세팅.
extension MainVC {
    func setShowData() {
        
        let show1 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainKill")
        let show2 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show3 = Show(title: "뮤지컬 위키드", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainWicked")
        let show4 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        showList = [show1, show2, show3, show4]
    }
    
    func setDetailData() {
        
        let showD1 = Detail(background: "backImgInfo", poster: "posteKillMeNowInfo", title: "뮤지컬 벤허", time: "2019.06.15 17:00~19:00", bprice: "150,000", aprice: "20,000", location: "블루스퀘어 인터파크홀", detail: "longMusicalInfo")
        let showD2 = Detail(background: "backImgInfoKillMeNow", poster: "posteKillMeNowInfo", title: "뮤지컬 킬미나우", time: "2019.06.15 17:00~19:00", bprice: "150,000", aprice: "10,000", location: "예술의 전당", detail: "longInfoKillMeNow")
        
        showDetailList = [showD1, showD2, showD2, showD1]
    }
}
