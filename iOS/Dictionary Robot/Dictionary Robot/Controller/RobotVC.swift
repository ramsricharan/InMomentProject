//
//  ViewController.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/13/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import UIKit

class RobotVC : UIViewController, searchEventProtocol, UITextViewDelegate {

    private var homePageViews : HomePageViews!
    private var robotSearch : RobotSearch!
    private var startTime : Date!
    
    private var spinnerView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        homePageViews = HomePageViews(viewController : self)
        homePageViews?.onSearchClicked(action: #selector(onSearchButtonClicked))
                
        robotSearch = RobotSearch(delegate: self)
        
        // Hide keyboard when screen is tapped
        self.hideKeyboardWhenTappedAround()
        
    }

    // To make the status Bar light color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //------------------------------------------------------------------------------
            ////////////////////// Action Handlers //////////////////////
    //------------------------------------------------------------------------------

    @objc private func onSearchButtonClicked()
    {
        let searchKeyword = homePageViews?.getKeyword().trim() ?? ""

        if(!searchKeyword.isEmpty)
        {
            checkAndSearch(keyword: searchKeyword)
        }
    }

    
    @objc private func onCancelSearchClicked()
    {
        robotSearch.cancelSearch()
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        onSearchButtonClicked()
        return true
    }
    
    
    
    
    //------------------------------------------------------------------------------
            ////////////////////// Helper Methods  //////////////////////
    //------------------------------------------------------------------------------
    
    // Checks for user input errors and proceeds to fetch for word
    private func checkAndSearch(keyword : String)
    {
        // Check if the word is alphanumeric
        if(Utilities.stringContainsNumber(keyword: keyword))
        {
            print("The keyword contains digits in it")
            self.showAlert(AlertTitle: ResourceStrings.INPUT_ERROR_TITLE, Message: ResourceStrings.ALPHANUMERIC_MESSAGE)
        }
            
        // Check if the word has special characters
        else if(Utilities.stringContainsSpecialCharacters(keyword: keyword))
        {
            print("Cannot search - String has special characters")
            self.showAlert(AlertTitle: ResourceStrings.INPUT_ERROR_TITLE, Message: ResourceStrings.SPECIAL_CHAR_MESSAGE)
        }
            
        // Start searching for word is everything is fine
        else
        {
            print("Start searching")
        
            spinnerView = self.displaySpinner(rootView: view, Message: ResourceStrings.WAIT_MESSAGE, action: #selector(onCancelSearchClicked))
            startTime = Date()
            
            robotSearch.searchForTerm(keyword: keyword.uppercased())
        }
        
    }
    
    // Reset the views for next search
    private func resetSearch()
    {
        self.removeSpinner(spinner: spinnerView)
        homePageViews.setKeyword(keyword: "")
    }
    
    
    
    //------------------------------------------------------------------------------
    ////////////////////// Protocol method implementations  //////////////////////
    //------------------------------------------------------------------------------

    
    // Search completed successfully and received the results
    func searchCompleteWithResults(results: SearchResults)
    {
        print("Received resutls from the robot")
        resetSearch()
        
        if(results.getIsFetched())
        {
            // Got the definition for word
            print("Found the word")
            print(Utilities.getTimeElapsedString(startTime: startTime))
            
            // Launch the results Page
            let resultsPage = ResultsVC()
            resultsPage.keyword = results.getKeyword()
            resultsPage.definition = results.getDefinition()
            self.present(resultsPage, animated: true, completion: nil)
        }
        else
        {
            print("Unable to find your word")
            self.showAlert(AlertTitle: ResourceStrings.WORD_NOT_FOUND_TITLE, Message: ResourceStrings.WORD_NOT_FOUND_MESSAGE)
        }
    }
    
    
    // When network error occurred this method gets called
    func networkErrorOccurred() {
        print("Search finished - Network error occured")
        resetSearch()
        self.showAlert(AlertTitle: ResourceStrings.NETWORK_ERROR_TITLE, Message: ResourceStrings.NETWORK_ERROR_MESSAGE)
    }
    
    // When user clicks cancel button
    func searchCancelled() {
        resetSearch()
        print("User cancelled the search")
    }

}

