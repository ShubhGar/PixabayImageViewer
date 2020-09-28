//
//  NetworkDataFetcher.swift
//  MyApplication
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
class NetworkDataFetcher: DataFetcherProtocol {
    var dataParser:DataParserProtocol
    init(){
        self.dataParser = JsonDataParser()
    }
    
    func requestData<T:Codable>(url: URL, completion: @escaping (ApiResult<T>) -> Void) {
        let header =  ["Content-Type": "application/x-www-form-urlencoded"]
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            }
            else{
                self.parseResponse(data: data, response: response, completion: completion)
            }
            
        }.resume()
    }
    
    func parseResponse<T:Codable>(data: Data?, response: URLResponse?, completion: @escaping (ApiResult<T>) -> Void){
        if let data = data ,let responseCode = response as? HTTPURLResponse {
            switch responseCode.statusCode {
            case 200:
                if let result:T = self.dataParser.parse(data: data){
                    completion(ApiResult.success(result))
                }
                else{
                    completion(ApiResult.failure(.noDataFound))
                }
            case 400...499:
                completion(ApiResult.failure(.authorizationError(String(data: data, encoding: .utf8) ?? "")))
            case 500...599:
                completion(ApiResult.failure(.serverError))
            default:
                completion(ApiResult.failure(.unknownError))
                break
            }
        }
        else{
            completion(ApiResult.failure(.unknownError))
        }
    }
}
