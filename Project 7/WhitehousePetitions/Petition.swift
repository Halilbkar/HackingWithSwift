//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Halil Bakar on 3.03.2023.
//

import Foundation

struct Petition: Codable {
    
    var title: String
    var body: String
    var signatureCount: Int
}
