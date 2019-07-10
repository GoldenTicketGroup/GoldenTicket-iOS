//
//  ResponseLottery.swift
//  GoldenTicket
//
//  Created by 안재은 on 10/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

struct ResponseLottery : Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LotteryList!
}
