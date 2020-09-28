//
//  DataFetcherProtocol.swift
//  MyApplication
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

protocol DataFetcherProtocol {
    func requestData<T:Codable>(url:URL,completion: @escaping (ApiResult<T>)->Void)
}


typealias parameters = [String:Any]
   
enum ApiResult<T:Codable> {
       case success(T)
       case failure(RequestError)
   }

   enum HTTPMethod: String {
       case options = "OPTIONS"
       case get     = "GET"
       case head    = "HEAD"
       case post    = "POST"
       case put     = "PUT"
       case patch   = "PATCH"
       case delete  = "DELETE"
       case trace   = "TRACE"
       case connect = "CONNECT"
   }

   enum RequestError: Error {
       case unknownError
       case connectionError
       case authorizationError(String)
       case invalidRequest
       case noDataFound
       case invalidResponse
       case serverError
       case serverUnavailable
   }

public enum DataError {
    case internetError(String)
    case serverMessage(String)
}
