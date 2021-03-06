//
//  TimerStyleKit2.swift
//  TomatoTimer
//
//  Created by 蓉蓉 邓 on 25/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit

class TimerStyleKit2: NSObject {
    
    // Cache
    
    fileprivate struct Cache {
        static var backgroundColor: UIColor = UIColor(red: 0.141, green: 0.149, blue: 0.204, alpha: 1.000)
        static var timerColor: UIColor = UIColor(red: 0.378, green: 0.670, blue: 0.961, alpha: 1.000)
        static var imageOfSettings: UIImage?
        static var settingsTargets: [AnyObject]?
        static var imageOfInfo: UIImage?
        static var infoTargets: [AnyObject]?
    }
    
    // Colors
    
    open class var backgroundColor: UIColor { return Cache.backgroundColor }
    open class var timerColor: UIColor { return Cache.timerColor }
    
    // Drawing Methods
    
    open class func drawTimerAppIcon(_ durationInSeconds: CGFloat, maxValue: CGFloat, diameter: CGFloat, dashGap: CGFloat) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = TimerStyleKit2.timerColor
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 4
        
        // Variable Declarations
        let endAngle: CGFloat = 90 - durationInSeconds * 360 / maxValue
        let minutes: CGFloat = floor(maxValue / 60.0)
        let dashLength: CGFloat = diameter * CGFloat(M_PI) / minutes - dashGap
        
        // TimerRing Drawing
        let timerRingRect = CGRect(x: 62, y: 62, width: diameter, height: diameter)
        let timerRingPath = UIBezierPath()
        timerRingPath.addArc(withCenter: CGPoint(x: timerRingRect.midX, y: timerRingRect.midY), radius: timerRingRect.width / 2, startAngle: -90 * CGFloat(M_PI)/180, endAngle: -endAngle * CGFloat(M_PI)/180, clockwise: true)
        
