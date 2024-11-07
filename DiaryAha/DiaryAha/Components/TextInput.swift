//
//  TextInput.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct TextInput: View {
    var title: String
    var text: Binding<String>
    var axis: Axis

    init(_ title: String, text: Binding<String>, axis: Axis = .horizontal) {
        self.title = title
        self.text = text
        self.axis = axis
    }

    var body: some View {
        TextField(title, text: text, axis: axis)
            .padding(10)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(Divider()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .background(Color.mainColor), alignment: .bottom)
    }
}

#Preview {
    struct Preview: View {
        @State var text = ""

        var body: some View {
            VStack {
                TextInput("Title", text: $text)
            }
            .padding()
            .frame(maxHeight: .infinity)
            .background(Color.backgroundColor)
        }
    }

    return Preview()
}
