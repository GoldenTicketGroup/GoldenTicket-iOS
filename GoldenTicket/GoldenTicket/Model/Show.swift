//
//  Show.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import UIKit

// 서버와 연결한 뒤에는 codable 로 작성
// 지금은 colloection view 가 제대로 나타나는지를 위한 테스트용 더미데이터
struct Show: Codable {
    let show_idx:Int
    let image_url:String
    let name:String
    let location:String
    let running_time:String
}

/*
struct ShowData:Codable {
    let show_idx:Int
    let image_url:String
    let name:String
    let location:String
    let running_time:String
}
 
 struct Show: Codable {
 let showImage: Int?
 let showTitle: String
 let showLocation: String
 let showTime: String
 }
*/
