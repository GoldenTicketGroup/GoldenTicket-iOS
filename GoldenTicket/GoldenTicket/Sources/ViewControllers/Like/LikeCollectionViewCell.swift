//
//  LikeCollectionViewCell.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    // LikeCollection - LikeCollectionViewCell - ContentView - Image
    @IBOutlet var likeImg: UIImageView!
    
    // 해당 공연 정보의 title 저장하는 변수
    // 현재 이 뷰에서 각각 공연 정보 뷰로 넘어간다면 받아야 함
    // @IBOutlet var likeTitle: UILabel!
    // var clicked : Bool = false
    
    // 객체 초기화
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
    }
}
