//
//  RobotSearch.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation


class RobotSearch
{
    
    private var isFrontSearch : Bool!
    private var task : URLSessionDataTask!
    private var delegate : searchEventProtocol?
    
    
    
    public init(delegate : searchEventProtocol)
    {
        self.delegate = delegate
    }
    
    // Use this method to stop the ongoing search
    public func cancelSearch()
    {
        task.cancel()
    }
    
    // Use this method to start the search
    public func searchForTerm(keyword : String)
    {
        // Check the best side to start search
        isFrontSearch = Utilities.isFrontSearch(keyword: keyword)
        
        print("Started searching for the word : \(keyword) & isFrontSearch: \(String(describing: isFrontSearch))")
        
        
        // Call appropriate API
        let urlString : String = isFrontSearch ? ResourceStrings.JUMP_TO_FIRST_PAGE_URL : ResourceStrings.JUMP_TO_LAST_PAGE_URL
        let request = Utilities.makePostRequestFor(URL_String: urlString)
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if (error != nil)
            {
                // Search failed
                self.errorOccurred(Error: error! as NSError)
            }
            else
            {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let statusCode : Int = httpResponse.statusCode
                
                if(statusCode == 200)
                {
                    print("Jumped to First/last page")
                    
                    // Jump to first or last term based on search direction
                    if (self.isFrontSearch)
                    {
                        self.jumpToLastTermAndSearch(keyword: keyword)
                    }
                    else
                    {
                        self.jumpToFirstTermAndSearch(keyword: keyword)
                    }
                }
                else
                {
                    // Search failed due to network error
                    self.errorOccurred(Error: error! as NSError)
                }
            }

        })
            
        task.resume()
    }
    
    
    
    
    // Go to first term of the current page and search
    private func jumpToFirstTermAndSearch(keyword : String)
    {
        print("Inside jumpToFirstTermAndSearch()")
        
        let request = Utilities.makePostRequestFor(URL_String: ResourceStrings.JUMP_TO_FIRST_TERM_URL)
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if (error != nil)
            {
                // Search failed
                self.errorOccurred(Error: error! as NSError)
            }
        
            else
            {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let statusCode : Int = httpResponse.statusCode
                
                if(error == nil && statusCode == 200)
                {
                    guard let data = data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(RobotResponse.self, from: data)
                        let currentTerm = jsonData.currentTerm
                        
                        if(currentTerm == keyword)
                        {
                            print("Found the word")
                            self.searchCompleted(word: jsonData.currentTerm, definition: jsonData.currentTermDefinition)
                        }
                            
                        else if(currentTerm < keyword)
                        {
                            // Required term is present on this page
                            print("Required word is in current page after the word: \(currentTerm)")
                            self.checkCurrentPageForTerm(keyword: keyword)
                        }
                        else
                        {
                            // Go to previous page and repeat search
                            if(jsonData.hasPreviousPage)
                            {
                                self.moveToPage(keyword: keyword)
                            }
                            else
                            {
                                // Out of pages
                                print(ResourceStrings.LOG_OUT_OF_PAGES)
                                self.searchCompleted()
                            }
                        }
                    }
                    catch let err {
                        print("Error occured while Parsing the JSON response \n error: \(err)")
                    }
                }
                else
                {
                    // Search failed due to network error
                    self.errorOccurred(Error: error! as NSError)
                }
            }
        })
        task.resume()
    }
    
    
    // Go to last term of the page and search
    private func jumpToLastTermAndSearch(keyword : String)
    {
        print("Inside jumpToLastTermAndSearch()")
        
        let request = Utilities.makePostRequestFor(URL_String: ResourceStrings.JUMP_TO_LAST_TERM_URL)
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if (error != nil)
            {
                // Search failed
                self.errorOccurred(Error: error! as NSError)
            }
            else
            {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let statusCode : Int = httpResponse.statusCode
                
                if(error == nil && statusCode == 200)
                {
                    guard let data = data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(RobotResponse.self, from: data)
                        let currentTerm = jsonData.currentTerm
                        
                        if(currentTerm == keyword)
                        {
                            print("Found the word")
                            self.searchCompleted(word: jsonData.currentTerm, definition: jsonData.currentTermDefinition)
                        }
                            
                        else if(currentTerm > keyword)
                        {
                            // Required term is present on this page
                            print("Required word is in current page before the word : \(currentTerm)")
                            self.checkCurrentPageForTerm(keyword: keyword)
                        }
                        else
                        {
                            // Go to previous page and repeat search
                            if(jsonData.hasNextPage)
                            {
                                self.moveToPage(keyword: keyword)
                            }
                            else
                            {
                                // Out of pages
                                print(ResourceStrings.LOG_OUT_OF_PAGES)
                                self.searchCompleted()
                            }
                        }
                    }
                    catch let err {
                        print("Error occured while Parsing the JSON response \n error: \(err)")
                    }
                }
                else
                {
                    // Search failed due to network error
                    self.errorOccurred(Error: error! as NSError)
                }
            }
            
        })
        task.resume()
    }
    
    
    
    
    
    // Use this method to move to next or previous page based on search direction
    private func moveToPage(keyword : String)
    {
        print("Moving to the next/previous page")
        
        let urlString = isFrontSearch ? ResourceStrings.MOVE_TO_NEXT_PAGE_URL : ResourceStrings.MOVE_TO_PREVIOUS_PAGE_URL
        let request = Utilities.makePostRequestFor(URL_String: urlString)
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if (error != nil)
            {
                // Search failed
                self.errorOccurred(Error: error! as NSError)
            }
            else
            {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let statusCode : Int = httpResponse.statusCode
                
                if(error == nil && statusCode == 200)
                {
                    if(self.isFrontSearch)
                    {
                        self.jumpToLastTermAndSearch(keyword: keyword)
                    }
                    else
                    {
                        self.jumpToFirstTermAndSearch(keyword: keyword)
                    }
                }
                else
                {
                    // Search failed due to network error
                    self.errorOccurred(Error: error! as NSError)
                }
            }
        })
        task.resume()
    }
    
    
    
    
    
    // Search all the terms within the current page
    // This function calls itself recursively until it either finds the required word
    // or reaches the end/start of the page.
    private func checkCurrentPageForTerm(keyword : String)
    {
        let urlString = isFrontSearch ? ResourceStrings.MOVE_TO_PREVIOUS_TERM_URL : ResourceStrings.MOVE_TO_NEXT_TERM_URL
        let request = Utilities.makePostRequestFor(URL_String: urlString)
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if (error != nil)
            {
                // Search failed
                self.errorOccurred(Error: error! as NSError)
            }
            else
            {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let statusCode : Int = httpResponse.statusCode
                
                if(error == nil && statusCode == 200)
                {
                    guard let data = data else { return }
                    do
                    {
                        let jsonData = try JSONDecoder().decode(RobotResponse.self, from: data)
                        print("Dealing with the current word: \(jsonData.currentTerm)")
                        
                        if(keyword == jsonData.currentTerm)
                        {
                            // Found the required word
                            self.searchCompleted(word: jsonData.currentTerm, definition: jsonData.currentTermDefinition)
                        }
                        else
                        {
                            if(self.isFrontSearch && jsonData.hasPreviousTerm)
                            {
                                // Go to previous term if there is any
                                self.checkCurrentPageForTerm(keyword: keyword)
                            }
                            else if( !self.isFrontSearch && jsonData.hasNextTerm)
                            {
                                // Go to next term if there is any
                                self.checkCurrentPageForTerm(keyword: keyword)
                            }
                            else
                            {
                                // Out of words on the page.
                                print("Word not found")
                                self.searchCompleted()
                            }
                        } 
                    }
                    catch let err {
                        print("Error occured while Parsing the JSON response \n error: \(err)")
                    }
                }
                else
                {
                    // Search failed due to network error
                    self.errorOccurred(Error: error! as NSError)
                }
            }
        })
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    // Use this method overload when search is completed successfully & keyword is found
    private func searchCompleted(word : String, definition : String)
    {
        print(ResourceStrings.LOG_SUCCESS_WITH_RESULTS)
        print("The definition for \(word) >--is--> \(definition)")
        let results = SearchResults(Keyword: word, Definition: definition, IsFetched: true)
        DispatchQueue.main.async {
            self.delegate?.searchCompleteWithResults(results: results)
        }
    }
    
    // Use this method overload when search is completed successfully but no results are obtained
    private func searchCompleted()
    {
        print(ResourceStrings.LOG_SUCCESS_WITH_NO_RESULTS)
        let results = SearchResults(Keyword: "", Definition: "", IsFetched: false)
        DispatchQueue.main.async {
            self.delegate?.searchCompleteWithResults(results: results)
        }
    }
    
    
    private func errorOccurred(Error : NSError)
    {
        if(Error.code == NSURLErrorCancelled)
        {
            // Cancelled by the user
            print(ResourceStrings.LOG_USER_CANCEL_SEARCH)
            DispatchQueue.main.async {
                self.delegate?.searchCancelled()
            }
        }
        else
        {
            // Network error
            print(ResourceStrings.LOG_NETWORK_ERROR)
            DispatchQueue.main.async {
                self.delegate?.networkErrorOccurred()
            }
        }
    }
    
}
