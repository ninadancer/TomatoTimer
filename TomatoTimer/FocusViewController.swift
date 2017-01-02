//
//  FocusViewController.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 23/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import AudioToolbox
import WatchConnectivity
import UserNotifications

final class FocusViewController: UIViewController {
    
    fileprivate var focusView: FocusView! { return self.view as! FocusView }
    fileprivate var timer: Timer?
    fileprivate var endDate: Date?
    fileprivate var localNotification: UNNotificationRequest?
    fileprivate var currentType = TimerType.Idle
    fileprivate var totalMinutes = 0
    
    var session: WCSession?

    //MARK: - view cycle
    override func loadView() {
        view = FocusView(frame: .zero)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        focusView.workButton.addTarget(self, action: #selector(startWork(sender:)), for: .touchUpInside)
        focusView.breakButton.addTarget(self, action: #selector(startBreak(sender:)), for: .touchUpInside)
        focusView.procrastinateButton.addTarget(self, action: #selector(startProcrastination(sender:)), for: .touchUpInside)
        focusView.settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        focusView.aboutButton.addTarget(self, action: #selector(showAbout), for: .touchUpInside)

    }
    
    override func viewDidLayoutSubviews() {
        let minSizeDimension = min(view.frame.size.width, view.frame.size.height)
        focusView.timerView.timeLabel.font = focusView.timerView.timeLabel.font.withSize((minSizeDimension - 2 * focusView.sidePadding) * 0.9 / 3.0 - 10.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if timer == nil {
            focusView.setDuration(duration: 0, maxValue: 1)
        }
        
        let duration = UserDefaults.standard.integer(forKey: TimerType.Work.rawValue)
        print("duration: \(duration)")
    }

   //MARK: - button actions
    func startWork(sender: UIButton?) {
        print("startWork")
        guard currentType != .Work else {
            showAlert()
            return
        }
        startTimerWithType(timerType: .Work)
    }
    
    func startBreak(sender: UIButton?) {
        print("startBreak")
        guard currentType != .Break else {
            showAlert()
            return
        }
        startTimerWithType(timerType: .Break)
    }
    
    func startProcrastination(sender: UIButton?) {
        print("startProcrastination")
        guard currentType != .Procrastination else {
            showAlert()
            return
        }
        startTimerWithType(timerType: .Procrastination)
    }
    
    func showSettings() {
        present(DHNavigationController(rootViewController: SettingsViewController()), animated: true, completion: nil)
        
    }
    
    func showAbout() {
        present(DHNavigationController(rootViewController: AboutViewController()), animated: true, completion: nil)
    }
    
    func setUIModeForTimerType(timerType: TimerType) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            switch timerType {
            case .Work:
                self.set(button: self.focusView.workButton, enabled: true)
                self.set(button: self.focusView.breakButton, enabled: false)
                self.set(button: self.focusView.procrastinateButton, enabled: false)
            case .Break:
                self.set(button: self.focusView.workButton, enabled: false)
                self.set(button: self.focusView.breakButton, enabled: true)
                self.set(button: self.focusView.procrastinateButton, enabled: false)
            case .Procrastination:
                self.set(button: self.focusView.workButton, enabled: false)
                self.set(button: self.focusView.breakButton, enabled: false)
                self.set(button: self.focusView.procrastinateButton, enabled: true)
            default:
                self.set(button: self.focusView.workButton, enabled: true)
                self.set(button: self.focusView.breakButton, enabled: true)
                self.set(button: self.focusView.procrastinateButton, enabled: true)
            }
            }, completion: nil)
    }
    
    
    func set(button: UIButton, enabled: Bool) {
        if enabled {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.3
        }
    }
    
}

// MARK: - timer methods
extension FocusViewController {
    
    func startTimerWithType(timerType: TimerType) {
       focusView.setDuration(duration: 0, maxValue: 1)
        var typeName: String
        switch timerType {
        case .Work:
            typeName = "Work"
            currentType = .Work
        case .Break:
            typeName = "Break"
            currentType = .Break
        case .Procrastination:
            typeName = "Procrastination"
            currentType = .Procrastination
        default:
            typeName = "None"
            currentType = .Idle
            resetTimer()
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            return
        }
        
        setUIModeForTimerType(timerType: currentType)
        
        let seconds = UserDefaults.standard.integer(forKey: timerType.rawValue)
        endDate = Date(timeIntervalSinceNow: Double(seconds))
        
        let endTimeStamp = floor(endDate!.timeIntervalSince1970)
        
        if let sharedDefaults = UserDefaults(suiteName: "group.ninababy") {
            sharedDefaults.set(endTimeStamp, forKey: "date")
            sharedDefaults.set(seconds, forKey: "maxValue")
            sharedDefaults.synchronize()
        }
        
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            do {
                try session.updateApplicationContext(["date": endTimeStamp, "maxValue": seconds])
            } catch {
                print("Error!")
            }
            session.transferCurrentComplicationUserInfo(["date": endTimeStamp,"maxValue": seconds])
        }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimeLabel(sender:)), userInfo: ["timerType" : seconds], repeats: true)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.body = "Time for " + typeName + " is up!"
        content.sound = UNNotificationSound.default()
        content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
        content.categoryIdentifier = "com.elonchan.localNotification"
        
        let timeInteval = TimeInterval(seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInteval, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
    
    func updateTimeLabel(sender: Timer) {
        var totalNumberOfSeconds: CGFloat
        if let type = (sender.userInfo as! NSDictionary!)["timerType"] as? Int {
            totalNumberOfSeconds = CGFloat(type)
        } else {
            assert(false, "This should not happen")
            totalNumberOfSeconds = -1.0
        }
        
        let timeInterval = CGFloat(endDate!.timeIntervalSinceNow)
        if timeInterval < 0 {
            resetTimer()
            if timeInterval > -1 {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
            focusView.setDuration(duration: 0, maxValue: 1)
            return
        }
        
        focusView.setDuration(duration: timeInterval, maxValue: totalNumberOfSeconds)
    }
    
    fileprivate func resetTimer() {
        timer?.invalidate()
        timer = nil
        currentType = .Idle
        setUIModeForTimerType(timerType: .Idle)
        
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            do {
                try session.updateApplicationContext(["date": -1.0, "maxValue": -1.0])
            } catch {
                print("ErEr!")
            }
            session.transferCurrentComplicationUserInfo(["date": -1.0, "maxValue": -1.0])
        }
        
        if let sharedDefaults = UserDefaults(suiteName: "group.ninababy") {
            sharedDefaults.removeObject(forKey: "date")
            sharedDefaults.synchronize()
        }
    }
}

// MARK: - alert
extension FocusViewController {
    func showAlert() {
        var alertMessage = NSLocalizedString("Do you want to stop this ", comment: "first part of alert message")
        switch currentType {
        case .Work:
            alertMessage += NSLocalizedString("work timer?", comment: "second part of alert message")
        case .Break:
            alertMessage += NSLocalizedString("break timer?", comment: "second part of alert message")
        case .Procrastination:
            alertMessage += NSLocalizedString("procrastination", comment: "second part of alert message")
        default:
            break
        }
        
        let alertController = UIAlertController(title: "Stop?", message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("\(action)")
        }
        alertController.addAction(cancelAction)
        
        let stopAction = UIAlertAction(title: "Stop", style: .default) { (action) in
            print("\(action)")
            self.startTimerWithType(timerType: .Idle)
        }
        
        alertController.addAction(stopAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}

