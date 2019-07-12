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
    
    func showDetail(showIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let token = UserDefaults.standard
        let URL = APIConstants.ShowDetailURL + "/\(showIdx)"
        
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
                            case 200, 204, 205:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    // ShowDetail.swift model
                                    // ResponseShow.swift codable
                                    
                                    // 데이터 encoding 하는 방법
                                    // print("데이터",String(data:value, encoding: .utf8))
                                    let result = try decoder.decode(ResponseShow.self, from: value)
                                    print("result \(result)")
                                    // print(type(of: result))
                                    // print("finish decode")
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
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
                            case 401:
                                completion(.pathErr)
                            case 404:
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
            }// .responseJSON { response in
                // print("Response JSON: \(response.result.value!)")
        //}
    }
    
    
    /**
     관심있는 공연 리스트 띄우는 통신 메소드
     **/
    func showInterest(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let token = UserDefaults.standard
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : "\(token.string(forKey: "token")!)"
        ]
        
        Alamofire.request(APIConstants.InterestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                //print(response.error?.localizedDescription)
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseArray<Like>.self, from: value)
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
}
