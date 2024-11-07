//
//  VibeImageView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import SwiftUI

struct VibeImageView: View {
    let imageSize: CGFloat = 75.0
    var vibe: VibeImages

    var body: some View {
        Image(vibe.id)
            .resizable()
            .scaledToFit()
            .frame(width: imageSize, height: imageSize)
            .background(.gray)
            .cornerRadius(5)
    }
}

#Preview {
    VibeImageView(vibe: VibeImages.happy)
}
