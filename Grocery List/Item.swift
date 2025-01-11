//
//  Item.swift
//  Grocery List
//
//  Created by Kyaw Thant Zin(George) on 1/11/25.
//

import Foundation
import SwiftData

//@Model means we want to be able to load and save any grocery list using database
@Model
class Item{
    var title: String
    var isCompleted : Bool
    
    init(title: String, isCompleted: Bool = false){
        self.title = title
        self.isCompleted = isCompleted
    }
}
