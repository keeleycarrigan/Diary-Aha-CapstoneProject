//
//  AddEntryButtonView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import SwiftUI

struct AddEntryButtonView: View {
    @State private var showNewEntry: Bool = false

    var body: some View {
        Button {
            showNewEntry.toggle()
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)

            }
            .frame(width: 55, height: 55)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .foregroundStyle(.white)
        .background(Color.freshBlue, in: .circle)
        .sheet(isPresented: $showNewEntry) {
            EditEntryView()
        }
    }
}

#Preview {
    AddEntryButtonView()
}
