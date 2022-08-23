//
//  ApiRequest.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation


protocol RequestProtocol {
  var path: String { get }
}

extension RequestProtocol {
  var host: String {
    APIConstants.host
  }
    
  func createURLRequest() throws -> URLRequest {
      
      if let url = URL(string:host.appending(path)),
         let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
          let urlRequest = URLRequest(url: urlComponents.url!)
          return urlRequest
      } else {
          throw NetworkError.invalidURL
      }
    }
}


enum Request: RequestProtocol {
    case room
    case people
    
    var path: String {
        switch self {
        case .room:
            return "rooms"
        case .people:
            return "people"
        }
    }
}

