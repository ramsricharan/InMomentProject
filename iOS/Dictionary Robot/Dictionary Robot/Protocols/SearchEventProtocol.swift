//
//  SearchResponseProtocol.swift
//  Dictionary Robot
//
//  Created by Ram Sri Charan on 10/14/18.
//  Copyright © 2018 Ram Sri Charan. All rights reserved.
//

import Foundation

protocol searchEventProtocol {
    func searchCompleteWithResults(results : SearchResults)
    func networkErrorOccurred()
    func searchCancelled()
}
