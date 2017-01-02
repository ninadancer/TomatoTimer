//
//  SettingsViewController.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 24/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var settingsView: SettingsView {
        return view as! SettingsView
    }

    
    var workTimes = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    var breakTimes = [1, 2, 5, 10]
    
    var currentWorkDurationInMinutes = UserDefaults.standard.integer(forKey: TimerType.Work.rawValue) / 60
    var currentBreakDurationInMinutes = UserDefaults.standard.integer(forKey: TimerType.Break.rawValue) / 60
    
    override func loadView() {
        view = SettingsView(frame: .zero)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsView.pickerView.dataSource = self
        settingsView.pickerView.delegate = self
        
        let workGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveMarker(sender:)))
        settingsView.workInputHostView.addGestureRecognizer(workGestureRecognizer)
        
        let breakGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveMarker(sender:)))
        settingsView.breakInputHostView.addGestureRecognizer(breakGestureRecognizer)
        
        title = "Settings"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let views = ["topLayoutGuide": topLayoutGuide, "workInputHostView": settingsView.workInputHostView] as [String: Any]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-10-[workInputHostView]", options: [], metrics: nil, views: views))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSettings))
        navigationItem.rightBarButtonItem = doneButton
        
        settingsView.setWorkDurationString(string: "\(currentWorkDurationInMinutes) min")
        settingsView.setBreakDurationString(string: "\(currentBreakDurationInMinutes) min")
        
        var row = 0
        for (index, minutes) in workTimes.enumerated() {
            if minutes == currentWorkDurationInMinutes {
                row = index
                break
            }
        }
        
        settingsView.pickerView.selectRow(row, inComponent: 0, animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        settingsView.moveMarkerToView(view: settingsView.workInputHostView)
        
    }
    
    func dismissSettings() {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch settingsView.selectedTimerType {
        case .Work:
            return workTimes.count
        default:
            return breakTimes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var minutes = 0
        switch settingsView.selectedTimerType {
        case .Work:
            minutes = workTimes[row]
        default:
            minutes = breakTimes[row]
        }
        
        let attributedTitle = NSAttributedString(string: "\(minutes) min", attributes: [NSForegroundColorAttributeName: UIColor.yellow])
        return attributedTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var minutes = 0
        switch settingsView.selectedTimerType {
        case .Work:
            minutes = workTimes[row]
            currentWorkDurationInMinutes = minutes
        default:
            minutes = breakTimes[row]
            currentBreakDurationInMinutes = minutes
        }
        
        
        let timerType = settingsView.setDurationString(string: "\(minutes) min")
        let seconds = minutes * 60 + 1
        UserDefaults.standard.set(seconds, forKey: timerType.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func moveMarker(sender: UITapGestureRecognizer) {
        settingsView.moveMarkerToView(view: sender.view!)
        settingsView.pickerView.reloadAllComponents()
        
        var times: [Int]
        var currentDuration: Int
        switch settingsView.selectedTimerType {
        case .Work:
            times = workTimes
            currentDuration = currentWorkDurationInMinutes
        default:
            times = breakTimes
            currentDuration = currentBreakDurationInMinutes
        }
        
        var row = 0
        for (index, minutes) in times.enumerated() {
            if minutes == currentDuration {
                row = index
                break
            }
        }
        
        settingsView.pickerView.selectRow(row, inComponent: 0, animated: false)
        
    }
}
