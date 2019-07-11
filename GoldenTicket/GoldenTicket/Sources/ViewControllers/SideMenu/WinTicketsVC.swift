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
    
    var winList : [WinList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // collectionView에 들어갈 당첨된 공연의 리스트
        setWindata()
        
        // delegate 와 dataSource 의 위임자를 self 로 지정합니다.
        winCollection.dataSource = self
        // winCollection.delegate = self
        
        print(winList.count)
        
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

        // 당첨된 공연의 포스터. ex) 벤허
        cell.winImage.imageFromUrl(like.image_url, defaultImgPath: "https://file.mk.co.kr/meet/neds/2019/04/image_readtop_2019_222216_15549409753706252.jpg")

        cell.winImage.makeRounded(cornerRadius: 20)
        
        // 당첨된 공연의 날짜. ex) 2019년 06월 15일
        cell.winDay.text = like.date
        
        // 당첨된 공연의 제목. ex) 뮤지컬 벤허
        cell.winTitle.text = like.name
        
        // 당첨된 공연의 가격. ex) 일반 R석 20,000원
        cell.winPrice.text = like.price
        
        // 당첨된 공연의 위치. ex) 블루스퀘어 인터파크 홀
        cell.winLocation.text = like.location
        
        // 당첨된 공연의 시간. ex) 17:00~19:00
        cell.winTime.text = like.running_time
        
        cell.ticketInfo.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        return cell
    }
}

extension WinTicketsVC
{
    func setWindata()
    {
        TicketService.shared.showTicket() {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                print("당첨 티켓 리스트 조회 성공")
                let response = res as! ResponseArray<WinList>
                
                // self.winList = response.data as! [WinList]
                self.winList = res as! [WinList]
                print(self.winList.count)
                self.winCollection.reloadData()
                
                
            case .requestErr(let message):
                self.simpleAlert(title: "당첨 티켓 리스트 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "당첨 티켓 리스트 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
}


