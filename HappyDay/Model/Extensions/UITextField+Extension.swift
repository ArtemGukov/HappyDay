//
//  UITextField+Extension.swift
//  HappyDay
//
//  Created by Артем on 31/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension UITextField {
    var isEmpty: Bool {
        return text?.isEmpty ?? true
    }
}
