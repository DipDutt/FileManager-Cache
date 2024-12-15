//
//  PhotoViewModel.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 4/3/24.
//

import Foundation
import Combine
import SwiftUI

class PhotoViewModel:ObservableObject {
    // MARK: - Properties
    
    @Published var ArrayOfData:[PhotoModel] = []
    let networkManager = NetworkService.shared
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Create Initilization
    init() {
        getDataSubsciber()
    }
    
    // MARK: - Create getDataSubsciber Function to fetch data
    
    /// fetch imagedata from API.
    func getDataSubsciber() {
        networkManager.$imageData
            .sink { [weak self] data in
                self?.ArrayOfData = data
            }
            .store(in: &cancellables)
    }
}
