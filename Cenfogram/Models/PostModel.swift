//
//  PostModel.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/16/21.
//

import Foundation

struct PostModel: Encodable, Decodable {
    
    var caption: String
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var userName: String
    var profile: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}
