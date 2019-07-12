//
//  ContentsVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 04/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ContentsVC: UIViewController {
    
    @IBOutlet weak var goInfoButton: UIButton!
    
    @IBOutlet weak var goInfoButton2: UIButton!
    
    var showIdx : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goInfoButton.makeRounded(cornerRadius: 20)
        goInfoButton2.makeRounded(cornerRadius: 20)
    }
    
    @IBAction func cancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func contentsOne(_ sender: Any) {
        //showIdx = 3
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "ShowDetailVC")
        present(dvc, animated: true)
    }
    
    @IBAction func contentsTwo(_ sender: Any) {
        //showIdx = 13
        
    }
}

//extension ContentsVC {
//    func setDetailData() {
//
//        guard let idx = self.showIdx else { return }
//
//        // print("idx : \(idx)")
//        ShowService.shared.showDetail(showIdx: idx) {
//            [weak self]
//            data in
//
//            guard let `self` = self else { return }
//            //print("data : \(data)")
//            switch data {
//
//            // 매개변수에 어떤 값을 가져올 것인지
//            case .success(let res):
//
//                // 배열이 아니라서 배열로 받을 필요가 없었음 !!!!!!!!!
//                // self.showDetailList = res as! [ShowDetail]
//                // print("any data",self.showDetailList)
//
//                // 1. 공연 하나에 대한 정보만 받아오면 된다.
//                self.showDetail = res as! ShowDetail
//                let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
//
//                dvc.showIdx = idx   // 다음 스토리 보드로 index 넘기기
//
//                // 2. ShowDetail Struct
//                let imageUrlString = self.showDetail.image_url
//                let imageUrl = URL(string: imageUrlString)!
//                let imageData = try! Data(contentsOf: imageUrl)
//                let image = UIImage(data: imageData)
//
//                // 1. posterImg가 있을 때 imageFromUrl을 호출하는데, 초기화 안된 상태이고 nil이니까 초기화를 해줘야 한다.
//                // 2. UIimageView가 아닌 UIImage로 접근해야 한다.
//                dvc.posterImg = image
//                dvc.showName = self.showDetail.name
//                dvc.showLocation = self.showDetail.location
//                dvc.showTime = self.showDetail.duration
//                dvc.showBeforePrice = self.showDetail.original_price
//                dvc.showAfterPrice = self.showDetail.discount_price
//                dvc.checkisLiked = self.showDetail.is_liked     // 다음 스토리보드로 좋아요 여부 보내기
//
//                // image URL 얻어오기
//                let imageUrlString2 = self.showDetail.background_image
//                let imageUrl2 = URL(string: imageUrlString2)!
//                let imageData2 = try! Data(contentsOf: imageUrl2)
//                let backimage = UIImage(data: imageData2)
//
//                dvc.backgroundImg = backimage
//
//                // 다음 시간표 리스트로 스케줄 서버 통신 받아온 데이터 넘기기
//                dvc.timeList = self.showDetail.schedule!
//                self.present(dvc, animated: true)
//                self.navigationController?.pushViewController(dvc, animated: true)
//
//
//                // 2. Poster Struct
//                let poster = self.showDetail.poster
//                dvc.posterList = poster!
//
//                // 2. Actor Struct
//                let artistDetail = self.showDetail.artist
//                // let artistDetail = res as! [Artist]
//
//                // dvc에 있는 배우들 리스트에 서버 통신해서 꽂아주기
//                dvc.artistList = artistDetail!
//
//            case .requestErr(let message):
//                self.simpleAlert(title: "공연 상세 조회 실패", message: "\(message)")
//
//            case .pathErr:
//                print(".pathErr")
//
//            case .serverErr:
//                print(".serverErr")
//
//            case .networkFail:
//                self.simpleAlert(title: "공연 상세 조회 실패", message: "네트워크 상태를 확인해주세요.")
//            }
//        }
//    }
//}
