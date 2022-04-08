//
//  HomeView.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

enum sorting: String {
    case priceUp = "＄⬆️"
    case priceDown = "＄⬇️"
    case change24Up = "％⬆️"
    case change24Down = "％⬇️"
    case change7Up = "％⒎⬆️"
    case change7Down = "％⒎⬇️"
}

class HomeView: UIView {
    private var sortingSC = UISegmentedControl(items: [sorting.priceUp.rawValue,
                                                       sorting.priceDown.rawValue,
                                                       sorting.change24Up.rawValue,
                                                       sorting.change24Down.rawValue,
                                                       sorting.change7Up.rawValue,
                                                       sorting.change7Down.rawValue])
    private var sortingTextfield = UITextField()
    private var sortingStackView = UIStackView()
    private var myTableView = UITableView()
    // TODO: View nie może trzymać modeli ( ew. jedynie ViewModele)
    private var coinArray = [Coin]()
    private var coinArraySearchList = [[Coin]]()
    private var coinArrayIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureElements()
        addConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureElements() {
        
        addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        addSubview(sortingStackView)
        sortingStackView.translatesAutoresizingMaskIntoConstraints = false
        configureSortingElements()

    }
    
    private func configureSortingElements() {
        sortingSC.selectedSegmentIndex = 0
        sortingSC.layer.cornerRadius = 5.0
        sortingSC.addTarget(self, action: #selector(self.segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        sortingTextfield.layer.cornerRadius = 5.0
        sortingTextfield.translatesAutoresizingMaskIntoConstraints = false
        sortingTextfield.layer.borderWidth = 1.25
        sortingTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        sortingTextfield.attributedPlaceholder = NSAttributedString(
            string: "Search by coin name 🔍",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        
        sortingStackView.addArrangedSubview(sortingSC)
        sortingStackView.addArrangedSubview(sortingTextfield)
        
        sortingStackView.axis = NSLayoutConstraint.Axis.vertical
        sortingStackView.distribution = UIStackView.Distribution.equalSpacing
        sortingStackView.alignment = UIStackView.Alignment.center
        sortingStackView.spacing = 5
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            
            if coinArraySearchList.count == 0 {
                coinArraySearchList.append(coinArray)
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
            
            myTableView.reloadData()
        }
    }
    //TODO: logika w modelu
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price > $1.quote.USD.price})
            myTableView.reloadData()
        case 1:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price < $1.quote.USD.price})
            myTableView.reloadData()
        case 2:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h > $1.quote.USD.percent_change_24h})
            myTableView.reloadData()
        case 3:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h < $1.quote.USD.percent_change_24h})
            myTableView.reloadData()
        case 4:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d > $1.quote.USD.percent_change_7d})
            myTableView.reloadData()
        case 5:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d < $1.quote.USD.percent_change_7d})
            myTableView.reloadData()
        default:
            print("NONE")
        }
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += createMyTableViewwConstraints()
        constraints += createSortingSCConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createSortingSCConstraints() -> [NSLayoutConstraint] {
        let guide = safeAreaLayoutGuide
        return [
            sortingStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 5),
            sortingStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -5),
            sortingStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            sortingStackView.heightAnchor.constraint(equalToConstant: 60),
            sortingTextfield.widthAnchor.constraint(equalTo: sortingStackView.widthAnchor, constant: -10),
            sortingTextfield.heightAnchor.constraint(equalTo: sortingSC.heightAnchor)
        ]
    }
    
    private func createMyTableViewwConstraints() -> [NSLayoutConstraint] {
        let guide = safeAreaLayoutGuide
        return [
            myTableView.topAnchor.constraint(equalTo: sortingStackView.bottomAnchor, constant: 10),
            myTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            myTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            myTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
            
        ]
    }
}

// TODO: view nie może wykonywać logiki, powinieneś stworzyć osobną klasę implementującą UITableViewDataSource i przypisać jej obiekt do table view. Za UITableViewDelegate powinien odpowiadać albo ViewController albo (najlepiej) interactor
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(coinArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath as IndexPath) as! CoinTableViewCell
        
        cell.configureCell(withCell: coinArray[indexPath.row])
        
        return cell
    }
    
    public func configureTableView(coins: [Coin]) {
        self.coinArray = coins
        myTableView.reloadData()
        print("RELOADING SHOULD APEAR = \(coins.count)")
    }
}
