//
//  CustomLabel.swift
//  Machine Learning Camera
//
//  Created by Atacan on 12.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        path.fill()
    }
}
