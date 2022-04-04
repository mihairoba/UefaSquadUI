//
//  RoundedCornersImageView.swift
//  UefaSquadUI
//
//  Created by Mihai Roba on 03.04.2022.
//

import UIKit
import QuartzCore

@IBDesignable class RoundedCornersImageView: UIImageView {
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var showShadow: Bool = false {
        didSet {
            if showShadow == true {
                if shadowLayer == nil {
                    shadowLayer = CAShapeLayer()
                    
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
                    shadowLayer.fillColor = UIColor.white.cgColor
                    
                    shadowLayer.shadowColor = UIColor.black.cgColor
                    shadowLayer.shadowPath = shadowLayer.path
                    shadowLayer.shadowOffset = CGSize(width: 0.0, height: 10.0)
                    shadowLayer.shadowOpacity = 0.6
                    shadowLayer.shadowRadius = 5
                    
                    layer.insertSublayer(shadowLayer, at: 0)
                }
            }
        }
    }
    
    @IBInspectable var boderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = boderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
