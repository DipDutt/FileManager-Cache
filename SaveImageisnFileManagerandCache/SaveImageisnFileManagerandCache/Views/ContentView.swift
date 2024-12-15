//
//  ContentView.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Propertie
    @StateObject var vm = PhotoViewModel()
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.ArrayOfData) { imageData in
                    downloadImageRow(imageData:imageData)
                    
                }
            }
            .navigationTitle("Images")
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
