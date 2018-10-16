//
//  ResultsVC.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/15/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    public var keyword : String = ""
    public var definition : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resultPageViews : ResultsPageViews = ResultsPageViews(viewController: self)
        
        // Set button click handler
        resultPageViews.setNewSearchButtonHandler(action: #selector(onNewSearchClicked))
        
        // Set the result into the labels
        resultPageViews.setKeywordText(resultKeyword: keyword)
        resultPageViews.setDefinitionText(resultDefinition: definition)
    }
    
    // To make the status Bar light color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @objc private func onNewSearchClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }
    

}
