//
//  ShowDetail.swift
//  GoldenTicket
//
//  Created by 안재은 on 01/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// 서버와 연결한 뒤에는 codable 로 작성
// 지금은 colloection view 가 제대로 나타나는지를 위한 테스트용 더미데이터
// 필요한 데이터들 모두 적어둠, 아래 주석 처리는 일단 테스트에서 제외
struct Detail {
    
    var backgroundImage : UIImage?
    var posterImage : UIImage?
    var showTitle: String?
//    var showPrice : String?
//    var showTime : String?
//    var showLocation : String?
//
//    var actorImage : UIImage
//    var actorName : String
//    var actorRole : String
//
//    var showDetailImage : UIImage
    
    init (background : String, poster : String, title: String) {
        
        backgroundImage = UIImage(named: background)
        posterImage = UIImage(named: poster)
        showTitle = title
//        showPrice = price
//        showTime = time
//        showLocation = location
//
    }
    
    
}
