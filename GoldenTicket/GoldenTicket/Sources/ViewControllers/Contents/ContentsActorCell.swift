//
//  ContentsActorCell.swift
//  GoldenTicket
//
//  Created by 안재은 on 12/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ContentsActorCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorCast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        actorImage.makeRounded(cornerRadius: 38)
    }
}
