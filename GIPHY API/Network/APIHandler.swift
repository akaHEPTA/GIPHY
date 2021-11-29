//
//  GiphyAPIHandler.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-26.
//

import Foundation
import Alamofire


class APIHandler {
    
    // Shared singleton instance
    static let shared = APIHandler()
    
    private let API_KEY = "CENSORED"
    
    struct EndPoint {
        static let baseURL = "https://api.giphy.com/v1/"
        static let search = "gifs/search?"
        static let trendingSearchTerms = "trending/searches"
    }
    
    private init() { }
    
    func getSearchResult(with query: String, completion: @escaping (Root?) -> Void) {
        let url = EndPoint.baseURL + EndPoint.search
        AF.request(url,
                   method: .get,
                   parameters: ["api_key":API_KEY, "q":query, "limit": "25"],
                   encoding: URLEncoding.default,
                   headers: ["Content-type": "application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let gifs: Root = try JSONDecoder().decode(Root.self, from: response.data!)
                        completion(gifs)
                    } catch {
                        print("JSON Serialization error", error)
                    }
                case .failure(let error):
                    print("error code: \(error._code)")
                    print("error description: \(error.errorDescription!)")
                }
            }
    }
    
    enum NetworkError: Error {
        case client(message: String)
        case server
    }
    
    
}
