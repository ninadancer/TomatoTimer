//
//  AboutViewController.swift
//  Tomato
//
//  Created by 蓉蓉 邓 on 23/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import SafariServices

final class AboutViewController: UIViewController {

    private var aboutView: AboutView {
        return view as! AboutView
    }
    
    override func loadView() {
        let contentView = AboutView(frame: .zero)
        title = "About"
        contentView.twitterButton.addTarget(self, action: #selector(openTwitter), for: .touchUpInside)
        contentView.githubButton.addTarget(self, action: #selector(openGithub), for: .touchUpInside)
        contentView.rateButton.addTarget(self, action: #selector(openRating), for: .touchUpInside)
        
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aboutView.stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissAbout))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func dismissAbout() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - Button actions
extension AboutViewController {
    func openTwitter() {
        let safariViewController = SFSafariViewController(url: URL(string: "https://twitter.com/fojusiapp")!)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func openGithub() {
        let safariViewController = SFSafariViewController(url: URL(string: "https://github.com/dasdom/Tomate")!)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func openRating() {
        UIApplication.shared.open(URL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=923044693")!, options: [:], completionHandler: nil)
        
    }
    
}
