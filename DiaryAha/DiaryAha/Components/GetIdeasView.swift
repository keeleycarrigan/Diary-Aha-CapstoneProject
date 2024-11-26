//
//  GetIdeasView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/24/24.
//

import SwiftUI

struct GetIdeasView: View {
    let backgroundColors = [
        Color.barberry,
        Color.freshBlue,
        Color.orangePop
    ]

    @State private var entryIdeas: [String] = []
    @State private var idea = ""
    @State private var backgroundColor: Color = .clear

    func getIdeas() {
        if (entryIdeas.isEmpty) {
            guard let url = URL(string: Constants.getTopicsURL) else {
                return print("Invalid URL")
            }

            var request = URLRequest(url: url)

            request.httpMethod = "GET"

            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                guard let data else { return }

                do {
                    let response = try JSONDecoder().decode(TopicIdeas.self, from: data)
                    entryIdeas = response.body
                    idea = response.body.randomElement() ?? ""
                } catch {
                    print(error)
                }
            }

            task.resume()
        } else {
            idea = entryIdeas.randomElement() ?? ""
        }

        backgroundColor = backgroundColors.randomElement() ?? .clear
    }

    var body: some View {
        HStack(alignment: .top) {
            Text(idea)
                .foregroundColor(entryIdeas.isEmpty ? Color.accentColor : .white)
            Button(action: getIdeas) {
                LabelView(entryIdeas: entryIdeas)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(5)
    }
}

extension GetIdeasView {
    struct LabelView: View {
        var entryIdeas: [String] = []

        var body: some View {
            HStack {
                Text(entryIdeas.isEmpty ? "Get Ideas" : "")
                    .font(.title3)

                Image(systemName: entryIdeas.isEmpty ? "brain" : "arrow.2.circlepath.circle")
                    .symbolRenderingMode(.monochrome)
                    .symbolVariant(.fill)
                    .font(.title2)
                    .symbolEffect(.appear, isActive: false)
            }
            .fontWeight(.medium)
            .foregroundColor(entryIdeas.isEmpty ? Color.accentColor : .white)
        }
    }
}

#Preview {
    GetIdeasView()
        .background(Color.backgroundColor)
}
