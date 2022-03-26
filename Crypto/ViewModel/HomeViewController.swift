//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        print("Load View")
        view = HomeView()
    }

}

