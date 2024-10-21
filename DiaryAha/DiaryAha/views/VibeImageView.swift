//
//  VibeImageView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import SwiftUI

struct VibeImageView: View {
    let imageSize: CGFloat = 75.0
    var vibe: String

    var body: some View {
        Image(systemName: vibe)
            .resizable()
            .scaledToFit()
            .frame(width: imageSize, height: imageSize)
            .background(.gray)
            .cornerRadius(5)
    }
}

#Preview {
    VibeImageView(vibe: "arrow.up")
}
