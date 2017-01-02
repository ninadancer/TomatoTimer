//
//  FocusView.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 23/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import QuartzCore

final class FocusView: UIView {

    let timerView: TimerView
    let workButton: UIButton
    let breakButton: UIButton
    let procrastinateButton: UIButton
    let settingsButton: UIButton
    let aboutButton: UIButton
    let sidePadding = CGFloat(10)
    
    override init(frame: CGRect) {
        timerView = TimerView(frame: CGRect.zero)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        let makeButton = { (title: String) -> UIButton in
            let button = UIButton(type: UIButtonType.system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 40
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.yellow.cgColor
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
            return button
        }
        
        settingsButton = {
            let button = UIButton(type: UIButtonType.system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(TimerStyleKit.imageOfSetting, for: .normal)
            button.accessibilityLabel = NSLocalizedString("Settings", comment: "")
            return button
        }()
        
        aboutButton = {
            let button = UIButton(type: UIButtonType.system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(TimerStyleKit.imageOfInfo, for: .normal)
            return button
        }()
        
        workButton = makeButton(NSLocalizedString("Work", comment: "Start working button title"))
        breakButton = makeButton(NSLocalizedString("Break", comment: "Start break button title"))
        
        procrastinateButton = makeButton(NSLocalizedString("Procrastinate", comment: "Start procrastination button title"))
        if let font = procrastinateButton.titleLabel?.font {
            procrastinateButton.titleLabel?.font = font.withSize(12)
        }
        
        super.init(frame: frame)
        
        backgroundColor = TimerStyleKit.backgroundColor
        tintColor = UIColor.yellow
        
        addSubview(timerView)
        addSubview(workButton)
        addSubview(breakButton)
        addSubview(procrastinateButton)
        addSubview(settingsButton)
        addSubview(aboutButton)
        
        let views: [String: Any] = ["aboutButton": aboutButton, "settingsButton": settingsButton, "timerView": timerView, "workButton": workButton, "breakButton": breakButton, "procrastinateButton": procrastinateButton]
        let metrics = ["workWidth": 80, "settingsWidth": 44, "sidePadding": sidePadding]
        
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-13-[aboutButton]-(>=10)-[settingsButton(settingsWidth)]-13-|", options: .alignAllCenterY, metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[settingsButton(settingsWidth)]", options: [], metrics: metrics, views: views)
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-(>=sidePadding)-[timerView]-(>=sidePadding)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-(==sidePadding@751)-[timerView]-(==sidePadding@751)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=sidePadding)-[timerView]-(>=sidePadding)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==sidePadding@750)-[timerView]-(==sidePadding@750)-|", options: [], metrics: metrics, views: views)
        constraints.append(timerView.widthAnchor.constraint(equalTo: timerView.heightAnchor))
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[timerView]-40-[procrastinateButton(workWidth,breakButton,workButton)]", options: .alignAllCenterX, metrics: metrics, views: views)
        
        constraints.append(timerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50))
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[breakButton]-10-[procrastinateButton]-10-[workButton(workWidth,breakButton,procrastinateButton)]", options: [], metrics: metrics, views: views)
        constraints.append(workButton.centerYAnchor.constraint(equalTo: procrastinateButton.centerYAnchor, constant: -20))
        constraints.append(breakButton.centerYAnchor.constraint(equalTo: workButton.centerYAnchor))
        constraints.append(procrastinateButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDuration(duration: CGFloat, maxValue: CGFloat) {
        timerView.durationInSeconds = duration
        timerView.maxValue = maxValue
        timerView.updateTimer()
    }
    

}
