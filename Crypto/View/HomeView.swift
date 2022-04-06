//
//  HomeView.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeView: UIView {

    private let rainbowView = UIView()
    private let todayStackView = UIStackView()
    private let todayIsLabel = UILabel()
    private let dateLabel = UILabel()
    private let monthYearLabel = UILabel()

    private var myTableView = UITableView()
    private var coinArray = [Coin]()
    
    private let sortStackView = UIStackView()
    private let sortLabel = UILabel()
    private let sortButton = UIButton()
    
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
        configureLabels()
        addElementsToStackView()
        
        rainbowView.translatesAutoresizingMaskIntoConstraints = false
        rainbowView.addSubview(todayStackView)
        rainbowView.layer.cornerRadius = 10
        addSubview(rainbowView)
        
        addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        configureSorting()
    }
    
    private func configureSorting() {
        sortStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sortStackView)
        
        sortStackView.addArrangedSubview(sortLabel)
        sortStackView.addArrangedSubview(sortButton)
        
        sortLabel.text = "No sorting"
        sortButton.setTitle("title", for: .normal)
        
        sortStackView.axis = NSLayoutConstraint.Axis.horizontal
        sortStackView.distribution = UIStackView.Distribution.equalSpacing
        sortStackView.alignment = UIStackView.Alignment.center
        sortStackView.spacing = 12
        sortStackView.backgroundColor = .red
    }
    
    private func configureLabels() {
        todayIsLabel.translatesAutoresizingMaskIntoConstraints = false
        todayIsLabel.textAlignment = .center
        todayIsLabel.text = "Today is:"
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.text = "Friday 25"
        
        monthYearLabel.translatesAutoresizingMaskIntoConstraints = false
        monthYearLabel.textAlignment = .center
        monthYearLabel.text = "march 2022"
    }
    
    private func addElementsToStackView() {
        todayStackView.translatesAutoresizingMaskIntoConstraints = false
        
        todayStackView.addArrangedSubview(todayIsLabel)
        todayStackView.addArrangedSubview(dateLabel)
        todayStackView.addArrangedSubview(monthYearLabel)
        
        todayStackView.axis = NSLayoutConstraint.Axis.vertical
        todayStackView.distribution = UIStackView.Distribution.equalSpacing
        todayStackView.alignment = UIStackView.Alignment.center
        todayStackView.spacing = 12
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += createRainbowViewConstraints()
        constraints += createRainbowViewStackViewConstraints()
        constraints += createMyTableViewwConstraints()
        constraints += createSortViewStackViewConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createSortViewStackViewConstraints() -> [NSLayoutConstraint] {
        let guide = safeAreaLayoutGuide
        return [
            sortStackView.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: 0),
            sortStackView.heightAnchor.constraint(equalToConstant: 30),
            sortStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 5),
            sortStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -5),
            sortButton.widthAnchor.constraint(equalToConstant: 100)
        ]
    }
    
    private func createRainbowViewConstraints() -> [NSLayoutConstraint] {
        let guide = safeAreaLayoutGuide
        return [
            rainbowView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rainbowView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            rainbowView.widthAnchor.constraint(equalToConstant: 200),
        ]
    }
    
    private func createRainbowViewStackViewConstraints() -> [NSLayoutConstraint] {
        return [
            todayStackView.topAnchor.constraint(equalTo: rainbowView.topAnchor, constant: 10),
            todayStackView.bottomAnchor.constraint(equalTo: rainbowView.bottomAnchor, constant: -10),
            todayStackView.leadingAnchor.constraint(equalTo: rainbowView.leadingAnchor, constant: 10),
            todayStackView.trailingAnchor.constraint(equalTo: rainbowView.trailingAnchor, constant: -10),
        ]
    }
    
    private func createMyTableViewwConstraints() -> [NSLayoutConstraint] {
        let guide = safeAreaLayoutGuide
        return [
            myTableView.topAnchor.constraint(equalTo: rainbowView.bottomAnchor, constant: 20),
            myTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            myTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            myTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
            
        ]
    }
    
    public func configureTodayLabel(dayOfWeek dayOfWeek: String, dayOfMonth dayOfMonth: Int?, month month:String, year year: String) {
        guard let dayOfMonth = dayOfMonth else {
            return
        }

        dateLabel.text = "\(dayOfWeek) \(dayOfMonth)"
        monthYearLabel.text = "\(month) \(year)"
    }
}

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
