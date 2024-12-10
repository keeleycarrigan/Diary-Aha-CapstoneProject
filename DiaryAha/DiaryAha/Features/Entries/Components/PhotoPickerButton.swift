//
//  PhotoPickerButton.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/11/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerButton: View {
    @Binding var pickedPhotos: [PhotosPickerItem]

    var body: some View {
        PhotosPicker(selection: $pickedPhotos, matching: .images) {
            HStack {
                Text("Select images")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.mainColor)
                Image(systemName: "camera.fill")
                    .font(.title3)
                    .foregroundColor(Color.mainColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
    }
}

#Preview {
    @Previewable @State var pickedPhotos: [PhotosPickerItem] = []

    PhotoPickerButton(pickedPhotos: $pickedPhotos)
}
