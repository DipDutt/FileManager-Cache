//
//  downloadImageRow.swift
//  SaveImageisnFileManagerandCache
//
//  Created by Dip Dutt on 19/3/24.
//

import SwiftUI

struct downloadImageRow: View {
    // MARK: - Propertie
   let imageData:PhotoModel
    // MARK: - body
    var body: some View {
        LazyVStack {
            HStack {
                ImageView(
                    url:imageData.url,key:"\(imageData.id)")
                    .frame(width:100, height: 100)
                VStack() {
                    Text(imageData.title)
                        .font(.headline)
                    Text(imageData.url)
                        .font(.caption2)
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    downloadImageRow(imageData: PhotoModel(albumID: 1, id: 1, title: "title", url: "url", thumbnailURL: "thumbnailUR"))
}
