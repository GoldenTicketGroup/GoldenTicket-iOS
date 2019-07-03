//
//  WinCell.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class WinCell: UICollectionViewCell {
    
    @IBOutlet var winImage: UIImageView!
    
    // 그림자 효과를 위해 image 아웃렛 연결
    @IBOutlet var ticketInfo: UIImageView!
    
    @IBOutlet var winDay: UILabel!
    
    @IBOutlet var winTitle: UILabel!
    
    @IBOutlet var winPrice: UILabel!
    
    @IBOutlet var winLocation: UILabel!
    
    @IBOutlet var winTime: UILabel!
    
}
