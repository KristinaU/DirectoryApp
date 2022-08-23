//
//  ServiceError.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case jsonParsingFailed
}
