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

//공연의 기본정보를 나타내는 Detail struct
struct ShowDetail: Codable {
    let showIdx: Int
    let imageURL: String
    let name, location, originalPrice, discountPrice: String
    let schedule: [Schedule]
    let artist: [Artist]
    let poster: [Poster]
    /*
    var backgroundImage : UIImage?
    var posterImage : UIImage?
    var showTitle: String?
    var showBeforePrice : String?
    var showAfterPrice : String?
    var showTime : String?
    var showLocation : String?
    var showDetailImage : UIImage?
    
    init (background : String, poster : String, title: String, time: String, bprice: String, aprice:String, location: String, detail: String) {
        
        self.backgroundImage = UIImage(named: background)
        self.posterImage = UIImage(named: poster)
        self.showTitle = title
        self.showBeforePrice = bprice
        self.showAfterPrice = aprice
        self.showTime = time
        self.showLocation = location
        self.showDetailImage = UIImage(named: detail)
    }
 */
}

// MARK: - Artist
struct Artist: Codable {
    let artistIdx: Int
    let name, role: String
    let imageURL: String
}

// MARK: - Poster
struct Poster: Codable {
    let posterIdx: Int
    let imageURL: String
}

// MARK: - Schedule
struct Schedule: Codable {
    let scheduleIdx: Int
    let time: String
    let drawAvailable: Int
}


/*
//공연하는 배우들을 나타내는 Actor struct.

struct Actor {
    
    var actorImage : UIImage?
    var actorName : String
    var castingName : String
    
    init (image : String, name: String, casting: String) {
        
        self.actorImage = UIImage(named: image)
        self.actorName = name
        self.castingName = casting
        
    }
    
}
*/
