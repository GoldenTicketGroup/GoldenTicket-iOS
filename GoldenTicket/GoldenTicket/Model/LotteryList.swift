//
//  LotteryList.swift
//  GoldenTicket
//
//  Created by 안재은 on 10/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Foundation

// 응모 리스트
struct LotteryList : Codable {
    let show_idx: Int
    let lottery_idx: Int
    let name: String
    let start_time: String
}
