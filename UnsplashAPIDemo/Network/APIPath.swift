//
//  APIPath.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

precedencegroup SlashOperatorPrecedence {
    lowerThan: MultiplicationPrecedence
    higherThan: AdditionPrecedence
    associativity: left
    assignment: false
}

infix operator /: SlashOperatorPrecedence

func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}

struct APIPath {
    struct Unsplash {
        private static let domain = "https://api.unsplash.com"

        struct Photos {
            static var getListPhotos: String { return Unsplash.domain / "photos" }
        }
    }
}
