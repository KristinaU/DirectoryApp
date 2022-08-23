//
//  RequestManager.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol,  type: T.Type) async throws -> [T]
    
    func getImage(url: URL) async throws -> Data
}

class RequestManager: RequestManagerProtocol {
  let apiManager: APIManagerContract
  init( apiManager: APIManagerContract = APIManager()) {
    self.apiManager = apiManager
  }

  func perform<T: Decodable>(
    _ request: RequestProtocol, type: T.Type) async throws -> [T] {
      let data = try await apiManager.perform(request)
        do {
          return  try JSONDecoder().decode([T].self, from: data)
        }catch {
            throw NetworkError.jsonParsingFailed
        }
  }
    
    func getImage(url: URL) async throws -> Data {
        
        return try await apiManager.perform(url)
    }
}
