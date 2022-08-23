//
//  NetworkManager.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

protocol APIManagerContract {
    func perform(_ request: RequestProtocol) async throws -> Data
    
    func perform(_ url: URL) async throws -> Data

}

class APIManager: APIManagerContract {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
    
    func perform(_ url: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}

