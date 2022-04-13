//
//  Coin.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import Foundation

struct APIResponse: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let symbol: String
    let name: String
    let quote: Quote
}

struct Quote: Decodable {
    let USD: priceData
}

struct priceData: Decodable {
    let price: Double
    let percent_change_24h: Double
    let percent_change_7d: Double
}
