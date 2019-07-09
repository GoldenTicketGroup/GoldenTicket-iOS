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
    
    /* 유저(User) */
    static let LoginURL = BaseURL + "/auth/signin" // 로그인
    static let SignupURL = BaseURL + "/auth/signup" // 회원가입
    static let EditUserURL = BaseURL + "/auth/user" // 회원 정보 수정
    
    /* 공연 정보(Show) */
    static let ShowURL = BaseURL + "/show/home"
    static let ShowDetailURL = BaseURL + "/show/detail"
    static let InterestURL = BaseURL + "/show/heart"
    
    /* 검색 (Search) */
    static let SearchURL = BaseURL + "/search/text"
    static let SearchKeywordURL = BaseURL + "/search"
    
    /* -------- 완료 -------- */
    
    /* 응모 (Lottery) */
    static let LotteryURL = BaseURL + "/lottery"
    
    /* 좋아요 (Like) */
    static let LikeURL = BaseURL + "/show/like"
}
