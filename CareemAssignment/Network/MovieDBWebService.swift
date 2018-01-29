//
//  MovieDBWebService.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class MovieDBWebService : MovieDBService {

    private let baseURL = URL(string: "http://api.themoviedb.org/3")!
    private let imageURL = URL(string: "http://image.tmdb.org/t/p")!
    private let apiKey = "2696829a81b1b5827d515ff121700838"

    private let client: WebClient
    private let decoder: JSONDecoder

    init(_ client: WebClient) {
        self.client = client
        self.decoder = JSONDecoder()
    }

    private func execute<T : Decodable>(_ request: WebRequest, type: T.Type,
                                        completion: @escaping (_ result: Result<T>) -> Void) {
        client.execute(request: request) { (response) in
            if let error = response.error {
                completion(.failure(error))
            } else {
                do {
                    let result = try self.decoder.decode(type, from: response.data!)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - Movies Searching

    func searchMovies(query: String, page: Int, completion: @escaping (_ result: Result<SearchResponse>) -> Void) {
        let request = WebRequest(
            method: .get,
            url: URL(
                base: baseURL,
                path: "/search/movie",
                parameters: [
                    "api_key": apiKey,
                    "query": query,
                    "page": page.description
                ]
            )!
        )
        execute(request, type: SearchResponse.self, completion: completion)
    }

    // MARK: - Image URL Building

    func posterURL(from imagePath: String, with posterSize: PosterSize) -> URL? {
        return imageURL.appendingPathComponent("/\(posterSize.rawValue)/\(imagePath)")
    }
}
