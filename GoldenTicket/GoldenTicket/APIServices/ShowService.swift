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
    
    /**
     홈 화면 공연 띄우는 통신 메소드
     **/
    
    static let shared = ShowService()
    
    func showHome(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.ShowURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
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
                                    let result = try decoder.decode(ResponseArray<Show>.self, from: value)
                                    
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
    
    
    /**
     공연 상세 조회 통신 메소드
     **/
    
    func showDetail(_ show_id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.ShowDetailURL + "/\(show_id)"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("통신상태 : \(status)")
                            
                            switch status {
                            case 200:
                                do {
                                    print("접근주소 : \(URL)")
                                    print("-----start decode-----")
                                    let decoder = JSONDecoder()
                                    
                                    // ShowDetail.swift model
                                    // ResponseShow.swift codable
                                    
                                    print("서버에서 받는 데이타 : \(value)")   // 1503 bytes
                                    
                                    let result = try decoder.decode(ResponseShow.self, from: value)
                                    print("finish decode")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                    print(error.localizedDescription)   // 에러 출력
                                    debugPrint(error) // check which key is missing
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
