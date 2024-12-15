//
//  FileManagerClass.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 22/3/24.
//

import Foundation
import SwiftUI


class FileManagerPhotoModel {
    // MARK: - Properties
    static let shared = FileManagerPhotoModel()
    private let folderName = "download_Images"
    private let fileMangerDefault = FileManager.default
    
    // MARK: - Create Initialization
    private init() {
        createFolderIfNeeded()
    }
    
    // MARK: - Create Folder Function
   private  func createFolderIfNeeded() {
       
        guard let url = getFolderPath() else { return }
        if !fileMangerDefault.fileExists(atPath:url.path) {
            do {
                try fileMangerDefault.createDirectory(at: url, withIntermediateDirectories:true)
                print("sucessfully create a folder")
            } catch let error {
                print("getting error Folder.\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Create addImage Function.
    
    func addImage(urlKey:String, Image:UIImage) {
        guard let data = Image.pngData(),
              let imageUrlPath = getImagepath(key:urlKey) else {return}
        
        do {
            try data.write(to: imageUrlPath)
        } catch let error {
            print("Error getting add image to Filemanager:\(error.localizedDescription)")
        }
    }
    
    // MARK: - Create getImage Function.
    
    /// get images from filemanager
    /// - Parameter urlKey: urlKey to get images id.
    /// - Returns: optional images.
    func getImage(urlKey:String)-> UIImage? {
        guard let imageUrlPath = getImagepath(key:urlKey),
              fileMangerDefault.fileExists(atPath: imageUrlPath.path) else { return  nil}
        return UIImage(contentsOfFile: imageUrlPath.path)
    }
    
    
    // MARK: - Create getFolderPath Function.
    
   private func getFolderPath()-> URL? {
        return fileMangerDefault.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // MARK: - Create getImagepath Function.
  private func getImagepath(key:String) -> URL? {
        guard let path = getFolderPath() else { return  nil }
        return path.appendingPathComponent(key + ".png")
    }
    
    
    
}
