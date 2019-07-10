//
//  LikeService.swift
//  GoldenTicket
//
//  Created by 황수빈 on 10/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import Alamofire

struct LikeService {
    
    static let shared = LikeService()
    
    let token = UserDefaults.standard
    
    
    /* 좋아요를 눌렀을 때 통신 */
    
    func searchShow (_ showIdx: Int, completion: @escaping (NetworkResult<Any>)->Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "header" : "\(token)"
        ]
        
        let body : Parameters = [
            "show_idx" : showIdx
        ]
        
        Alamofire.request(APIConstants.LikeURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
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
                                    
                                    // ResponseDefault.swift codable
                                    let result = try decoder.decode(ResponseDefault.self, from: value)
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.message))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
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
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
