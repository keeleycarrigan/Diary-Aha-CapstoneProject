//
//  EntryDatePicker.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/30/24.
//

import SwiftUI

struct EntryDatePicker: View {
    @Binding var entryDate: Date

    var onChangeDate: () -> Void = { }

    init(entryDate: Binding<Date>, onChangeDate: @escaping () -> Void = {}) {
        _entryDate = entryDate
        self.onChangeDate = onChangeDate
    }

    var body: some View {
        DatePicker("", selection: $entryDate, displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .frame(maxHeight: .infinity)
            .clipped()
            .onChange(of: entryDate) {
                onChangeDate()
            }

    }
}

#Preview {
    @Previewable @State var entryDate: Date = .init()

    EntryDatePicker(entryDate: $entryDate)
}
