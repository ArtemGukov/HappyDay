//
//  Extension Date.swift
//  HappyDay
//
//  Created by Артем on 28/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
