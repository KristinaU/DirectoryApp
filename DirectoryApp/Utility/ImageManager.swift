//
//  ImageManager.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

protocol ImageCacherContract {
    func getImage(url:String)-> Data?
    func saveImage(url:String, data:Data)
}

final class ImageManager {
    static let shared = ImageManager()
    private static var imageCache:[String: Data] = [:]
    private init(){ }
}

extension ImageManager: ImageCacherContract {
    func getImage(url: String) -> Data? {
        return ImageManager.imageCache[url]
    }

    func saveImage(url: String, data: Data) {
        ImageManager.imageCache[url] = data
    }
}
