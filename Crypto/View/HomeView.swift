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

protocol SortingSegmentedControllDelegate: NSObject {
    func didSelectSegement(segmentIndex: Int)
    func didTypeCoinName(text: String)
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
    var myTableView = UITableView()
    private var coinArrayIndex: Int = 0
    
    weak var segmentedControllDelegate: SortingSegmentedControllDelegate?
    
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
            self.segmentedControllDelegate?.didTypeCoinName(text: text)
        }
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.segmentedControllDelegate?.didSelectSegement(segmentIndex: sender.selectedSegmentIndex)
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

