//
//  Show.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Show
// 공연 메인 뷰 통신 모델
struct Show: Codable {
    let show_idx:Int
    let image_url:String
    let name:String
    let location:String
    let running_time:String
}
