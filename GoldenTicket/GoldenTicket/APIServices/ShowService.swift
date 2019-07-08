//
//  ShowService.swift
//  GoldenTicket
//
//  Created by 황수빈 on 07/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import Alamofire

struct ShowService {
    
    static let shared = ShowService()
    
    func getShow(showid: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.ShowURL + "/\(showid)"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "query string" : "id"
        ]
        
        Alamofire.request(URL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header)
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
                                    let result = try decoder.decode(ResponseString.self, from: value)
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
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

