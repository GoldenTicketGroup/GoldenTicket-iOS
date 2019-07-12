//
//  SearchCVCell.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class SearchCVCell: UICollectionViewCell {

    @IBOutlet weak var showImage: UIImageView!
    var showIdx: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
    }
    
    @IBAction func onClickedLikeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let idx = self.showIdx else { return }
        
        // 선택되어 있으면
        if sender.isSelected {
            print("좋아요")
            
            // 좋아요 통신
            LikeService.shared.pickLike(idx) {
                [weak self]
                data in
                
                guard let `self` = self else { return }
                print("data : \(data)")
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let res):
                    print("좋아요 성공")
                    sender.isSelected = true   // 버튼 선택 안된걸로 바꿈
                    
                case .requestErr(let message):
                    print ("title: 좋아요 추가 실패, message: \(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    print("title: 좋아요 추가 실패, message: 네트워크 상태를 확인해주세요.")
            }
        }
        }
        else {
            print("좋아요 취소")
            
            // 좋아요 통신
            LikeService.shared.pickNoLike(idx) {
                [weak self]
                data in
                
                guard let `self` = self else { return }
                //print("data : \(data)")
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let res):
                    sender.isSelected = false
                    print("좋아요 취소 성공")
                    
                case .requestErr(let message):
                    print ("title: 좋아요 추가 실패, message: \(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    print("title: 좋아요 추가 실패, message: 네트워크 상태를 확인해주세요.")
                }
            }
        }
    }
}
