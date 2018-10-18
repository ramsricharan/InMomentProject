//
//  ResultsPageViews.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/15/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation
import UIKit

class ResultsPageViews {
    
    let currentViewController : UIViewController
    
    init(viewController : UIViewController)
    {
        self.currentViewController = viewController
        arrangeViews()
    }
    
    //------------------------------------------------------------------------------
          ////////////////////// Getter Setter methods  //////////////////////
    //------------------------------------------------------------------------------

    public func setKeywordText(resultKeyword : String)
    {
        keywordResultLabel.text = resultKeyword
    }
    
    public func setDefinitionText(resultDefinition : String)
    {
        definitionResultLabel.text = resultDefinition
    }
    
    public func setNewSearchButtonHandler(action : Selector)
    {
        newSearchButton.addTarget(currentViewController, action: action, for: .touchUpInside)
    }
    
    

    
    
    
    //------------------------------------------------------------------------------
            ////////////////////// UI Components  //////////////////////
    //------------------------------------------------------------------------------
    
    // Base ScrollView
    private let baseScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Base StackView
    private let baseStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    
    // Title Label
    private let TitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Definition Found!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.myGreen
        return label
    }()
    
     //Keyword Title Label
    private let keywordTitleLabel : UILabel = {
        let label = UILabel()
        label.makeTitleLabel(title: "Keyword")
        return label
    }()
    
    // Keyword Results label
    private var keywordResultLabel : UILabel = {
        let label = UILabel()
        label.makeResultLabel()
        return label
    }()
    

    // Definition Title label
    private let definitionTitleLabel : UILabel = {
        let label = UILabel()
        label.makeTitleLabel(title: "Definition")
        return label
    }()
    
    // Definition Result label
    private var definitionResultLabel : UILabel = {
        let label = UILabel()
        label.makeResultLabel()
        return label
    }()

    
    // Back Button
    private var newSearchButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New Search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.backgroundColor = UIColor.myGreen
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    //------------------------------------------------------------------------------
            ////////////////////// Helper methods  //////////////////////
    //------------------------------------------------------------------------------
    
    // Arrange all the UI Components into the rootView
    private func arrangeViews()
    {
        let rootView : UIView = currentViewController.view
        rootView.backgroundColor = UIColor.myBackgroundColor
        
        // Add Scroll View to the rootView
        rootView.addSubview(baseScrollView)
        baseScrollView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 8).isActive = true
        baseScrollView.heightAnchor.constraint(equalTo: rootView.heightAnchor, constant: -72).isActive = true
        baseScrollView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: -8).isActive = true
        baseScrollView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
        
        // Add stackView to the rootView
        baseScrollView.addSubview(baseStackView)
        baseStackView.topAnchor.constraint(equalTo: baseScrollView.topAnchor, constant: 16).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: baseScrollView.bottomAnchor, constant: -8).isActive = true
        baseStackView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor, constant: -8).isActive = true

        
        // Add Title label View
        baseStackView.addArrangedSubview(TitleLabel)
        TitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Add the keyword labels
        let keywordLabelsContainer = makeContainerForLabels(titleLabel: keywordTitleLabel, resultLabel: keywordResultLabel)
        baseStackView.addArrangedSubview(keywordLabelsContainer)
        
        // Add the definition labels
        let definitionLabelsContainer = makeContainerForLabels(titleLabel: definitionTitleLabel, resultLabel: definitionResultLabel)
        baseStackView.addArrangedSubview(definitionLabelsContainer)
        
        // Add the button
        rootView.addSubview(newSearchButton)
        newSearchButton.topAnchor.constraint(equalTo: baseScrollView.bottomAnchor, constant: 8).isActive = true
        newSearchButton.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -16).isActive = true
        newSearchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newSearchButton.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.7).isActive = true
        newSearchButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
    }
    
    
    
    // Helper method to create a container view for title and result label sets
    private func makeContainerForLabels(titleLabel : UILabel, resultLabel : UILabel) -> UIView
    {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the title label
        baseView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 0.3, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor).isActive = true
        
        // Add the result label
        baseView.addSubview(resultLabel)
        resultLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        resultLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5).isActive = true
        resultLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 0.7, constant: -5).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: baseView.rightAnchor).isActive = true
        
        return baseView
    }
}





//------------------------------------------------------------------------------
  ////////////////////// Extensions for creating Labels  //////////////////////
//------------------------------------------------------------------------------
extension UILabel
{
    func makeTitleLabel(title : String)
    {
        let label = self
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = UIColor.myGreen
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func makeResultLabel()
    {
        let label = self
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
}


