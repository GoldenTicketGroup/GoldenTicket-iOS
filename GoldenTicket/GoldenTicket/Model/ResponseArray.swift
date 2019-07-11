//
//  ResponseShow.swift
//  GoldenTicket
//
//  Created by 황수빈 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

// MARK: - ResponseArray
// data가 배열인 경우
struct ResponseArray<T: Codable>: Codable  {
    let status: Int
    let success: Bool
    let message: String
    let data: [T]?
}
