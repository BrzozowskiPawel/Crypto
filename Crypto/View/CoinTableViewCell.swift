//
//  CoinTableViewCell.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 01/04/2022.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    public static let identifier = "CoinTableViewCell"
    private let coinImage = UIImageView()
    private let coinNameLabel = UILabel()
    private let coinPriceLabel = UILabel()
    private let namePriceStackView = UIStackView()
    
    private var coin: Coin?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        contentView.addSubview(coinImage)
        contentView.addSubview(coinNameLabel)
        contentView.addSubview(namePriceStackView)
        
        setUpCoinImage()
        setUpCoinNameLabel()
        setUpCoinPriceLabel()
        setUpNamePriceStackView()
    }

    private func setUpCoinImage() {
        
        coinImage.translatesAutoresizingMaskIntoConstraints = false
        coinImage.image = UIImage(named: "2give")
        coinImage.contentMode = .scaleAspectFit
        coinImage.clipsToBounds = true
    }
    
    private func setUpCoinNameLabel() {
        coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coinNameLabel.text = "Coin"
    }
    
    private func setUpCoinPriceLabel() {
        coinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        coinPriceLabel.text = "USD"
    }
    
    private func setUpNamePriceStackView() {
        namePriceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        namePriceStackView.addArrangedSubview(coinNameLabel)
        namePriceStackView.addArrangedSubview(coinPriceLabel)
        
        namePriceStackView.axis = NSLayoutConstraint.Axis.vertical
        namePriceStackView.distribution = UIStackView.Distribution.equalSpacing
        namePriceStackView.alignment = UIStackView.Alignment.leading
        namePriceStackView.spacing = 6
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += createCoinImageConstraints()
        constraints += createNamePriceStackView()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCoinImageConstraints() -> [NSLayoutConstraint] {
        return [
            coinImage.heightAnchor.constraint(equalToConstant: 60),
            coinImage.widthAnchor.constraint(equalToConstant: 60),
            coinImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            coinImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ]
    }
    
    private func createNamePriceStackView() -> [NSLayoutConstraint] {
        return [
//            coinNameLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: -20),
            namePriceStackView.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 20),
            namePriceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ]
    }
    
    public func configureCell(withCell configureCoin: Coin) {
        self.coin = configureCoin
        if let coin = coin {
            coinNameLabel.text = coin.name
            coinPriceLabel.text = "\(coin.price_usd) $"
            if let coinImg =  UIImage(named: coin.symbol.lowercased()){
                coinImage.image = coinImg
            }
        }
        
    }
}
