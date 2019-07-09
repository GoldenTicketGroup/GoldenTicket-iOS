//
//  ResponseShow.swift
//  GoldenTicket
//
//  Created by 황수빈 on 09/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

// MARK: - ResponseShow
struct ResponseShow: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ShowDetail!
}
