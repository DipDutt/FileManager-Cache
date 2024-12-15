//
//  PhotoModel.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 4/3/24.
//

import Foundation

struct PhotoModel:Identifiable,Codable {
    // MARK: Properties
    let albumID:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailURL:String
  // MARK: - enum
    enum CodingKeys: String, CodingKey {
            case albumID = "albumId"
            case id, title, url
            case thumbnailURL = "thumbnailUrl"
        }
}
