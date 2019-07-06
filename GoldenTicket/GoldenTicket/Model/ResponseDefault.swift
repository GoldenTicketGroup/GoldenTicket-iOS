//
//  ResponseDefault.swift
//  GoldenTicket
//
//  Created by 황수빈 on 06/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

// MARK: - ResponseDefault
// 실패했을 때 response body
struct ResponseDefault: Codable {
    let status: Int
    let success: Bool
    let message: String
}
