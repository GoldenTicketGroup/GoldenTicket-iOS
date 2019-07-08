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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
    }

    @IBAction func likeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // 관심있는 공연에 추가되어있음
        }
        else {
            // 관심있는 공연에서 삭제함
        }
    }
}
