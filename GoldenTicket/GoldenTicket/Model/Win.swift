//
//  Win.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// 서버와 연결한 뒤에는 codable 로 작성
// 지금은 colloection view 가 제대로 나타나는지를 위한 테스트용 더미데이터
struct Win {
    var winImage: UIImage?
    var winDay: String
    var winTitle: String
    var winPrice: String
    var winLocation: String
    var winTime: String
    
    init(day:String, title: String, price: String, location: String,  time: String, winName: String) {
        self.winImage = UIImage(named: winName)
        self.winDay = day
        self.winTitle = title
        self.winPrice = price
        self.winLocation = location
        self.winTime = time
    }
    
}
