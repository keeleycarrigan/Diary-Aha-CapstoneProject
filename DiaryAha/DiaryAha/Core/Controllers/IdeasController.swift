//
//  IdeasController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/3/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class IdeasController: ObservableObject {
    var entryIdeas: [String] = []

    func getIdeas(_ then: @escaping (String) -> Void) async throws {
        if entryIdeas.isEmpty {
            guard let url = URL(string: "\(Constants.API.baseURL)\(Constants.API.topicsEndpoint)") else {
                throw APIError.invalidURL
            }

            let request = URLRequest(url: url)

            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw APIError.invalidResponse
                }

                do {
                    let response = try JSONDecoder().decode(TopicIdeas.self, from: data)
                    self.entryIdeas = response.body
                    then(response.body.randomElement() ?? "")
                } catch {
                    throw APIError.decodingError(error)
                }
            } catch let error as APIError {
                throw error
            } catch {
                throw APIError.networkError(error)
            }
        } else {
            then(entryIdeas.randomElement() ?? "")
        }
    }
}
