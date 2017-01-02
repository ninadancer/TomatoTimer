//
//  TodayViewController.swift
//  TheWidget
//
//  Created by 蓉蓉 邓 on 24/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var endDate: Date?
    var timer: Timer?
    var maxValue: Int?
    
    var timerView: TimerView2!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerView = TimerView2(frame: .zero)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerView)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openApp), for: .touchUpInside)
        view.addSubview(button)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(timerView.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(timerView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[timer]-10@999-|", options: [], metrics: nil, views: ["timer": timerView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|[button]|", options: [], metrics: nil, views: ["button": button])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[button]-0@999-|", options: [], metrics: nil, views: ["button": button])
        
        NSLayoutConstraint.activate(constraints)
        
        timerView.timeLabel.font = timerView.timeLabel.font.withSize(CGFloat(100.0*0.9/3.0-10.0))
    }
    
    func widgetMarginInsetsForProposedMarginInsets
        (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
        return UIEdgeInsets.zero
    }
    
    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        if let defaults = UserDefaults(suiteName: "group.ninababy") {
            let startDateAsTimeStamp = defaults.double(forKey: "date")
            print("startDate: \(startDateAsTimeStamp)")
            endDate = Date(timeIntervalSince1970: startDateAsTimeStamp)
            maxValue = defaults.integer(forKey: "maxValue")
        }
        
        timerView.durationInSeconds = 0.0
        timerView.maxValue = 1.0
        
        timer?.invalidate()
        if endDate != nil {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func updateLabel() {
        let durationInSeconds = endDate!.timeIntervalSinceNow
        if durationInSeconds > 0 {
            timerView.durationInSeconds = CGFloat(durationInSeconds)
            timerView.maxValue = CGFloat(maxValue!)
            //      timerView.setNeedsDisplay()
            timerView.updateTimer()
        } else {
            timer?.invalidate()
        }
    }
    
    func openApp() {
        let myAppUrl = URL(string: "fojusi://")!
        extensionContext?.open(myAppUrl, completionHandler: { (success) in
            if (!success) {
                print("let the user know it failed")
            }
        })
    }
}

extension Int {
    func format(_ f: String) -> String {
        //        return NSString(format: "%\(f)d", self) as String
        return String(format: "%\(f)d", self)
    }
}
