//
//  imageViewModel.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 19/3/24.
//

import SwiftUI
import Combine




class imageViewModel:ObservableObject {
    // MARK: - Properties.
    
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    @Published var cancallables = Set<AnyCancellable>()
    private let urlString:String
    private let keyImage:String
    
    // MARK: - Create manager Object of CacheManager class & FileManager class.
    
    let cacheManager = CacheManagerPhotoModel.instance
    let fileManager = FileManagerPhotoModel.shared
    
    // MARK: - initiatialization.
    
    init(urlString:String,keyImage:String) {
        self.urlString = urlString
        self.keyImage = keyImage
        getImageFromFileManager()
        //getImageFromCache()
    }
    
    
    // MARK: - Create Function for downloadImages.
    
    func downloadImages()  {
        isLoading = true
        urlSessionTask()
    }
    
    //  MARK: - Create Function to Get Image From Cache.
    
    func getImageFromCache() {
        if let savedImage = cacheManager.getImage(Key:keyImage) {
            image = savedImage
            print("getting image in the cache") }
        
        else {
            downloadImages()
            print("image is downloading")
        }
    }
    
    //  MARK: - Create Function to Get Image From FileManager.
    
    func getImageFromFileManager() {
        if let savedImage = fileManager.getImage(urlKey:keyImage) {
            image = savedImage
            print("getting image in the fileManager")
        } else {
            downloadImages()
            print("image is downloading")
        }
    }
    
    //  MARK: - Create urlSessionTask Function for LoadImages
    
    private func urlSessionTask() {
        guard let url = URL(string: urlString)
        
        else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map({UIImage(data: $0.data)})
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] isLoading in
                self?.isLoading = false
            }
        
    receiveValue: { [weak self] returnedImage in
        guard let self = self,
              let image = returnedImage else {return}
        self.image = image
        //self.cacheManager.addImage(Key: self.keyImage, Value: image)
        self.fileManager.addImage(urlKey: self.keyImage, Image: image)
        
    }
    .store(in: &cancallables)
    }
    
}
