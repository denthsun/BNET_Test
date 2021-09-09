//
//  GradientButton.swift
//  MVVM_Films2020
//
//  Created by Denis Velikanov on 02.03.2021.
//

import UIKit
import Foundation

class GradientButton: UIButton {
    
    let gradient = CAGradientLayer()
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)
        gradient.frame = bounds
        gradient.colors = colors
        layer.addSublayer(gradient)
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
