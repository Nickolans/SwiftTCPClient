//
//  Error.swift
//  
//
//  Created by Nickolans Griffith on 1/30/23.
//

import Foundation

public struct Error {
    public private(set) var description: String
    
    init(_ description: String) {
        self.description = description
    }
}
