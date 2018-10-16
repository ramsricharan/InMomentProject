//
//  PopupDialogs.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    // Show alert dialog for the given title and message
    func showAlert(AlertTitle: String, Message : String)
    {
        let alert = UIAlertController(title: AlertTitle, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
    
    // Spinner View
    func displaySpinner(rootView : UIView, Message : String, action : Selector) -> UIView {
        let spinnerView = UIView.init(frame: rootView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        
        // Loading spinner
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        
        // Spinner message
        let label = UILabel.init()
        label.text = Message
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        // Spinner cancel button
        let cancelButton = UIButton.init()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        
        cancelButton.backgroundColor = UIColor.customRed
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.masksToBounds = true
        
        cancelButton.addTarget(self, action: action, for: .touchUpInside)
        
        
        
        // Stack View to hold them
        let stack = UIStackView.init(frame: CGRect(x : 0,y : 0,width : 100,height : 100))
        stack.axis = .vertical
        stack.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(stack)
            
            stack.addArrangedSubview(ai)
            ai.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
            
            stack.addArrangedSubview(label)
            label.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
            
//            stack.addArrangedSubview(cancelButton)
//            cancelButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true

            spinnerView.addSubview(cancelButton)
            cancelButton.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: spinnerView.bottomAnchor, constant: -16).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            cancelButton.widthAnchor.constraint(equalTo: spinnerView.widthAnchor, multiplier: 0.75).isActive = true
            
            rootView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    
    // To remove the current spinner view
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
