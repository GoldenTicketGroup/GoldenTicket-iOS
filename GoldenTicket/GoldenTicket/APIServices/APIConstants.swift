//
//  APIConstants.swift
//  GoldenTicket
//
//  Created by 황수빈 on 06/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

struct APIConstants {
    // 전역 변수로 사용할 수 있게 APIConstants 선언하여 사용
    static let BaseURL = "https://goldenticket.ga"
    static let AuthURL = BaseURL + "/auth"
    static let LoginURL = BaseURL + "/auth/signin" // 로그인
    static let SignupURL = BaseURL + "/auth/signup" // 회원가입
    
    static let ShowURL = BaseURL + "/show/home"
}
