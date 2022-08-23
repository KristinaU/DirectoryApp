//
//  MockNetworkManager.swift
//  DirectoryAppTests
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
@testable import DirectoryApp

class MockApiManager: APIManagerContract {
    
    private var responsePath = ""

    func perform(_ request: RequestProtocol) async throws -> Data {

        let bundle = Bundle(for:MockApiManager.self)
        
        guard let url = bundle.url(forResource: responsePath, withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
    
    func perform(_ url: URL) async throws -> Data {
        if responsePath == "validUrl" {
            return Data()
        }else {
            throw NetworkError.invalidURL
        }
    }
    
    func enqueue(responsePath: String) {
        self.responsePath = responsePath
    }
 }
