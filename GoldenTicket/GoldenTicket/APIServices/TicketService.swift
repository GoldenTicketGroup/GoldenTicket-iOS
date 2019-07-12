//
//  TicketService.swift
//  GoldenTicket
//
//  Created by 황수빈 on 11/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import Alamofire

struct TicketService {
    
    static let shared = TicketService()
    
    /**
    당첨된 티켓 리스트 조회
     **/
    
    func showTicket(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"
        ]
        
        Alamofire.request(APIConstants.InterestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseArray<WinList>.self, from: value)
                                    // print("interested finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400, 401:
                                completion(.pathErr)
                            case 600:
                                completion(.serverErr)
                                
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                // 통신 실패
                case .failure(let err):
                    print("error",err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
        
    }
    
    
    /**
     당첨된 오늘 티켓 리스트 조회
     **/
    
    func todayTicket(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"
        ]
        
        Alamofire.request(APIConstants.TodayTicketURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseString2.self, from: value)
                                    // print("interested finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 204:
                                // 당첨내역이 존재하지 않습니다.
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseDefault.self, from: value)
                                    print("TicketService totayticket finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 600:
                                completion(.serverErr)
                                
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                // 통신 실패
                case .failure(let err):
                    print("error",err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
        
    }
}
