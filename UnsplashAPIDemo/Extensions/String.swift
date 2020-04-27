//
//  String.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

extension String {
    func uppercaseFirstCharater() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
