//
//  RangeSliderThumbLayer.swift
//  Pokedex_ios
//
//  Created by user on 19/7/22.
//

import UIKit

class RangeSliderThumbLayer: CALayer {
    var highlighted = false
    weak var rangeSlider: RangeSlider?

    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 5.0, dy: 5.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)

            // Fill - with a subtle shadow
            let shadowColor = slider.trackHighlightTintColor
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor?.cgColor)
            ctx.setFillColor(slider.thumbTintColor.cgColor)

            ctx.addPath(thumbPath.cgPath)
            ctx.addPath(UIBezierPath(roundedRect: bounds.insetBy(dx: 2.0, dy: 10.0), cornerRadius: 50).cgPath)
            ctx.fillPath()

            // Outline
            ctx.setStrokeColor(shadowColor!.cgColor)
            ctx.setLineWidth(3) // Thumb stroke width
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()

            // Add a shadow when highlighted
            /*if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }*/
        }
    }
}
