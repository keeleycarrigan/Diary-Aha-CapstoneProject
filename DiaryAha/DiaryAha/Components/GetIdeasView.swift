//
//  GetIdeasView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/24/24.
//

import SwiftUI

struct GetIdeasView: View {
    @EnvironmentObject var appController: AppController

    let backgroundColors = [
        Color.barberry,
        Color.freshBlue,
        Color.orangePop
    ]

    @State private var idea = ""
    @State private var backgroundColor: Color = .clear

    func getIdeas() async {
        do {
            try await appController.getIdeas { idea in
                if !idea.isEmpty {
                    self.idea = idea
                    backgroundColor = backgroundColors.randomElement() ?? .clear
                }
            }
        } catch {
            self.idea = "Error: \(error)"
        }

    }

    var body: some View {
        HStack(alignment: .top) {
            Text(idea)
                .foregroundColor(appController.entryIdeas.isEmpty ? Color.accentColor : .white)
            Button(action: {
                Task {
                    await getIdeas()
                }
            }, label: {
                LabelView(showIdea: !appController.entryIdeas.isEmpty)
            })
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(5)
    }
}

extension GetIdeasView {
    struct LabelView: View {
        var showIdea: Bool

        var body: some View {
            HStack {
                Text(showIdea ? "" : "Get Ideas")
                    .font(.title3)

                Image(systemName: showIdea ? "arrow.2.circlepath.circle" : "brain")
                    .symbolRenderingMode(.monochrome)
                    .symbolVariant(.fill)
                    .font(.title2)
                    .symbolEffect(.appear, isActive: false)
            }
            .fontWeight(.medium)
            .foregroundColor(showIdea ? .white : .accentColor)
        }
    }
}

#Preview {
    var appController = AppController()

    GetIdeasView()
        .environmentObject(appController)
        .background(Color.backgroundColor)
}
