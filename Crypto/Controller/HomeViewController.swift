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
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIservice.delegate = self
        APIservice.fetchData()
        
        homeView.myTableView.rx.setDelegate(self).disposed(by: bag)
        homeView.myTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        coinDataSource.coinArrayPublishSubject.bind(to: homeView.myTableView.rx.items(cellIdentifier: CoinTableViewCell.identifier, cellType: CoinTableViewCell.self)){
            row, coin , cell in
            cell.configureCell(with: coin)
        }.disposed(by: bag)
        
        bindSortingSegmentedControl()
        bindSortingTextField()
        
    }
    
    private func bindSortingTextField() {
        homeView.sortingTextfield.rx.text.subscribe(onNext: { text in
            if let text = text {
                var coinArray = self.coinDataSource.getCoinArray()
                var coinArraySearchList = self.coinDataSource.getCoinArraySearchList()
                var coinArrayIndex = self.coinDataSource.getCoinArrayIndex()
                
                if text.count > 0  {self.coinDataSource.startedEditingFlag = true}
                    
                guard self.coinDataSource.startedEditingFlag == true else {return}
                
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
        }).disposed(by: bag)
    }
    
    private func bindSortingSegmentedControl() {
        homeView.sortingSC.rx.selectedSegmentIndex.subscribe(onNext: { segmentIndex in
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
        }).disposed(by: bag)
        
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


