//
//  WinTicket.swift
//  GoldenTicket
//
//  Created by 황수빈 on 11/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

// MARK: - Win
// 오늘 당첨된 티켓
struct ResponseString2: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: WinTicket?
}

// MARK: - WinTicket
struct WinTicket: Codable {
    let is_paid, ticket_idx: Int
    let qr_code: String
    let image_url: String
    let date, name, seat_type, seat_name: String
    let price, location, running_time: String
}
