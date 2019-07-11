//
//  LotteryService.swift
//  GoldenTicket
//
//  Created by 안재은 on 10/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import Alamofire

struct LotteryService {
    
    static let shared = LotteryService()
    
    /**
     응모 등록하는 메서드
     **/
    
    func lotteryIn(scheduleIdx: Int, completion: @escaping(NetworkResult<Any>)->Void){
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"
        ]
        
        let body : Parameters = [
            "schedule_idx" : scheduleIdx
        ]
        
        Alamofire.request(APIConstants.LotteryURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                //print(response.error?.localizedDescription)
                print("응답 \(response)")
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    // 데이터 encoding 하는 방법
                                    let result = try decoder.decode(ResponseDefault.self, from: value)
                                    // print("finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result))
                                    }
                                } catch {
                                    completion(.pathErr)
                                    // print(error.localizedDescription)   // 에러 출력
                                    // debugPrint(error) // check which key is missing
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
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
     응모 리스트 조회 메서드
     **/
    
    func lotteryList(completion: @escaping(NetworkResult<Any>)->Void) {
        
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"
        ]
        
        Alamofire.request(APIConstants.LotteryURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                //print(response.error?.localizedDescription)
                print("응답 \(response)")
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    // 데이터 encoding 하는 방법
                                    let result = try decoder.decode(ResponseArray<LotteryList>.self, from: value)
                                    // print("finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result))
                                    }
                                } catch {
                                    completion(.pathErr)
                                    // print(error.localizedDescription)   // 에러 출력
                                    // debugPrint(error) // check which key is missing
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
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
     응모 상세 조회 통신 메소드
     **/
    
    func lotteryDetail(ticketIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let token = UserDefaults.standard
        let URL = APIConstants.ShowDetailURL + "/\(ticketIdx)"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"  // token 보내야 함 ( 좋아요 통신 때문에 )
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                //print(response.error?.localizedDescription)
                // print("응답 \(response)")
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    // ShowDetail.swift model
                                    // ResponseShow.swift codable
                                    
                                    // 데이터 encoding 하는 방법
                                    // print("데이터",String(data:value, encoding: .utf8))
                                    let result = try decoder.decode(ResponseArray<Ticket>.self, from: value)
                                    // print("result \(result)")
                                    // print(type(of: result))
                                    // print("finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                    // print(error.localizedDescription)   // 에러 출력
                                    // debugPrint(error) // check which key is missing
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
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
