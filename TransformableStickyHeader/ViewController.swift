//
//  ViewController.swift
//  TransformableStickyHeader
//
//  Created by Jayant Arora on 1/10/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction
    func buttonTapped(_ sender: AnyObject?) {
        print("Button tapped")

        let stickyVC = StickyViewController()
        navigationController?.pushViewController(stickyVC, animated: true)
    }

}

