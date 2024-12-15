//
//  ClassCacheManager.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 19/3/24.
//

import Foundation
import SwiftUI

class CacheManagerPhotoModel {
    // MARK: - Properties
    static let instance = CacheManagerPhotoModel()
    private init() {}
    
    // MARK: - Cache
    var PhotoCache:NSCache<NSString,UIImage> = {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    // MARK: - Create Function addImage
    /// addImage from cachemanager
    /// - Parameters:
    ///   - Key: This key is for urlString.
    ///   - Value: set Images getting from an api.
    func addImage(Key:String, Value:UIImage) {
        PhotoCache.setObject(Value, forKey: Key as NSString)
    }
    // MARK: - Create Function getImage
    
    /// Get image from cachemanager.
    /// - Parameter Key: This key is for urlString.
    /// - Returns: It returns an optional image.
    func getImage(Key:String)-> UIImage? {
        PhotoCache.object(forKey:Key as NSString)
    }
}
