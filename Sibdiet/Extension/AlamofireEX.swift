//
//  AlamofireEX.swift
//  Sibdiet
//
//  Created by freeman on 10/30/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Alamofire
extension Alamofire.SessionManager{
    @discardableResult
    open func requestWithoutCache( _ url: URLConvertible,
                                   method: HTTPMethod = .get,
                                   parameters: Parameters? = nil,
                                   encoding: ParameterEncoding = URLEncoding.default,
                                   headers: HTTPHeaders? = nil) -> DataRequest {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}
