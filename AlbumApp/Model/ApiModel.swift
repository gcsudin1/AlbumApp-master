//
//  ApiModel.swift
//  AlbumApp
//
//  Created by Sudin on 26/09/19.
//  Copyright © 2019 Sudin. All rights reserved.
//

import Foundation
import UIKit

class Album : Codable
{
    var artistName: String?
    var name: String?
    var artworkUrl100: String?
    var releaseDate: String?
    var copyright: String?
    var genres:[genreList]?
    var url:String?
}

class genreList: Codable
{
    var genreId: String?
    var name: String?
    var url: String?
}

extension Array where Element == genreList {
    
     func getCommaSeparatedValues() -> String {
        
        var value = ""
        for genre in self {
            if let name = genre.name {
                if value.isEmpty {
                    value = name
                } else {
                    value = value + ", \(name)"
                }
            }
        }
        
        return value
    }
}
