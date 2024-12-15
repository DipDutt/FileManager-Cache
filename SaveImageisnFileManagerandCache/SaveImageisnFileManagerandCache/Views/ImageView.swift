//
//  ImageView.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 19/3/24.
//

import SwiftUI

struct ImageView: View {
    // MARK: - Propertie
    @StateObject var imageload:imageViewModel
    
    // MARK: - Create init
    init(url:String,key:String) {
        _imageload = StateObject(
            wrappedValue:imageViewModel(urlString:url,keyImage:key))}
    
    // MARK: - body
    var body: some View {
        ZStack {
            if imageload.isLoading {
                ProgressView()
            }
            else {
                if let image = imageload.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ImageView(url: "https://via.placeholder.com/600/92c952", key:"1")
        .frame(width: 100, height: 100)
}
