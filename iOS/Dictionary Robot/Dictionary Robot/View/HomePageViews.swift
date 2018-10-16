//
//  HomePageViews.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation
import UIKit


class HomePageViews
{
    let currentViewController : UIViewController
    
    init(viewController : UIViewController)
    {
        self.currentViewController = viewController
        arrangeViews()
    }
    
    
    //------------------------------------------------------------------------------
            ////////////////////// Getter Setter methods  //////////////////////
    //------------------------------------------------------------------------------
    
    public func setKeyword(keyword : String)
    {
        keywordTextView.text = keyword
    }
    
    public func getKeyword() -> String
    {
        return keywordTextView.text ?? ""
    }
    
    
    public func onSearchClicked(action : Selector)
    {
        searchButton.addTarget(currentViewController, action: action, for: .touchUpInside)
    }
    
    
    
    
    
    
    
    
    //------------------------------------------------------------------------------
            ////////////////////// UI Components  //////////////////////
    //------------------------------------------------------------------------------
    
    // Base Container
    private var baseContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.myWhite
        return view
    }()
    
    // Title label
    private let appTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourceStrings.APP_TITLE
        label.textAlignment = .center
        label.textColor = UIColor.myGreen
        label.font = UIFont (name: "ArialRoundedMTBold", size: 32.0)
        return label
    }()
    
    // Keyword textView
    private var keywordTextView : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = ResourceStrings.TEXT_VIEW_PLACEHOLDER
        text.textAlignment = .center
        text.clearButtonMode = .always
        text.layer.cornerRadius = 20
        text.layer.masksToBounds = true
        text.backgroundColor = UIColor.init(white: 1, alpha: 0.9)
        return text
    }()
    
    
    // Search Button
    private var searchButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.backgroundColor = UIColor.myGreen
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        
        return button
    }()
    
    
    
    //------------------------------------------------------------------------------
            //////////////////////  Helper methods  //////////////////////
    //------------------------------------------------------------------------------
    
    // Arrange all the UI Components into the rootView
    private func arrangeViews()
    {
        let rootView : UIView = currentViewController.view
        
        // Set background color of view
        rootView.backgroundColor = UIColor.myBackgroundColor
        
        // Add Base Container
        rootView.addSubview(baseContainerView)
        baseContainerView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
        baseContainerView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor).isActive = true
        baseContainerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.9).isActive = true
        baseContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Add TextField at center
        baseContainerView.addSubview(keywordTextView)
        keywordTextView.centerXAnchor.constraint(equalTo: baseContainerView.centerXAnchor).isActive = true
        keywordTextView.centerYAnchor.constraint(equalTo: baseContainerView.centerYAnchor).isActive = true
        keywordTextView.widthAnchor.constraint(equalTo: baseContainerView.widthAnchor, multiplier: 0.8).isActive = true
        keywordTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Add button to the button base
        baseContainerView.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: baseContainerView.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.widthAnchor.constraint(equalTo: baseContainerView.widthAnchor, multiplier: 0.6).isActive = true
        searchButton.topAnchor.constraint(equalTo: keywordTextView.bottomAnchor, constant: 10).isActive = true

        // Add title on top of the Text Field
        baseContainerView.addSubview(appTitleLabel)
        appTitleLabel.centerXAnchor.constraint(equalTo: baseContainerView.centerXAnchor).isActive = true
        appTitleLabel.widthAnchor.constraint(equalTo: baseContainerView.widthAnchor).isActive = true
        appTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        appTitleLabel.bottomAnchor.constraint(equalTo: keywordTextView.topAnchor, constant: -24).isActive = true
    }
        

}
