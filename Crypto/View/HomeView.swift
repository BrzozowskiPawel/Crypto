//
//  HomeView.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource {

    private let rainbowView = UIView()
    private let rainbowViewStackView = UIStackView()
    private let todayIsLabel = UILabel()
    private let dateLabel = UILabel()
    private let monthYearLabel = UILabel()

    private let myTableView = UITableView()
    private let myArray: NSArray = ["First","Second","Third"]
    
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
        rainbowView.addSubview(rainbowViewStackView)
        rainbowView.layer.cornerRadius = 10
        addSubview(rainbowView)
        
        addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    
    private func addElementsToStackView() {
        rainbowViewStackView.translatesAutoresizingMaskIntoConstraints = false
        
        rainbowViewStackView.addArrangedSubview(todayIsLabel)
        rainbowViewStackView.addArrangedSubview(dateLabel)
        rainbowViewStackView.addArrangedSubview(monthYearLabel)
        
        rainbowViewStackView.axis = NSLayoutConstraint.Axis.vertical
        rainbowViewStackView.distribution = UIStackView.Distribution.equalSpacing
        rainbowViewStackView.alignment = UIStackView.Alignment.center
        rainbowViewStackView.spacing = 12
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += createRainbowViewConstraints()
        constraints += createRainbowViewStackViewConstraints()
        constraints += createMyTableViewwConstraints()
        NSLayoutConstraint.activate(constraints)
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
            rainbowViewStackView.topAnchor.constraint(equalTo: rainbowView.topAnchor, constant: 10),
            rainbowViewStackView.bottomAnchor.constraint(equalTo: rainbowView.bottomAnchor, constant: -10),
            rainbowViewStackView.leadingAnchor.constraint(equalTo: rainbowView.leadingAnchor, constant: 10),
            rainbowViewStackView.trailingAnchor.constraint(equalTo: rainbowView.trailingAnchor, constant: -10),
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

}
