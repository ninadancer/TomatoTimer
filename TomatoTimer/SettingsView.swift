//
//  SettingsView.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 24/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import QuartzCore

final class SettingsView: UIView {

    private let markerView: UIView
    let workInputHostView: InputHostView
    let breakInputHostView: InputHostView
    private let workPeriodsLabel: UILabel
    private let workPeriodsStepper: UIStepper
    let pickerView: UIPickerView
    var selectedTimerType: TimerType
    
    override init(frame: CGRect) {
        
        markerView = {
            let view = UIView()
            view.layer.cornerRadius = 5
            return view
        }()
        
        let workPeriodsSettingsHostView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        workPeriodsLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        workPeriodsSettingsHostView.addSubview(workPeriodsLabel)
        
        workPeriodsStepper = {
            let stepper = UIStepper()
            stepper.translatesAutoresizingMaskIntoConstraints = false
            return stepper
        }()
        workPeriodsSettingsHostView.addSubview(workPeriodsStepper)
        
        workInputHostView = InputHostView(frame: .zero)
        workInputHostView.nameLabel.text = "Work duration"
        workInputHostView.tag = 0
        
        breakInputHostView = InputHostView(frame: .zero)
        breakInputHostView.nameLabel.text = "Break duration"
        breakInputHostView.tag = 1
        
        pickerView = {
            let pickerView = UIPickerView()
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            pickerView.showsSelectionIndicator = true
            return pickerView
        }()
        
        selectedTimerType = TimerType.Work
        
        super.init(frame: frame)
        
        backgroundColor = TimerStyleKit.backgroundColor
        markerView.backgroundColor = UIColor.yellow
        
        addSubview(markerView)
        addSubview(workInputHostView)
        addSubview(breakInputHostView)
        addSubview(pickerView)
        
        let metrics = ["hostHeight": 40, "hostViewGap": 10]
        let views = ["markerView": markerView, "workHostView": workInputHostView, "breakHostView": breakInputHostView, "picker": pickerView]
        var constraints = [NSLayoutConstraint]()
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-5-[workHostView]-5-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[workHostView(hostHeight,breakHostView)]-hostViewGap-[breakHostView]", options: [.alignAllLeft, .alignAllRight], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|[picker]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[breakHostView][picker]", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDurationString(string: String) -> TimerType {
        var timerType = TimerType.Idle
        if workInputHostView.frame.contains(markerView.center) {
            setWorkDurationString(string: string)
            timerType = TimerType.Work
        } else {
            setBreakDurationString(string: string)
            timerType = TimerType.Break
        }
        return timerType
    }
    
    func setWorkDurationString(string: String) {
        workInputHostView.durationLabel.text = string
    }
    
    func setBreakDurationString(string: String) {
        breakInputHostView.durationLabel.text = string
    }
    
    func moveMarkerToView(view: UIView) {
        if workInputHostView.frame.contains(view.center) {
            selectedTimerType = .Work
        } else {
            selectedTimerType = .Break
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5.0, options: [], animations: {
            self.markerView.frame = view.frame.insetBy(dx: -3, dy: -3)
            }, completion: nil)
    }
    
    
    final class InputHostView: UIView {
        let nameLabel: UILabel
        let durationLabel: UILabel
        
        override init(frame: CGRect) {
            let makeLabel = {() -> UILabel in
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = TimerStyleKit.timerColor
                label.text = "-"
                return label
                
            }
            
            nameLabel = makeLabel()
            durationLabel = makeLabel()
            
            super.init(frame: frame)
            
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = TimerStyleKit.backgroundColor
            layer.cornerRadius = 5
            
            addSubview(nameLabel)
            addSubview(durationLabel)
            
            let views = ["nameLabel": nameLabel, "durationLabel": durationLabel]
            var constraints = [NSLayoutConstraint]()
            
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[nameLabel]-(>=10)-[durationLabel]-|", options: .alignAllLastBaseline, metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nameLabel(durationLabel)]-|", options: .alignAllLastBaseline, metrics: nil, views: views)
            
            NSLayoutConstraint.activate(constraints)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
