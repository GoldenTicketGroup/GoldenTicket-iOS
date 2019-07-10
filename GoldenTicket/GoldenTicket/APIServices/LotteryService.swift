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
    
    func lottery(scheduleIdx: Int, completion: @escaping(NetworkResult<Any>)->Void){
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "header" : "\(token.string(forKey: "token")!)"
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
                                    let result = try decoder.decode(ResponseArray<Lottery>.self, from: value)
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
}
