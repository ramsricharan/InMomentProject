//
//  Utilities.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation
import UIKit

class Utilities
{
    private init() {}
    
    
    public static func isFrontSearch(keyword : String) -> Bool
    {
        return keyword.lowercased() <= "m";
    }
    
    
    public static func stringContainsNumber(keyword : String) -> Bool
    {
        let numberRange = keyword.rangeOfCharacter(from: .decimalDigits)
        return numberRange != nil
    }
    
    
    public static func stringContainsSpecialCharacters(keyword : String) -> Bool
    {
        let characterset = CharacterSet(charactersIn: "!@#$%&*()_+=|<>?{}[]~")
        return keyword.rangeOfCharacter(from: characterset) != nil
    }
    
    
    // Make a Http post request for the given API endpoint
    public static func makePostRequestFor(URL_String : String) -> URLRequest
    {
        let url : URL = URL(string: URL_String)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(ResourceStrings.API_HEADER_VALUE, forHTTPHeaderField: ResourceStrings.API_HEADER_KEY)
        return request
    }
    
    
    public static func getTimeElapsedString(startTime : Date) -> String
    {
        let elapsed = (startTime.timeIntervalSinceNow) * -1
        return "Time taken for search = \(elapsed) seconds"
    }
    


    
    
}
