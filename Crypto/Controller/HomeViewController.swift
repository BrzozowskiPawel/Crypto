//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITableViewDelegate {

    private let APIservice = APIService()
    private var homeView = HomeView()
    private var coinDataSource = CoinDataSource()
    private let disposeBag = DisposeBag()

    private var myTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIservice.delegate = self
        APIservice.fetchData()
        
        setUpTableView(myTableView: homeView.getMyTableView())
        
        bindTableViewWithData()
        bindSortingSegmentedControl()
        bindSortingTextField()
        
    }
    private func setUpTableView(myTableView: UITableView) {
        myTableView.rx.setDelegate(self).disposed(by: disposeBag)
        myTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
    }
    private func bindTableViewWithData() {
        coinDataSource.bindWithTable(homeView: homeView, disposeBag: disposeBag)
    }
    
    private func bindSortingTextField() {
        let sortingTextfield = homeView.getSortingTextfield()
        sortingTextfield.rx.text.subscribe(onNext: { text in
            if let text = text {
                var coinArray = self.coinDataSource.getCoinArray()
                var coinArraySearchList = self.coinDataSource.getCoinArraySearchList()
                var coinArrayIndex = self.coinDataSource.getCoinArrayIndex()
                
                if text.count > 0  {self.coinDataSource.didStartEditing()}
                    
                guard self.coinDataSource.getEditingFlag() == true else {return}
                
                if coinArraySearchList.count == 0 {
                    coinArraySearchList.append(coinArray)
                    print("here ")
                }
                
                if coinArrayIndex > text.count {
                    coinArray = coinArraySearchList[text.count]
                    coinArraySearchList.remove(at: coinArrayIndex)
                    coinArrayIndex = text.count
                } else {
                    coinArray = coinArray.filter({ coin in
                        return coin.name.lowercased().contains(text.lowercased())
                    })
                    coinArrayIndex += 1
                    coinArraySearchList.append(coinArray)
                }
                
                self.coinDataSource.updateCoinArray(array: coinArraySearchList[coinArrayIndex])
                self.coinDataSource.updateCoinArraySearchList(coinArrList: coinArraySearchList)
                self.coinDataSource.updateCoinArrayIndex(indexVal: coinArrayIndex)
                
            }
            else {
                print("Problem")
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindSortingSegmentedControl() {
        let sortingSC = homeView.getSortingSegmentedControl()
        sortingSC.rx.selectedSegmentIndex.subscribe(onNext: { segmentIndex in
            var coinArray = self.coinDataSource.getCoinArray()
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
            
            self.coinDataSource.updateCoinArray(array: coinArray)
        }).disposed(by: disposeBag)
        
    }
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
}

extension HomeViewController: APIProtocol {
    func coinArrayDidRetrieve(_ retrievedCoinArray: [Coin]) {
        coinDataSource.updateCoinArray(array: retrievedCoinArray)
    }
}


