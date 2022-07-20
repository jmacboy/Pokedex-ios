//
//  RangeSlider.swift
//  Pokedex_ios
//
//  Created by user on 19/7/22.
//

import Foundation
import UIKit
import QuartzCore

class RangeSlider: UIControl {

    var minimumValue = ConstantVariables.rangeValuesLowerUpper[0]
    var maximumValue = ConstantVariables.rangeValuesLowerUpper[1]
    var lowerValue = ConstantVariables.rangeValuesLowerUpper[0]
    var upperValue = ConstantVariables.rangeValuesLowerUpper[1]

    let trackLayer = RangeSliderTrackLayer() // = CALayer() defined in RangeSliderTrackLayer.swift
    let lowerThumbLayer = RangeSliderThumbLayer() // CALayer()
    let upperThumbLayer = RangeSliderThumbLayer() // CALayer()
    let lowerThumbLabel = UILabel()
    let upperThumbLabel = UILabel()
    var previousLocation = CGPoint()

    var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightTintColor = UIColor(named: "apply-button")
    var thumbTintColor = UIColor.white

    var curvaceousness = CGFloat(1.0)

    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }

    func resetValues() {
        upperValue = maximumValue
        lowerValue = minimumValue
        updateLayerFrames()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)

        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateLayerFrames() {
        // Tracker layer WIDTH
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 2.35)
        trackLayer.setNeedsDisplay()

        // LowerThumbCenter Set
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))

        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
                                   width: thumbWidth, height: thumbWidth )
        lowerThumbLabel.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
                                          width: thumbWidth * 2, height: thumbWidth + 80 )
        lowerThumbLabel.text = "\(Int(lowerValue))"
        self.addSubview(lowerThumbLabel)
        lowerThumbLayer.setNeedsDisplay()

        // UpperThumbCenter Set
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                   width: thumbWidth, height: thumbWidth)
        upperThumbLabel.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                          width: thumbWidth * 2, height: thumbWidth + 80 )
        upperThumbLabel.text = "\(Int(upperValue))"
        self.addSubview(upperThumbLabel)
        upperThumbLayer.setNeedsDisplay()
    }

    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }

    override var frame: CGRect {
        didSet {
          updateLayerFrames()
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)

        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }

        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }

    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previousLocation = location

        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }

        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        updateLayerFrames()

        CATransaction.commit()

        sendActions(for: .valueChanged)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
}
