//
//  NetworkService.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 4/3/24.
//

import Foundation
import Combine
import SwiftUI

class NetworkService {
    // MARK: - Properties
    static let shared = NetworkService()
    @Published var imageData:[PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    private init() {
        getData()
    }
    
    // MARK: - Create getData Function
    
    private func getData() {
        guard let urlString = URL(string:"https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for:urlString)
            .receive(on:DispatchQueue.main)
            .tryMap(handleOutPut)
            .decode(type: [PhotoModel].self, decoder:JSONDecoder())
            .sink { (completion) in
                switch completion {
                case.finished:
                    break
                case.failure(let error):
                    print("Error download data \(error)")
                    
                }
                
            } receiveValue: {[weak self] model in
                self?.imageData = model
                
            }
            .store(in: &cancellables)
    }
    
    // MARK: - handleOutPut Fuction For Network Call response
    
    private func handleOutPut(dataOutput:URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = dataOutput.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else { throw URLError(.badServerResponse)}
        return dataOutput.data
    }
}





