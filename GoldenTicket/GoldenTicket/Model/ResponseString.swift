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
    let data: String? // 비밀번호 틀렸을 때 응답 바디에 데이타가 없으니까 옵셔널 처리를 해줘야 한다.
}
