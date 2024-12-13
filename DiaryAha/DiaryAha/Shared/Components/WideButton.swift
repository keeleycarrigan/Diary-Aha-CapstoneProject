//
//  WideButton.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct WideButton: View {
    var color: Color = Color.freshBlue
    var text: String
    let onPress: () -> Void

    init(_ text: String, color: Color = Color.freshBlue, onPress: @escaping () -> Void) {
        self.text = text
        self.onPress = onPress
        self.color = color
    }

    var body: some View {
        Button {
            onPress()
        } label: {
            Text(text)
                .font(.headline)
                .textScale(.default)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
        .foregroundStyle(.white)
        .background(color, in: .buttonBorder)
    }
}

#Preview {
    WideButton("Save") { }
}
