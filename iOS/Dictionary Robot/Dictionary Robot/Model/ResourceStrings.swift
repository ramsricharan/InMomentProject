//
//  ResourceStrings.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/13/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation


class ResourceStrings  {
    
    // View Objects Strings
    public static let APP_TITLE = "Dictionary Robot"
    public static let TEXT_VIEW_PLACEHOLDER = "Enter your keyword"
    
    
    
    // LOG Messages
    public static let TAG : String = "My Log Message"
    public static let LOG_NETWORK_ERROR : String = "Network error occurred. Unable to fetch the results"
    public static let LOG_USER_CANCEL_SEARCH : String = "Search stopped - User cancelled the search"
    public static let LOG_SUCCESS_WITH_RESULTS : String = "Search Completed Successfully - Found the definition for the given word"
    public static let LOG_SUCCESS_WITH_NO_RESULTS : String = "Search Completed Successfully - But no such word is found in the dictionary"
    public static let LOG_OUT_OF_PAGES : String = "No more pages left to search for the given word"
    
    
    // Toast Messages
    public static let SEARCH_CANCELLED : String = "Your ongoing search has been cancelled"
    
    // Progress Dialog
    public static let SEARCH_STARTED_TITLE : String = "Searching the dictionary"
    public static let WAIT_MESSAGE : String = "Please wait..."
    
    // Alert Titles
    public static let INPUT_ERROR_TITLE : String = "Input Error - Cannot search the word."
    public static let WORD_NOT_FOUND_TITLE : String = "Cannot find the word"
    public static let NETWORK_ERROR_TITLE : String = "Network Error Occurred"
    
    // Alert Messages
    public static let ALPHANUMERIC_MESSAGE : String = "The keyword you have entered contains numbers in it. Please correct the input and try again."
    public static let SPECIAL_CHAR_MESSAGE : String = "The keyword you have entered contains special characters in it. Please correct the input and try again."
    public static let WORD_NOT_FOUND_MESSAGE : String = "Unable to find the definition for the word you entered."
    public static let NETWORK_ERROR_MESSAGE : String = "Unable to fetch the definition for the term at this moment due network issues. Please try again later."
    
    
    // API Strings
    public static let BASE_URL: String = "https://oke5yaeave.execute-api.us-west-2.amazonaws.com/prod/"
    public static let API_HEADER_KEY : String = "x-api-key"
    public static let API_HEADER_VALUE : String = "dIRiOMwrJ57m6V6lOINoQ7cy0uR5TLho3ZYB9f0U"
    public static let JUMP_TO_FIRST_PAGE_URL: String = BASE_URL + "jump-to-first-page"
    public static let JUMP_TO_LAST_PAGE_URL : String = BASE_URL + "jump-to-last-page"
    public static let MOVE_TO_NEXT_PAGE_URL : String = BASE_URL + "move-to-next-page"
    public static let MOVE_TO_PREVIOUS_PAGE_URL : String = BASE_URL + "move-to-previous-page"
    
    public static let JUMP_TO_FIRST_TERM_URL : String = BASE_URL + "jump-to-first-term"
    public static let JUMP_TO_LAST_TERM_URL : String = BASE_URL + "jump-to-last-term"
    public static let MOVE_TO_NEXT_TERM_URL : String = BASE_URL + "move-to-next-term"
    public static let MOVE_TO_PREVIOUS_TERM_URL : String = BASE_URL + "move-to-previous-term"

}
