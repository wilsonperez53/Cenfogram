//
//  UserModel.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/8/21.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageURL: String
    var userName: String
    var searchName: [String]
    var bio : String
    
}
