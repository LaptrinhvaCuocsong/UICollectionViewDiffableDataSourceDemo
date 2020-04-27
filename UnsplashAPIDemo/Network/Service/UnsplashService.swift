//
//  UnsplashService.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct UnsplashService {
    private static let cliendKey = "client_id"
    private static let accessKey = "gCoWdVe_gZLCXdupXAgH9RzV13jNOvWyAC7sUZqXnpE"

    struct Photos {
        static let shared = Photos()

        enum OrderType: String {
            case latest
            case oldest
            case popular
        }

        private init() {}

        func getPhotos(query: String = "", page: Int = 1, perPage: Int = 10, orderBy: OrderType = .latest, completion: (([Picture]?, Error?) -> Void)?) {
            let params = ["query": query,
                          "page": String(page),
                          "per_page": String(perPage),
                          "order_by": orderBy.rawValue]
            guard let url = UnsplashService.createURL(from: APIPath.Unsplash.Photos.getListPhotos, params: params) else { return }
            Service.shared.getData(url: url) { data, response, error in
                if let error = error {
                    completion?(nil, error)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let pictures = try? Service.decoder.decode([Picture].self, from: data) else {
                    completion?(nil, nil)
                    return
                }
                completion?(pictures, nil)
            }
        }
    }

    static func createURL(from urlPath: String, params: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: urlPath) else { return nil }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        params.forEach { args in
            queryItems.append(URLQueryItem(name: args.key, value: args.value))
        }
        queryItems.append(URLQueryItem(name: cliendKey, value: accessKey))
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
