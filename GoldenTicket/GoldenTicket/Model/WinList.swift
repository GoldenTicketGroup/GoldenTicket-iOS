//
//  Win.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Win
// 당첨 티켓 모델
struct WinList : Codable {
    let ticket_idx: Int
    let qr_code: String
    let image_url: String
    let date, name: String
    let seat_type, seat_name: String?
    let price, location, running_time: String
}
