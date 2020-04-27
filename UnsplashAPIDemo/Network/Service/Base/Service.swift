//
//  Service.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

enum Method {
    case get
    case post
    case put
    case delete
}

struct Service {
    static let shared = Service()

    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private init() {}

    func getData(url: URL, completion: ((Data?, URLResponse?, Error?) -> Void)?) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            completion?(data, response, error)
        }
        dataTask.resume()
    }
}
