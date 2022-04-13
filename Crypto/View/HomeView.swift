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
    var sortingSC = UISegmentedControl(items: [sorting.priceUp.rawValue,
                                                       sorting.priceDown.rawValue,
                                                       sorting.change24Up.rawValue,
                                                       sorting.change24Down.rawValue,
                                                       sorting.change7Up.rawValue,
                                                       sorting.change7Down.rawValue])
    
    var sortingTextfield = UITextField()
    var myTableView = UITableView()
    private var sortingStackView = UIStackView()
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
        
        addSubview(sortingStackView)
        sortingStackView.translatesAutoresizingMaskIntoConstraints = false
        configureSortingElements()

    }
    
    private func configureSortingElements() {
        sortingSC.selectedSegmentIndex = 0
        sortingSC.layer.cornerRadius = 5.0
        
        sortingTextfield.layer.cornerRadius = 5.0
        sortingTextfield.translatesAutoresizingMaskIntoConstraints = false
        sortingTextfield.layer.borderWidth = 1.25
        
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

