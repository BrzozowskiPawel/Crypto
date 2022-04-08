//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    private let APIservice = APIService()
    private var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIservice.delegate = self
        APIservice.fetchData()
        
    }
    
    override func loadView() {
        super.loadView()
        print("Load View")
        view = homeView
    }
    
}

extension HomeViewController: APIProtocol {
    func dataRetrieved(_ retrievedData: APIResponse) {
        homeView.configureTableView(coins: retrievedData.data)
    }
}
