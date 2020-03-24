//
//  plusButton.swift
//  mvcSample
//
//  Created by Julia Debecka on 22/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

final class PlusButton: UIButton {
    private var roundedRecLayer: CAShapeLayer?
    
    private func layoutRoundShape(){
        let shapeLayer = CAShapeLayer()

        let path = UIBezierPath(ovalIn: self.bounds).cgPath
        shapeLayer.path = path
        shapeLayer.fillColor = UIColor.systemBlue.cgColor
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    private func shadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layoutRoundShape()
        shadow()
    }
}
