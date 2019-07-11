//
//  Like.swift
//  GoldenTicket
//
//  Created by 황수빈 on 03/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Like
// 관심있는 공연
struct Like: Codable {
    var show_idx: Int
    var image_url: String
    var name: String
}
