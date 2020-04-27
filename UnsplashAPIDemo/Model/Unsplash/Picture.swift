//
//  Picture.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Picture: Codable, Hashable {
    var id: String?
    var width: Double?
    var height: Double?
    var description: String?
    var urls: PictureURL?

    struct PictureURL: Codable, Hashable {
        var raw: String?
        var full: String?
        var regular: String?
        var small: String?
        var thumb: String?
    }

    static func == (lhs: Picture, rhs: Picture) -> Bool {
        guard let lhsId = lhs.id, let rhsId = rhs.id else { return false }
        return lhsId == rhsId
    }
}
