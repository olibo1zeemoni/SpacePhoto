//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Olibo moni on 21/12/2021.
//

import Foundation
struct PhotoInfo: Codable {
    var title: String
    var copyright: String?
    var url: URL
    var description: String
    var date: String
    


    enum CodingKeys: String, CodingKey {
        case description = "explanation"
        case copyright
        case url
        case title
        case date
    }
    
}
