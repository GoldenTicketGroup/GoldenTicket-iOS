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
    let schedule: [Schedule]?
    let artist: [Artist]?
    let poster: [Poster]?
}

// MARK: - Schedule
struct Schedule: Codable {
    let scheduleIdx: Int
    let time: String
    let drawAvailable: Int
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
