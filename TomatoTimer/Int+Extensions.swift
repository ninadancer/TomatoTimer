//
//  Int+Extensions.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 23/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import Foundation

extension Int {
    func format(_ f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