        //        context!.saveGState()
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        TimerStyleKit2.timerColor.setStroke()
        timerRingPath.lineWidth = 4
        context?.saveGState()
        context?.setLineDash(phase: 0, lengths: [dashLength, dashGap])
        timerRingPath.stroke()
        context?.restoreGState()
        context?.restoreGState()
    }
    
    open class func drawFiveMin(_ durationInSeconds: CGFloat, maxValue: CGFloat, diameter: CGFloat, dashGap: CGFloat) {
        // Variable Declarations
        let endAngle: CGFloat = 90 - durationInSeconds * 360 / maxValue
        let minutes: CGFloat = floor(maxValue / 60.0)
        let dashLength: CGFloat = diameter * CGFloat(M_PI) / minutes - dashGap
        
        // TimerRing Drawing
        let timerRingRect = CGRect(x: 6, y: 6, width: diameter, height: diameter)
        let timerRingPath = UIBezierPath()
        timerRingPath.addArc(withCenter: CGPoint(x: timerRingRect.midX, y: timerRingRect.midY), radius: timerRingRect.width / 2, startAngle: -90 * CGFloat(M_PI)/180, endAngle: -endAngle * CGFloat(M_PI)/180, clockwise: true)
        
        TimerStyleKit2.timerColor.setStroke()
        timerRingPath.lineWidth = 6
        timerRingPath.stroke()
    }
    
    open class func drawSettings() {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group 2
        //// Group 3
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 36.47, y: 18.63))
        bezierPath.addLine(to: CGPoint(x: 36.15, y: 17.53))
        bezierPath.addCurve(to: CGPoint(x: 33.49, y: 15.42), controlPoint1: CGPoint(x: 35.84, y: 16.32), controlPoint2: CGPoint(x: 34.74, y: 15.42))
        bezierPath.addCurve(to: CGPoint(x: 32.76, y: 15.53), controlPoint1: CGPoint(x: 33.23, y: 15.42), controlPoint2: CGPoint(x: 33.02, y: 15.47))
        bezierPath.addLine(to: CGPoint(x: 31.35, y: 15.89))
        
        bezierPath.addCurve(to: CGPoint(x: 30.04, y: 14.21), controlPoint1: CGPoint(x: 30.98, y: 15.26), controlPoint2: CGPoint(x: 30.56, y: 14.74))
        bezierPath.addLine(to: CGPoint(x: 30.62, y: 13.21))
        
        bezierPath.addCurve(to: CGPoint(x: 30.88, y: 11.05), controlPoint1: CGPoint(x: 30.98, y: 12.58), controlPoint2: CGPoint(x: 31.09, y: 11.79))
        bezierPath.addCurve(to: CGPoint(x: 29.57, y: 9.32), controlPoint1: CGPoint(x: 30.67, y: 10.32), controlPoint2: CGPoint(x: 30.25, y: 9.74))
        bezierPath.addLine(to: CGPoint(x: 28.58, y: 8.74))
        
        bezierPath.addCurve(to: CGPoint(x: 27.17, y: 8.37), controlPoint1: CGPoint(x: 28.16, y: 8.47), controlPoint2: CGPoint(x: 27.69, y: 8.37))
        bezierPath.addCurve(to: CGPoint(x: 24.77, y: 9.79), controlPoint1: CGPoint(x: 26.18, y: 8.37), controlPoint2: CGPoint(x: 25.24, y: 8.89))
        bezierPath.addLine(to: CGPoint(x: 24.19, y: 10.79))
        
        bezierPath.addCurve(to: CGPoint(x: 22.1, y: 10.53), controlPoint1: CGPoint(x: 23.51, y: 10.63), controlPoint2: CGPoint(x: 22.78, y: 10.53))
        bezierPath.addLine(to: CGPoint(x: 21.79, y: 9.11))
        
        bezierPath.addCurve(to: CGPoint(x: 19.12, y: 7), controlPoint1: CGPoint(x: 21.47, y: 7.89), controlPoint2: CGPoint(x: 20.38, y: 7))
        bezierPath.addCurve(to: CGPoint(x: 18.39, y: 7.11), controlPoint1: CGPoint(x: 18.86, y: 7), controlPoint2: CGPoint(x: 18.65, y: 7.05))
        bezierPath.addLine(to: CGPoint(x: 17.29, y: 7.42))
        
        bezierPath.addCurve(to: CGPoint(x: 15.62, y: 8.74), controlPoint1: CGPoint(x: 16.56, y: 7.63), controlPoint2: CGPoint(x: 15.99, y: 8.11))
        bezierPath.addCurve(to: CGPoint(x: 15.36, y: 10.89), controlPoint1: CGPoint(x: 15.26, y: 9.37), controlPoint2: CGPoint(x: 15.15, y: 10.16))
        bezierPath.addLine(to: CGPoint(x: 15.73, y: 12.37))
        
        bezierPath.addCurve(to: CGPoint(x: 14.16, y: 13.63), controlPoint1: CGPoint(x: 15.15, y: 12.74), controlPoint2: CGPoint(x: 14.63, y: 13.16))
        bezierPath.addLine(to: CGPoint(x: 13.22, y: 13.11))
        
        bezierPath.addCurve(to: CGPoint(x: 11.81, y: 12.74), controlPoint1: CGPoint(x: 12.8, y: 12.84), controlPoint2: CGPoint(x: 12.33, y: 12.74))
        bezierPath.addCurve(to: CGPoint(x: 9.41, y: 14.16), controlPoint1: CGPoint(x: 10.82, y: 12.74), controlPoint2: CGPoint(x: 9.88, y: 13.26))
        bezierPath.addLine(to: CGPoint(x: 8.83, y: 15.16))
        
        bezierPath.addCurve(to: CGPoint(x: 8.52, y: 17.16), controlPoint1: CGPoint(x: 8.41, y: 15.68), controlPoint2: CGPoint(x: 8.36, y: 16.47))
        bezierPath.addCurve(to: CGPoint(x: 9.82, y: 18.89), controlPoint1: CGPoint(x: 8.73, y: 17.89), controlPoint2: CGPoint(x: 9.14, y: 18.47))
        bezierPath.addLine(to: CGPoint(x: 10.76, y: 19.47))
        
        bezierPath.addCurve(to: CGPoint(x: 10.5, y: 21.53), controlPoint1: CGPoint(x: 10.61, y: 20.16), controlPoint2: CGPoint(x: 10.5, y: 20.84))
        bezierPath.addLine(to: CGPoint(x: 9.04, y: 21.89))
        
        bezierPath.addCurve(to: CGPoint(x: 7.37, y: 23.21), controlPoint1: CGPoint(x: 8.31, y: 22.11), controlPoint2: CGPoint(x: 7.73, y: 22.58))
        bezierPath.addCurve(to: CGPoint(x: 7.11, y: 25.37), controlPoint1: CGPoint(x: 7, y: 23.84), controlPoint2: CGPoint(x: 6.9, y: 24.63))
        bezierPath.addLine(to: CGPoint(x: 7.32, y: 26.47))
        
        bezierPath.addCurve(to: CGPoint(x: 9.98, y: 28.58), controlPoint1: CGPoint(x: 7.63, y: 27.68), controlPoint2: CGPoint(x: 8.73, y: 28.58))
        bezierPath.addCurve(to: CGPoint(x: 10.71, y: 28.47), controlPoint1: CGPoint(x: 10.24, y: 28.58), controlPoint2: CGPoint(x: 10.45, y: 28.53))
        bezierPath.addLine(to: CGPoint(x: 12.23, y: 28.05))
        
        bezierPath.addCurve(to: CGPoint(x: 13.48, y: 29.68), controlPoint1: CGPoint(x: 12.59, y: 28.63), controlPoint2: CGPoint(x: 13.01, y: 29.16))
        bezierPath.addLine(to: CGPoint(x: 12.96, y: 30.63))
        
        bezierPath.addCurve(to: CGPoint(x: 12.7, y: 32.79), controlPoint1: CGPoint(x: 12.59, y: 31.26), controlPoint2: CGPoint(x: 12.49, y: 32.05))
        bezierPath.addCurve(to: CGPoint(x: 14, y: 34.53), controlPoint1: CGPoint(x: 12.91, y: 33.53), controlPoint2: CGPoint(x: 13.32, y: 34.11))
        bezierPath.addLine(to: CGPoint(x: 15, y: 35.11))
        
        bezierPath.addCurve(to: CGPoint(x: 16.41, y: 35.47), controlPoint1: CGPoint(x: 15.41, y: 35.37), controlPoint2: CGPoint(x: 15.88, y: 35.47))
        bezierPath.addCurve(to: CGPoint(x: 18.81, y: 34.05), controlPoint1: CGPoint(x: 17.4, y: 35.47), controlPoint2: CGPoint(x: 18.34, y: 34.95))
        bezierPath.addLine(to: CGPoint(x: 19.33, y: 33.11))
        
        bezierPath.addCurve(to: CGPoint(x: 21.32, y: 33.37), controlPoint1: CGPoint(x: 20.01, y: 33.26), controlPoint2: CGPoint(x: 20.64, y: 33.37))
        bezierPath.addLine(to: CGPoint(x: 21.74, y: 34.89))
        
        bezierPath.addCurve(to: CGPoint(x: 24.4, y: 37), controlPoint1: CGPoint(x: 22.05, y: 36.11), controlPoint2: CGPoint(x: 23.15, y: 37))
        bezierPath.addCurve(to: CGPoint(x: 25.13, y: 36.89), controlPoint1: CGPoint(x: 24.66, y: 37), controlPoint2: CGPoint(x: 24.87, y: 36.95))
        bezierPath.addLine(to: CGPoint(x: 26.23, y: 36.58))
        
        bezierPath.addCurve(to: CGPoint(x: 28.21, y: 33.11), controlPoint1: CGPoint(x: 27.69, y: 36.16), controlPoint2: CGPoint(x: 28.58, y: 34.63))
        bezierPath.addLine(to: CGPoint(x: 27.8, y: 31.58))
        
        bezierPath.addCurve(to: CGPoint(x: 29.42, y: 30.32), controlPoint1: CGPoint(x: 28.37, y: 31.21), controlPoint2: CGPoint(x: 28.89, y: 30.79))
        bezierPath.addLine(to: CGPoint(x: 30.36, y: 30.89))
        
        bezierPath.addCurve(to: CGPoint(x: 31.77, y: 31.26), controlPoint1: CGPoint(x: 30.77, y: 31.16), controlPoint2: CGPoint(x: 31.24, y: 31.26))
        bezierPath.addCurve(to: CGPoint(x: 34.17, y: 29.84), controlPoint1: CGPoint(x: 32.76, y: 31.26), controlPoint2: CGPoint(x: 33.7, y: 30.74))
        bezierPath.addLine(to: CGPoint(x: 34.74, y: 28.84))
        
        bezierPath.addCurve(to: CGPoint(x: 35.01, y: 26.68), controlPoint1: CGPoint(x: 35.11, y: 28.21), controlPoint2: CGPoint(x: 35.21, y: 27.42))
        bezierPath.addCurve(to: CGPoint(x: 33.7, y: 24.95), controlPoint1: CGPoint(x: 34.8, y: 25.95), controlPoint2: CGPoint(x: 34.38, y: 25.37))
        bezierPath.addLine(to: CGPoint(x: 32.76, y: 24.42))
        
        bezierPath.addCurve(to: CGPoint(x: 33.02, y: 22.42), controlPoint1: CGPoint(x: 32.92, y: 23.74), controlPoint2: CGPoint(x: 33.02, y: 23.11))
        bezierPath.addLine(to: CGPoint(x: 34.48, y: 22.05))
        
        bezierPath.addCurve(to: CGPoint(x: 36.15, y: 20.74), controlPoint1: CGPoint(x: 35.21, y: 21.84), controlPoint2: CGPoint(x: 35.79, y: 21.37))
        bezierPath.addCurve(to: CGPoint(x: 36.47, y: 18.63), controlPoint1: CGPoint(x: 36.52, y: 20.11), controlPoint2: CGPoint(x: 36.63, y: 19.37))
        bezierPath.close()
        
        bezierPath.move(to: CGPoint(x: 35.27, y: 20.26))
        
        bezierPath.addCurve(to: CGPoint(x: 34.22, y: 21.11), controlPoint1: CGPoint(x: 35.06, y: 20.68), controlPoint2: CGPoint(x: 34.64, y: 20.95))
        bezierPath.addLine(to: CGPoint(x: 32.03, y: 21.68))
        bezierPath.addLine(to: CGPoint(x: 32.03, y: 22.11))
        bezierPath.addCurve(to: CGPoint(x: 31.66, y: 24.63), controlPoint1: CGPoint(x: 32.03, y: 22.95), controlPoint2: CGPoint(x: 31.92, y: 23.79))
        bezierPath.addLine(to: CGPoint(x: 31.56, y: 25))
        bezierPath.addLine(to: CGPoint(x: 33.18, y: 25.95))
        bezierPath.addCurve(to: CGPoint(x: 34.01, y: 27), controlPoint1: CGPoint(x: 33.59, y: 26.16), controlPoint2: CGPoint(x: 33.86, y: 26.58))
        bezierPath.addCurve(to: CGPoint(x: 33.86, y: 28.32), controlPoint1: CGPoint(x: 34.12, y: 27.47), controlPoint2: CGPoint(x: 34.07, y: 27.95))
        bezierPath.addLine(to: CGPoint(x: 33.28, y: 29.32))
        bezierPath.addCurve(to: CGPoint(x: 31.77, y: 30.21), controlPoint1: CGPoint(x: 32.97, y: 29.84), controlPoint2: CGPoint(x: 32.39, y: 30.21))
        bezierPath.addCurve(to: CGPoint(x: 30.88, y: 29.95), controlPoint1: CGPoint(x: 31.45, y: 30.21), controlPoint2: CGPoint(x: 31.14, y: 30.11))
        bezierPath.addLine(to: CGPoint(x: 29.26, y: 29))
        bezierPath.addLine(to: CGPoint(x: 29, y: 29.26))
        bezierPath.addCurve(to: CGPoint(x: 26.96, y: 30.84), controlPoint1: CGPoint(x: 28.37, y: 29.89), controlPoint2: CGPoint(x: 27.69, y: 30.42))
        bezierPath.addLine(to: CGPoint(x: 26.59, y: 31.05))
        bezierPath.addLine(to: CGPoint(x: 27.22, y: 33.37))
        bezierPath.addCurve(to: CGPoint(x: 25.97, y: 35.53), controlPoint1: CGPoint(x: 27.48, y: 34.32), controlPoint2: CGPoint(x: 26.91, y: 35.26))
        bezierPath.addLine(to: CGPoint(x: 24.87, y: 35.84))
        bezierPath.addCurve(to: CGPoint(x: 24.4, y: 35.95), controlPoint1: CGPoint(x: 24.71, y: 35.95), controlPoint2: CGPoint(x: 24.56, y: 35.95))
        bezierPath.addCurve(to: CGPoint(x: 22.73, y: 34.63), controlPoint1: CGPoint(x: 23.62, y: 35.95), controlPoint2: CGPoint(x: 22.94, y: 35.42))
        bezierPath.addLine(to: CGPoint(x: 22.1, y: 32.32))
        bezierPath.addLine(to: CGPoint(x: 21.68, y: 32.32))
        bezierPath.addCurve(to: CGPoint(x: 19.18, y: 31.95), controlPoint1: CGPoint(x: 20.85, y: 32.32), controlPoint2: CGPoint(x: 20.01, y: 32.21))
        bezierPath.addLine(to: CGPoint(x: 18.81, y: 31.84))
        bezierPath.addLine(to: CGPoint(x: 17.87, y: 33.47))
        bezierPath.addCurve(to: CGPoint(x: 16.35, y: 34.37), controlPoint1: CGPoint(x: 17.56, y: 34), controlPoint2: CGPoint(x: 16.98, y: 34.37))
        bezierPath.addCurve(to: CGPoint(x: 15.47, y: 34.16), controlPoint1: CGPoint(x: 16.04, y: 34.37), controlPoint2: CGPoint(x: 15.73, y: 34.26))
        bezierPath.addLine(to: CGPoint(x: 14.47, y: 33.58))
        bezierPath.addCurve(to: CGPoint(x: 13.64, y: 32.53), controlPoint1: CGPoint(x: 14.06, y: 33.32), controlPoint2: CGPoint(x: 13.79, y: 32.95))
        bezierPath.addCurve(to: CGPoint(x: 13.79, y: 31.21), controlPoint1: CGPoint(x: 13.53, y: 32.05), controlPoint2: CGPoint(x: 13.58, y: 31.58))
        bezierPath.addLine(to: CGPoint(x: 14.73, y: 29.58))
        bezierPath.addLine(to: CGPoint(x: 14.47, y: 29.32))
        bezierPath.addCurve(to: CGPoint(x: 12.91, y: 27.26), controlPoint1: CGPoint(x: 13.85, y: 28.68), controlPoint2: CGPoint(x: 13.32, y: 28))
        bezierPath.addLine(to: CGPoint(x: 12.7, y: 26.89))
        bezierPath.addLine(to: CGPoint(x: 10.4, y: 27.53))
        bezierPath.addCurve(to: CGPoint(x: 10.03, y: 27.53), controlPoint1: CGPoint(x: 10.35, y: 27.53), controlPoint2: CGPoint(x: 10.19, y: 27.53))
        bezierPath.addCurve(to: CGPoint(x: 8.36, y: 26.21), controlPoint1: CGPoint(x: 9.25, y: 27.53), controlPoint2: CGPoint(x: 8.57, y: 27))
        bezierPath.addLine(to: CGPoint(x: 8.05, y: 25.11))
        bezierPath.addCurve(to: CGPoint(x: 8.2, y: 23.79), controlPoint1: CGPoint(x: 7.94, y: 24.63), controlPoint2: CGPoint(x: 7.99, y: 24.16))
        bezierPath.addCurve(to: CGPoint(x: 9.25, y: 22.95), controlPoint1: CGPoint(x: 8.41, y: 23.37), controlPoint2: CGPoint(x: 8.83, y: 23.11))
        bezierPath.addLine(to: CGPoint(x: 11.5, y: 22.32))
        bezierPath.addLine(to: CGPoint(x: 11.5, y: 21.89))
        bezierPath.addCurve(to: CGPoint(x: 11.81, y: 19.32), controlPoint1: CGPoint(x: 11.5, y: 21.05), controlPoint2: CGPoint(x: 11.6, y: 20.16))
        bezierPath.addLine(to: CGPoint(x: 11.91, y: 18.95))
        bezierPath.addLine(to: CGPoint(x: 10.29, y: 18))
        bezierPath.addCurve(to: CGPoint(x: 9.46, y: 16.95), controlPoint1: CGPoint(x: 9.88, y: 17.74), controlPoint2: CGPoint(x: 9.61, y: 17.37))
        bezierPath.addCurve(to: CGPoint(x: 9.61, y: 15.63), controlPoint1: CGPoint(x: 9.35, y: 16.47), controlPoint2: CGPoint(x: 9.41, y: 16))
        bezierPath.addLine(to: CGPoint(x: 10.19, y: 14.63))
        bezierPath.addCurve(to: CGPoint(x: 11.7, y: 13.74), controlPoint1: CGPoint(x: 10.5, y: 14.11), controlPoint2: CGPoint(x: 11.08, y: 13.74))
        bezierPath.addCurve(to: CGPoint(x: 12.59, y: 14), controlPoint1: CGPoint(x: 12.02, y: 13.74), controlPoint2: CGPoint(x: 12.33, y: 13.84))
        bezierPath.addLine(to: CGPoint(x: 14.26, y: 14.89))
        bezierPath.addLine(to: CGPoint(x: 14.53, y: 14.63))
        bezierPath.addCurve(to: CGPoint(x: 16.51, y: 13.05), controlPoint1: CGPoint(x: 15.15, y: 14), controlPoint2: CGPoint(x: 15.83, y: 13.47))
        bezierPath.addLine(to: CGPoint(x: 16.88, y: 12.79))
        bezierPath.addLine(to: CGPoint(x: 16.3, y: 10.58))
        bezierPath.addCurve(to: CGPoint(x: 16.46, y: 9.26), controlPoint1: CGPoint(x: 16.2, y: 10.11), controlPoint2: CGPoint(x: 16.25, y: 9.63))
        bezierPath.addCurve(to: CGPoint(x: 17.5, y: 8.42), controlPoint1: CGPoint(x: 16.67, y: 8.84), controlPoint2: CGPoint(x: 17.09, y: 8.58))
        bezierPath.addLine(to: CGPoint(x: 18.6, y: 8.11))
        bezierPath.addCurve(to: CGPoint(x: 20.74, y: 9.37), controlPoint1: CGPoint(x: 19.54, y: 7.84), controlPoint2: CGPoint(x: 20.48, y: 8.42))
        bezierPath.addLine(to: CGPoint(x: 21.21, y: 11.16))
        bezierPath.addLine(to: CGPoint(x: 21.37, y: 11.53))
        bezierPath.addLine(to: CGPoint(x: 21.79, y: 11.53))
        bezierPath.addCurve(to: CGPoint(x: 24.4, y: 11.89), controlPoint1: CGPoint(x: 22.68, y: 11.53), controlPoint2: CGPoint(x: 23.51, y: 11.63))
        bezierPath.addLine(to: CGPoint(x: 24.77, y: 12))
        bezierPath.addLine(to: CGPoint(x: 25.71, y: 10.32))
        bezierPath.addCurve(to: CGPoint(x: 27.22, y: 9.42), controlPoint1: CGPoint(x: 26.02, y: 9.79), controlPoint2: CGPoint(x: 26.59, y: 9.42))
        bezierPath.addCurve(to: CGPoint(x: 28.11, y: 9.68), controlPoint1: CGPoint(x: 27.53, y: 9.42), controlPoint2: CGPoint(x: 27.85, y: 9.53))
        bezierPath.addLine(to: CGPoint(x: 29.1, y: 10.26))
        bezierPath.addCurve(to: CGPoint(x: 29.94, y: 11.32), controlPoint1: CGPoint(x: 29.52, y: 10.47), controlPoint2: CGPoint(x: 29.78, y: 10.89))
        bezierPath.addCurve(to: CGPoint(x: 29.78, y: 12.63), controlPoint1: CGPoint(x: 30.04, y: 11.79), controlPoint2: CGPoint(x: 29.99, y: 12.26))
        bezierPath.addLine(to: CGPoint(x: 28.79, y: 14.37))
        bezierPath.addLine(to: CGPoint(x: 29.05, y: 14.63))
        bezierPath.addCurve(to: CGPoint(x: 30.67, y: 16.79), controlPoint1: CGPoint(x: 29.68, y: 15.26), controlPoint2: CGPoint(x: 30.2, y: 16))
        bezierPath.addLine(to: CGPoint(x: 30.88, y: 17.16))
        bezierPath.addLine(to: CGPoint(x: 33.02, y: 16.58))
        bezierPath.addCurve(to: CGPoint(x: 35.16, y: 17.84), controlPoint1: CGPoint(x: 33.96, y: 16.32), controlPoint2: CGPoint(x: 34.9, y: 16.89))
        bezierPath.addLine(to: CGPoint(x: 35.48, y: 18.95))
        bezierPath.addCurve(to: CGPoint(x: 35.27, y: 20.26), controlPoint1: CGPoint(x: 35.58, y: 19.37), controlPoint2: CGPoint(x: 35.53, y: 19.84))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 21.74, y: 15.89))
        bezierPath.addCurve(to: CGPoint(x: 15.73, y: 22), controlPoint1: CGPoint(x: 18.44, y: 15.89), controlPoint2: CGPoint(x: 15.73, y: 18.63))
        bezierPath.addCurve(to: CGPoint(x: 21.74, y: 28.11), controlPoint1: CGPoint(x: 15.73, y: 25.37), controlPoint2: CGPoint(x: 18.44, y: 28.11))
        bezierPath.addCurve(to: CGPoint(x: 27.74, y: 22), controlPoint1: CGPoint(x: 25.03, y: 28.11), controlPoint2: CGPoint(x: 27.74, y: 25.37))
        bezierPath.addCurve(to: CGPoint(x: 21.74, y: 15.89), controlPoint1: CGPoint(x: 27.74, y: 18.63), controlPoint2: CGPoint(x: 25.08, y: 15.89))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 21.74, y: 27.05))
        bezierPath.addCurve(to: CGPoint(x: 16.77, y: 22), controlPoint1: CGPoint(x: 18.97, y: 27.05), controlPoint2: CGPoint(x: 16.77, y: 24.79))
        bezierPath.addCurve(to: CGPoint(x: 21.74, y: 16.95), controlPoint1: CGPoint(x: 16.77, y: 19.21), controlPoint2: CGPoint(x: 19.02, y: 16.95))
        bezierPath.addCurve(to: CGPoint(x: 26.7, y: 22), controlPoint1: CGPoint(x: 24.45, y: 16.95), controlPoint2: CGPoint(x: 26.7, y: 19.21))
        bezierPath.addCurve(to: CGPoint(x: 21.74, y: 27.05), controlPoint1: CGPoint(x: 26.7, y: 24.79), controlPoint2: CGPoint(x: 24.5, y: 27.05))
        bezierPath.close()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()
    }
    
    open class func drawInfo() {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group 2
        //// Group 3
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 22, y: 7))
        bezierPath.addCurve(to: CGPoint(x: 7, y: 22), controlPoint1: CGPoint(x: 13.75, y: 7), controlPoint2: CGPoint(x: 7, y: 13.75))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 37), controlPoint1: CGPoint(x: 7, y: 30.25), controlPoint2: CGPoint(x: 13.75, y: 37))
        bezierPath.addCurve(to: CGPoint(x: 37, y: 22), controlPoint1: CGPoint(x: 30.25, y: 37), controlPoint2: CGPoint(x: 37, y: 30.25))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 7), controlPoint1: CGPoint(x: 37, y: 13.75), controlPoint2: CGPoint(x: 30.25, y: 7))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 22, y: 35.85))
        bezierPath.addCurve(to: CGPoint(x: 8.15, y: 22), controlPoint1: CGPoint(x: 14.38, y: 35.85), controlPoint2: CGPoint(x: 8.15, y: 29.62))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 8.15), controlPoint1: CGPoint(x: 8.15, y: 14.38), controlPoint2: CGPoint(x: 14.38, y: 8.15))
        bezierPath.addCurve(to: CGPoint(x: 35.85, y: 22), controlPoint1: CGPoint(x: 29.62, y: 8.15), controlPoint2: CGPoint(x: 35.85, y: 14.38))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 35.85), controlPoint1: CGPoint(x: 35.85, y: 29.62), controlPoint2: CGPoint(x: 29.62, y: 35.85))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 22, y: 12.77))
        bezierPath.addCurve(to: CGPoint(x: 20.62, y: 14.15), controlPoint1: CGPoint(x: 21.25, y: 12.77), controlPoint2: CGPoint(x: 20.62, y: 13.4))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 15.54), controlPoint1: CGPoint(x: 20.62, y: 14.9), controlPoint2: CGPoint(x: 21.25, y: 15.54))
        bezierPath.addCurve(to: CGPoint(x: 23.38, y: 14.15), controlPoint1: CGPoint(x: 22.75, y: 15.54), controlPoint2: CGPoint(x: 23.38, y: 14.9))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 12.77), controlPoint1: CGPoint(x: 23.38, y: 13.35), controlPoint2: CGPoint(x: 22.81, y: 12.77))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 22, y: 19.12))
        bezierPath.addCurve(to: CGPoint(x: 21.42, y: 19.69), controlPoint1: CGPoint(x: 21.65, y: 19.12), controlPoint2: CGPoint(x: 21.42, y: 19.35))
        bezierPath.addLine(to: CGPoint(x: 21.42, y: 30.65))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 31.23), controlPoint1: CGPoint(x: 21.42, y: 31), controlPoint2: CGPoint(x: 21.65, y: 31.23))
        bezierPath.addCurve(to: CGPoint(x: 22.58, y: 30.65), controlPoint1: CGPoint(x: 22.35, y: 31.23), controlPoint2: CGPoint(x: 22.58, y: 31))
        bezierPath.addLine(to: CGPoint(x: 22.58, y: 19.69))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 19.12), controlPoint1: CGPoint(x: 22.58, y: 19.4), controlPoint2: CGPoint(x: 22.35, y: 19.12))
        bezierPath.close()
        bezierPath.miterLimit = 4
        
        fillColor.setFill()
        bezierPath.fill()
    }
    
    //// Generated Images
    
    public class var imageOfSetting: UIImage {
        if Cache.imageOfSettings != nil {
            return Cache.imageOfSettings!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 44, height: 44), false, 0)
        TimerStyleKit2.drawSettings()
        
        Cache.imageOfSettings = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
        UIGraphicsEndImageContext()
        
        return Cache.imageOfSettings!
    }
    
    public class var imageOfInfo: UIImage {
        if Cache.imageOfInfo != nil {
            return Cache.imageOfInfo!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 44, height: 44), false, 0)
        TimerStyleKit2.drawInfo()
        
        Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
        
        UIGraphicsEndImageContext()
        return Cache.imageOfInfo!
    }
    
    //// Customization Infrastructure
    
    @IBOutlet var settingsTargets: [AnyObject]! {
        get { return Cache.settingsTargets }
        set {
            Cache.settingsTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(image: TimerStyleKit2.imageOfSetting)
            }
        }
    }
    
    @IBOutlet var infoTargets: [AnyObject]! {
        get { return Cache.infoTargets }
        set {
            Cache.infoTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(image: TimerStyleKit2.imageOfInfo)
            }
        }
    }
    
}

@objc protocol StyleKitSettableImage {
    func setImage(image: UIImage!)
}

@objc protocol StyleKitSettableSelectedImage {
    func setSelectedImage(image: UIImage!)
}

