//
//  SearchVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero
import Kingfisher

class SearchVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    // 좋아요 버튼
    //@IBOutlet weak var likeButton: UIButton!
    
    
    var searchShowList : [SearchShow] = []
    
    var checkisLiked : Int?  // 좋아요가 체크 되어있나요? 0: 아니요. 1: 예
    var showIdx : Int?
    
    //var showDetail : ShowDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.isHidden = true
        
        searchField.attributedPlaceholder = NSAttributedString(string: "어떤 공연을 찾고 계신가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.peach])
        
        // delegate, datasource
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //텍스트 필드 customize.

        searchView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 2)
        searchView.makeRounded(cornerRadius: 22.5)
        searchView.layer.masksToBounds = false
        
        //좋아요 버튼
        if checkisLiked == 1 {
            // 좋아요 되어있어야 함
            //likeButton.isSelected = true
            //            let btnImage = UIImage(named: "iconLikeFill")
            //            self.likeButton.setImage(btnImage , for: .normal)
        }
        else {
            //likeButton.isSelected = false
            //            let btnNoImage = UIImage(named: "iconLikeNoFill")
            //            self.likeButton.setImage(btnNoImage, for: .normal)
        }

    }

    
    @IBAction func backButton(_ sender: Any) {
        // 우선적으로 검색 기록이 남아있는경우 dismiss 해주기
        if collectionView.isHidden == false {
            searchField.text = ""
            collectionView.isHidden = true
        } else {
            let storyboardMain = UIStoryboard.init(name: "Main", bundle: nil)
            let goBack = storyboardMain.instantiateViewController(withIdentifier: "MainVC")
            
            present(goBack, animated: true)
        }
    }
    
    
    @IBAction func goSearch(_ sender: Any) {
        
        guard let searchWord = searchField.text else { return }
        
        if searchField.text ==  searchWord {
            
            SearchService.shared.searchShow(searchWord) {
                data in
                // guard let 'self' = self else {return}
                
                print(searchWord)
                
                switch data {
                case .success(let res) :
                    
                    self.searchShowList = res as! [SearchShow]
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "실패", message: "\(message)")
                    self.collectionView.isHidden = true
                case .pathErr:
                    print(".pathErr")
                    self.collectionView.isHidden = true
                case .serverErr:
                    print(".serverErr")
                    self.collectionView.isHidden = true
                case .networkFail:
                    self.simpleAlert(title: "불러오기 실패", message: "네트워크 상태를 확인해주세요.")
                    self.collectionView.isHidden = true
                }
            }
            
        }
    }
    
    //취소 버튼 누를시 입력 취소
    @IBAction func cancleButton(_ sender: Any) {
        searchField.text = ""
    }
    
    //추천 검색어 누를시 해당 검색어에 대한 공연정보 업로드 - 서버와 통신으로 해당 컬렉션뷰 띄우기
    //print 는 제대로 눌러지는지 테스트용
    @IBAction func recSearchButton(_ sender: UIButton) {
        
        guard let keyword = sender.titleLabel?.text else {return}
        print(keyword)
        
        if sender.titleLabel?.text == keyword {
            SearchService.shared.keywordSearch(keyword) {
                data in
                switch data {
                case .success(let res) :
                    
                    self.searchShowList = res as! [SearchShow]
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "실패", message: "\(message)")
                    self.collectionView.isHidden = true
                case .pathErr:
                    print(".pathErr")
                    self.collectionView.isHidden = true
                case .serverErr:
                    print(".serverErr")
                    self.collectionView.isHidden = true
                case .networkFail:
                    self.simpleAlert(title: "불러오기 실패", message: "네트워크 상태를 확인해주세요.")
                    self.collectionView.isHidden = true
                }
            }
        }
    }
    
    
}

extension SearchVC : UICollectionViewDataSource
{
    
    // UICollectionView 에 얼마나 많은 아이템을 담을 지 설정합니다.
    // 현재는 likeList 배열의 count 갯수 만큼 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print(searchShowList.count)
        return searchShowList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCVCell
        let show = searchShowList[indexPath.row]
        
        cell.showImage.imageFromUrl(show.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/poster_benhur_info.jpg")
        cell.showIdx = show.show_idx
        
        return cell
    }
}

//extension SearchVC : UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let show = searchShowList[indexPath.row]
//        showIdx = show.show_idx  // 1 ~ 17
//        // data setting
//        self.setDetailData()
//    }
//}

extension SearchVC : UICollectionViewDelegateFlowLayout
{
    // Collection View Cell 의 width, height 를 지정할 수 있습니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width: CGFloat = (view.frame.width - 21) / 2
        let height: CGFloat = 236

        return CGSize(width: width, height: height)
    }
}


//extension SearchVC {
//
//    func setDetailData() {
//
//        guard let idx = self.showIdx else { return }
//
//        print("idx : \(idx)")
//        ShowService.shared.showDetail(showIdx: idx) {
//            [weak self]
//            data in
//
//            guard let `self` = self else { return }
//            switch data {
//
//            case .success(let res):
//
//                // 1. 공연 하나에 대한 정보만 받아오면 된다.
//                self.showDetail = res as! ShowDetail
//
////                let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
//
//                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                let dvc = storyboard.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
//
//                dvc.showIdx = idx
//
//                // 2. ShowDetail Struct
//                let imageUrlString = self.showDetail.image_url
//                let imageUrl = URL(string: imageUrlString)!
//                let imageData = try! Data(contentsOf: imageUrl)
//                let image = UIImage(data: imageData)
//
//                // 1. posterImg가 있을 때 imageFromUrl을 호출하는데, 초기화 안된 상태이고 nil이니까 초기화를 해줘야 한다.
//                // 2. UIimageView가 아닌 UIImage로 접근해야 한다.
//                /*
//                 var backImg : UIImage?
//                 var posterI : UIImage?
//                 var showN: String?
//                 var beforeP : String?
//                 var afterP : String?
//                 var showT : String?
//                 var showL : String?
//                 var detailP : UIImageView?
//                 var checkisL : Int?
//                 var a : Int?
//                */
//                dvc.posterI = image
//                dvc.showN = self.showDetail.name
//                dvc.showL = self.showDetail.location
//                dvc.showT = self.showDetail.duration
//                dvc.beforeP = self.showDetail.original_price
//                dvc.afterP = self.showDetail.discount_price
//                dvc.checkisL = self.showDetail.is_liked     // 다음 스토리보드로 좋아요 여부 보내기
//
//                // image URL 얻어오기
//                let imageUrlString2 = self.showDetail.background_image
//                let imageUrl2 = URL(string: imageUrlString2)!
//                let imageData2 = try! Data(contentsOf: imageUrl2)
//                let backimage = UIImage(data: imageData2)
//
//                dvc.backImg = backimage
//
//                // 다음 시간표 리스트로 스케줄 서버 통신 받아온 데이터 넘기기
//                dvc.timeList = self.showDetail.schedule!
//                self.present(dvc, animated: true)
//
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
