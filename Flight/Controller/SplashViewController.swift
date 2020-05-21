//
//  SplashViewController.swift
//  Flight
//
//  Created by Anjali on 5/19/20.
//  Copyright © 2020 Anjali. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
            self.performSegue(withIdentifier: Constants.goToFlightLocation, sender: self)
        }
    }
}
