//
//  ImagesUrlAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct ImagesUrlModel: Codable {

    var thumb: String?
    var small: String?

    private enum CodingKeys: String, CodingKey {
        case thumb, small
    }
}
