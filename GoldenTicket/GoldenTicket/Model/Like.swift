//
//  Like.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// 서버 연결 후 codable로 재작성해야함
// like colloection view 더미 데이터
struct Like {
    var likeImage: UIImage?
    var likeTitle: String
    
    init(title: String, likeName: String) {
        self.likeImage = UIImage(named: likeName)
        self.likeTitle = title
    }
    
}
