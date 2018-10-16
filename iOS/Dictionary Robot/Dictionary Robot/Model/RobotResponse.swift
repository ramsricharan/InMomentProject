//
//  RobotResponse.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/13/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation

//------------------------------------------------------------------------------
////////////////// Model to decode and store JSON Response  ////////////////////
//------------------------------------------------------------------------------

struct RobotResponse : Decodable {
    var status : String
    var currentTerm : String
    var currentTermDefinition : String
    var hasNextPage : Bool
    var hasPreviousPage : Bool
    var hasNextTerm : Bool
    var hasPreviousTerm : Bool
    
    init(status : String, currentTerm : String, currentTermDefinition : String, hasNextPage : Bool,
         hasPreviousPage : Bool, hasNextTerm : Bool, hasPreviousTerm : Bool)
    {
        self.status = status
        self.currentTerm = currentTerm
        self.currentTermDefinition = currentTermDefinition
        self.hasNextPage = hasNextPage
        self.hasPreviousPage = hasPreviousPage
        self.hasNextTerm = hasNextTerm
        self.hasPreviousTerm = hasPreviousTerm
    }
}
