//
//  WinTicketsVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class WinTicketsVC: UIViewController {

    @IBOutlet var winCollection: UICollectionView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    var winList : [Win] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // collectionView에 들어갈 당첨된 공연의 리스트
        
        // delegate 와 dataSource 의 위임자를 self 로 지정합니다.
        winCollection.dataSource = self
        // winCollection.delegate = self
        setWindata()
    }
    
    // back button 누르면 다시 메인 화면으로 이동하도록.
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

// UICollectionViewDataSource 를 채택합니다.
extension WinTicketsVC: UICollectionViewDataSource
{
    
    // UICollectionView 에 얼마나 많은 아이템을 담을 지 설정합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // 당첨내역 리스트에 담긴 공연 수 만큼 반환하기
        return winList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // WinCell은 Sources/Ticket/WinCell.swift 에 위치해있다.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WinCell", for: indexPath) as! WinCell
        
        let like = winList[indexPath.row]
        
        // cell의 정보를 담는다.
        
        // 당첨된 공연의 포스터. ex) 벤허
        cell.winImage.image = like.winImage
        
        // poster 이미지의 corner radius
//        cell.winImage.layer.masksToBounds = true;
//        cell.winImage.layer.cornerRadius = 19;
        
        
        // poster image에 그림자를 넣기 위한 세팅
//        cell.winImage.layer.masksToBounds = false
//        cell.winImage.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cell.winImage.layer.shadowRadius = 6
//        cell.winImage.layer.shadowOpacity = 0.35
//        cell.winImage.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 3), opacity: 0.35, radius: 6)
        cell.winImage.makeRounded(cornerRadius: 20)
        
        // 당첨된 공연의 날짜. ex) 2019년 06월 15일
        cell.winDay.text = like.winDay
        
        // 당첨된 공연의 제목. ex) 뮤지컬 벤허
        cell.winTitle.text = like.winTitle
        
        // 당첨된 공연의 가격. ex) 일반 R석 20,000원
        cell.winPrice.text = like.winPrice
        
        // 당첨된 공연의 위치. ex) 블루스퀘어 인터파크 홀
        cell.winLocation.text = like.winLocation
        
        // 당첨된 공연의 시간. ex) 17:00~19:00
        cell.winTime.text = like.winTime
        
        // ticket image에 그림자를 넣기 위한 세팅
//        cell.ticketInfo.layer.masksToBounds = false
//        cell.ticketInfo.layer.shadowOpacity = 1
//        cell.ticketInfo.layer.shadowRadius = 6
//        cell.ticketInfo.layer.shadowColor = UIColor.black16.cgColor
//        cell.ticketInfo.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.ticketInfo.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        return cell
    }
}

extension WinTicketsVC
{
    func setWindata()
    {
        let win1 = Win(day: "2019년 06월 15일", title: "뮤지컬 벤허", price: "일반 R석 20,000원", location: "블루스퀘어 인터파크 홀", time: "17:00~19:00", winName: "posteKillMeNowInfo")
        
        let win2 = Win(day: "2019년 07월 15일", title: "뮤지컬 킬미나우", price: "S석 2,000원", location: "예술의 전당", time: "17:00~19:00", winName: "posteKillMeNowInfo")

        let win3 = Win(day: "2019년 12월 15일", title: "뮤지컬 인터스텔라", price: "일반 R석 10,000원", location: "올림픽공원 K-아트 홀", time: "11:00~13:00", winName: "posteKillMeNowInfo")
        
        let win4 = Win(day: "2019년 12월 31일", title: "헤어스프레이", price: "자유 입석 1,000원", location: "현대백화점 현대카드 홀", time: "17:00~19:00", winName: "posteKillMeNowInfo")
        
        winList = [win1, win2, win3, win4]
    }
}


