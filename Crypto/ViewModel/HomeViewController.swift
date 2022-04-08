//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    private let APIservice = APIService()
    private var homeView = HomeView()
    private var coinDS = CoinDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIservice.delegate = self
        APIservice.fetchData()
        
        homeView.segmentedControllDelegate = self
        homeView.myTableView.delegate = self
        homeView.myTableView.dataSource = coinDS
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
}

extension HomeViewController: SortingSegmentedControllDelegate {
    func didSelectSegement(segmentIndex: Int) {
        var coinArray = coinDS.getCoinArray()
        switch segmentIndex {
        case 0:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price > $1.quote.USD.price})
        case 1:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price < $1.quote.USD.price})
        case 2:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h > $1.quote.USD.percent_change_24h})
        case 3:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h < $1.quote.USD.percent_change_24h})
        case 4:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d > $1.quote.USD.percent_change_7d})
        case 5:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d < $1.quote.USD.percent_change_7d})
        default:
            print("NONE")
        }
        
        coinDS.updateCoinArray(array: coinArray)
        homeView.myTableView.reloadData()
    }
    
    func
    
}

extension HomeViewController: APIProtocol {
    func dataRetrieved(_ retrievedData: APIResponse) {
//        homeView.configureTableView(coins: retrievedData.data)
        coinDS.updateCoinArray(array: retrievedData.data)
        homeView.myTableView.reloadData()
    }
}

class CoinDataSource: NSObject, UITableViewDataSource {
    
    private var coinArray = [Coin]()
    
    func getCoinArray() -> [Coin] {
        return self.coinArray
    }
    
    func updateCoinArray(array: [Coin]) {
        self.coinArray = array
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath as IndexPath) as! CoinTableViewCell
        
        cell.configureCell(withCell: coinArray[indexPath.row])
        
        return cell
    }
    
}
