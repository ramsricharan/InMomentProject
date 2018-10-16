//
//  SearchResults.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/13/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation

//------------------------------------------------------------------------------
////////////////// Model to decode and store Search Results  //////////////////
//------------------------------------------------------------------------------

struct SearchResults
{
    private var keyword : String
    private var definition : String
    private var isFetched : Bool
    
    init(Keyword : String, Definition : String, IsFetched : Bool) {
        self.keyword = Keyword
        self.definition = Definition
        self.isFetched = IsFetched
    }
    
    func getKeyword() -> String
    {
        return self.keyword
    }
    
    func getDefinition() -> String {
        return self.definition
    }
    
    func getIsFetched() -> Bool {
        return isFetched
    }
    
    
}
