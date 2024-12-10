//
//  AppController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/3/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class AppController: ObservableObject {
    var entryIdeas: [String] = []

    func getIdeas(_ then: @escaping (String) -> Void) async throws {
        if (entryIdeas.isEmpty) {
            guard let url = URL(string: Constants.getTopicsURL) else {
                return print("Invalid URL")
            }

            var request = URLRequest(url: url)

            request.httpMethod = "GET"

            let (data, response) = try await URLSession.shared.data(for: request)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }

            do {
                let response = try JSONDecoder().decode(TopicIdeas.self, from: data)

                self.entryIdeas = response.body

                then(response.body.randomElement() ?? "")
            } catch {
                print(error)
            }
        } else {
            then(entryIdeas.randomElement() ?? "")
        }
    }
}
