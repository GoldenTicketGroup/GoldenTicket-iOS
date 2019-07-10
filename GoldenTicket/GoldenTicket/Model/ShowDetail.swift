//
//  ShowDetail.swift
//  GoldenTicket
//
//  Created by 안재은 on 01/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// 지금은 colloection view 가 제대로 나타나는지를 위한 테스트용 더미데이터
// 필요한 데이터들 모두 적어둠, 아래 주석 처리는 일단 테스트에서 제외

struct ShowDetail: Codable {
    let show_idx: Int
    let image_url: String
    let name, location, duration, original_price, discount_price, background_image: String
    let is_liked: Int
    let schedule: [Schedule]?
    let artist: [Artist]?
    let poster: [Poster]?
}
// MARK: - Schedule
struct Schedule: Codable {
    let schedule_idx: Int
    let time: String
    let draw_available: Int
}

// MARK: - Artist
struct Artist: Codable {
    let artist_idx: Int
    let name, role: String
    let image_url: String
}

// MARK: - Poster
struct Poster: Codable {
    let poster_idx: Int
    let image_url: String
}
