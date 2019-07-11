//
//  ResponseString.swift
//  GoldenTicket
//
//  Created by 황수빈 on 06/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation

// MARK: - ResponseString
// 성공했을 때 response body
struct ResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let user_idx: Int
    let email, name, phone, token: String
}
