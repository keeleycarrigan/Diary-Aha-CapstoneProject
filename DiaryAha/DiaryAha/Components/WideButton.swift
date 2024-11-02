//
//  WideButton.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct WideButton: View {
    var text: String
    let onPress: () -> Void

    init(_ text: String, onPress: @escaping () -> Void) {
        self.text = text
        self.onPress = onPress
    }

    var body: some View {
        Button {
            onPress()
        } label: {
            Text(text)
                .font(.headline)
                .textScale(.default)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.freshBlue, in: .buttonBorder)
    }
}

#Preview {
    WideButton("Save") { }
}
