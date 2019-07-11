//
//  InterestedVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero

class InterestedVC: UIViewController {

    // UICollectionView 의 Outlet 변수
    @IBOutlet var likeCollection: UICollectionView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var imgNoFavorite: UIImageView!
    
    // UICollectionView 에 들어가게 될 모델 타입의 배열을 생성합니다.
    var likeList: [Like] = []
    var showIdx : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // collectionView에 들어갈 cell의 data setting
        setLikedata()
        
        // likeCollection 의 delegate 와 dataSource 의 위임자를 self 로 지정합니다.
        likeCollection.dataSource = self
        likeCollection.delegate = self
        
        // likeCollection 에 handleLongPreeGesture 를 추가합니다.
    likeCollection.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:))))
        
    }
    
    
    @IBAction func likeBtn(_ sender: UIButton)
    {
        // 선택 되었을 때는 선택 안된 걸로, 선택 안되어있을 때는 선택 된걸로 바꾸기
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // 관심있는 공연에 추가되어있음
        }
        else {
            // 관심있는 공연에서 삭제함
        }
    }
    
    /*
     gesture 를 구현하는 메소드입니다.
     */
    
    @objc func handleLongPressGesture(gesture: UIGestureRecognizer)
    {
        
        // gesture 가 발생한 좌표를 반환합니다.
        let location = gesture.location(in: self.likeCollection)
        
        // 해당 좌표에 likeCollection 의 item 이 존재한다면 indexPath 에 해당 item 의 index 를 반환합니다.
        guard let indexPath = likeCollection.indexPathForItem(at: location) else {return}
        
        // 해당하는 index 의 model 를 반환합니다.
        // let item = likeList[indexPath.row]
        
        /*
        // alert 를 발생하는 메소드입니다.
        let alert = UIAlertController(title: "\(item.item_name)", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler:
            { (_) in
                
                // likeList 배열에서 해당 모델을 제거합니다.
                self.likeList.remove(at: indexPath.item)
                
                // likeCollection 에서 해당하는 index 의 item 을 삭제합니다.
                self.likeCollection.deleteItems(at: [indexPath])
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // alert 를 화면에 발생시킵니다.
        present(alert, animated: true, completion: nil)
         */
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// UICollectionViewDataSource 를 채택합니다.
extension InterestedVC: UICollectionViewDataSource
{
    
    // UICollectionView 에 얼마나 많은 아이템을 담을 지 설정합니다.
    // 현재는 likeList 배열의 count 갯수 만큼 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return likeList.count   // 0
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as! LikeCollectionViewCell
        
        let like = likeList[indexPath.row]
        
        cell.likeImg.imageFromUrl(like.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/poster_main_benhur.jpg")
            // cell.likeTitle.text = like.name
        return cell
    }
}

/* UICollectionViewDelegateFlowLayout 을 채택 */
extension InterestedVC: UICollectionViewDelegateFlowLayout
{
    // Collection View Cell 의 width, height 를 지정할 수 있습니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width: CGFloat = (view.frame.width - 44) / 2
        let height: CGFloat = width * 184 / 137
        
        return CGSize(width: width, height: height)
    }
}

extension InterestedVC
{
    func setLikedata()
    {
        ShowService.shared.showInterest() {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                
                // response에서 data만 갖고 오기 위한 type casting 코드
                let like_data = res as! ResponseArray<Like>
                print(type(of:like_data))
                
                self.likeList = like_data.data as! [Like]
                
                if self.likeList.count == 0 {
                    // 관심있는 공연 있으면 이미지 보이기
                    self.imgNoFavorite.isHidden = false
                }
                else {
                    // 관심있는 공연 없으면 이미지 숨기기
                    self.imgNoFavorite.isHidden = true
                }
                
                self.likeCollection.reloadData()
                print("관심있는 공연 조회 성공")

                
            case .requestErr(let message):
                self.simpleAlert(title: "관심있는 공연 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "관심있는 공연 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
}


