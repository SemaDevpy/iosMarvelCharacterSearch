//
//  marvelManager.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/24/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire
import SwiftyJSON

protocol MarvelManagerDelegate {
    func didUpdateBook(_ marvelManager : MarvelManager, characters: [CharacterModel])
    func didFailWithError(error : Error)
}





class MarvelManager{
    
    var delegate : MarvelManagerDelegate?
    
    
    let basePath = "https://gateway.marvel.com/v1/public/characters?"
    let privateKey = "0f14064e5a47787a54aeaff4b06d9de5cd1464f2"
    let publicKey = "b60674c322f3ce85dc9320cacc33d4a5"
    let limit = 50
    
    var offsetGenerator : Int?{
        let list = 1...1500
        return list.randomElement()
    }
    
    
    func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    
    
    
    
    
    func fetchCharacter(with name : String? = " "){
        var url : String = ""
        let startsWith: String
        if let safeName = name{
            if safeName != " "{
                startsWith = "nameStartsWith=\(safeName.replacingOccurrences(of: " ", with: "%20"))"
                url = basePath + "&limit=\(limit)&" + startsWith + getCredentials()
            }else{
                url = basePath + "&offset=\(offsetGenerator!)&limit=\(limit)&" + getCredentials()
            }
            
        }
        print(url)
        performRequest(with: url)
    }
    
    
    func performRequest(with urlString : String){
        AF.request(urlString).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
        
                var listOfHeroes : [CharacterModel] = []
                
                for ( _,subjson)  in json["data"]["results"]{
                    let name = subjson["name"].stringValue
                    let description = subjson["description"].stringValue
                    let image = subjson["thumbnail"]["path"].stringValue
                    var comics : [String] = []
                    var series : [String] = []
                    var stories : [String] = []
                    var events : [String] = []
                    
                    //iterate over comicses
                    for (_ ,item) in subjson["comics"]["items"]{
                        comics.append(item["name"].stringValue)
                    }
                    //iterate over series
                    for (_ ,item) in subjson["series"]["items"]{
                        series.append(item["name"].stringValue)
                    }
                    //iterate over stories
                    for (_ ,item) in subjson["stories"]["items"]{
                        stories.append(item["name"].stringValue)
                    }
                    //iterate over events
                    for (_ ,item) in subjson["events"]["items"]{
                        events.append(item["name"].stringValue)
                    }
                    //creating hero model
                    let hero = CharacterModel(name: name, description: description, image: image, comics: comics, series: series, stories: stories, events: events)
                    listOfHeroes.append(hero)
                    self.delegate?.didUpdateBook(self, characters: listOfHeroes)
                    
                }
                
                
                
                
                
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
        
        
        
        
        
    }
    
    
    
    
        
    
}
