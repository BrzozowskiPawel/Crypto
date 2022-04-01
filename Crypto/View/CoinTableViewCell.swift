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
    private let coinPriceChangeStackView = UIStackView()
    private let coin24hChangeLabel = UILabel()
    private let coin7dChangeLabel = UILabel()
    
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
        contentView.addSubview(namePriceStackView)
        contentView.addSubview(coinPriceChangeStackView)
        
        setUpCoinImage()
        setUpCoinNameLabel()
        setUpCoinPriceLabel()
        setUpNamePriceStackView()
        setUpcoinPriceChangeStackViewStackView()
        setUp24hPriceChangePriceLabel()
        setUp7dPriceChangePriceLabel()
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
    
    private func setUp24hPriceChangePriceLabel() {
        coin24hChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        coin24hChangeLabel.text = "+20 24H"
        coin24hChangeLabel.textAlignment = .right
    }
    
    private func setUp7dPriceChangePriceLabel() {
        coin7dChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        coin7dChangeLabel.text = "-10 7d"
        coin7dChangeLabel.textAlignment = .right
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
    
    private func setUpcoinPriceChangeStackViewStackView() {
        coinPriceChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        coinPriceChangeStackView.addArrangedSubview(coin24hChangeLabel)
        coinPriceChangeStackView.addArrangedSubview(coin7dChangeLabel)
        
        coinPriceChangeStackView.axis = NSLayoutConstraint.Axis.vertical
        coinPriceChangeStackView.distribution = UIStackView.Distribution.equalSpacing
        coinPriceChangeStackView.alignment = UIStackView.Alignment.leading
        coinPriceChangeStackView.spacing = 6
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += createCoinImageConstraints()
        constraints += createNamePriceStackViewConstraints()
        constraints += createcoinPriceChangeStackViewConstraints()
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
    
    private func createNamePriceStackViewConstraints() -> [NSLayoutConstraint] {
        return [
            namePriceStackView.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 20),
            namePriceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
    }
    
    private func createcoinPriceChangeStackViewConstraints() -> [NSLayoutConstraint] {
        return [
            coinPriceChangeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            coinPriceChangeStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
    }
    
    public func configureCell(withCell configureCoin: Coin) {
        self.coin = configureCoin
        if let coin = coin {
            coinNameLabel.text = coin.name
            coinPriceLabel.text = "\(coin.price_usd) $"
            coin24hChangeLabel.text = "\(coin.percent_change_24h)% 24h"
            coin7dChangeLabel.text = "\(coin.percent_change_7d) 7d"
            if let coinImg =  UIImage(named: coin.symbol.lowercased()){
                coinImage.image = coinImg
            }
        }
        
    }
}
