//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    private let APIservice = APIService()
    private var coinArray = [Coin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIservice.delegate = self
        APIservice.fetchData()
    }
    
    override func loadView() {
        super.loadView()
        print("Load View")
        view = HomeView()
    }

}

extension HomeViewController: APIProtocol {
    func dataRetrieved(_ retrievedData: APIResponse) {
        self.coinArray = retrievedData.data
        print("Count: \(self.coinArray.count)")
    }
    
    
}
