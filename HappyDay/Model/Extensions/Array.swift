//
//  ExtensionArray.swift
//  HappyDay
//
//  Created by Артем on 28/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import Foundation

extension Array {
    mutating func delete(element: String) {
        self = self.filter() { $0 as! String != element }
    }
}


