//
//  Color_Extensions.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    static let myWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
    static let myBackgroundColor = UIColor(red: 26/255, green: 40/255, blue: 53/255, alpha: 1.0)
    static let myGreen = UIColor(red: 99/255, green: 194/255, blue: 45/255, alpha: 1.0)
    static let customRed = UIColor(red: 219/255, green: 69/255, blue: 0/255, alpha: 1.0)
}





extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}


