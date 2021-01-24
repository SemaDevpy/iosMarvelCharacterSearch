//
//  marvelManager.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/24/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import Foundation
import SwiftHash

class marvelManager{
    let basePath = "https://gateway.marvel.com/v1/public/characters?"
    let privateKey = "0f14064e5a47787a54aeaff4b06d9de5cd1464f2"
    let publicKey = "b60674c322f3ce85dc9320cacc33d4a5"
    let limit = 50
    
    
//    let startsWith: String
//          if let name = name, !name.isEmpty {
//              startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
//          } else {
//              startsWith = ""
//          }
    
    
    
    
    func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
//    let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
//    print(url)
    
    
    
}
