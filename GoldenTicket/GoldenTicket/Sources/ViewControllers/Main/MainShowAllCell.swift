//
//  MainShowAllCell.swift
//  GoldenTicket
//
//  Created by 안재은 on 11/08/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class MainShowAllCell: UICollectionViewCell {
    
    var showIndex: Int!
    @IBOutlet weak var showImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.makeRounded(cornerRadius: 20)
        
    }
}
