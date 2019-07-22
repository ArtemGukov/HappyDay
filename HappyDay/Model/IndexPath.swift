//
//  IndexPath.swift
//  HappyDay
//
//  Created by Артем on 19/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension IndexPath {
    var prevRow: IndexPath {
        let row = self.row - 1
        let section = self.section
        
        return IndexPath(row: row, section: section)
    }
}
