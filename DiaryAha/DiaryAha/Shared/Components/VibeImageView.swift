//
//  VibeImageView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import SwiftUI

struct VibeImageView: View {
    var vibe: VibeImages

    var body: some View {
        Image(vibe.id)
            .resizable()
            .scaledToFit()
            .frame(width: Constants.UI.imageSize, height: Constants.UI.imageSize)
            .background(.gray)
            .cornerRadius(5)
    }
}

#Preview {
    VibeImageView(vibe: VibeImages.happy)
}
