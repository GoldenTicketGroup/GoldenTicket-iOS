//
//  SearchService.swift
//  GoldenTicket
//
//  Created by 안재은 on 09/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import Foundation
import Alamofire

struct SearchService {
    static let shared = SearchService()
    
    func searchShow (_ text: String, completion: @escaping (NetworkResult<Any>)->Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body : Parameters = [
            "text" : text
        ]
        
        Alamofire.request(APIConstants.SearchURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
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
                                    
                                    // Show.swift codable
                                    let result = try decoder.decode(ResponseArray<SearchShow>.self, from: value)
                                    
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
    
    func keywordSearch (_ keyword: String, completion: @escaping (NetworkResult<Any>)->Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body : Parameters = [
            "keyword" : keyword
        ]
        
        Alamofire.request(APIConstants.SearchKeywordURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
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
                                    
                                    // Show.swift codable
                                    let result = try decoder.decode(ResponseArray<SearchShow>.self, from: value)
                                    
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

