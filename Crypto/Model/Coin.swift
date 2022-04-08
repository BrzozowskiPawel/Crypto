//
//  Coin.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import Foundation

// TODO: modele nie powinny być mutable. Zmień wszystkie var na let
struct APIResponse: Decodable {
    var data: [Coin]
}

struct Coin: Decodable {
    var id: Int
    var symbol: String
    var name: String
    var quote: Quote
}

struct Quote: Decodable {
    var USD: priceData
}

struct priceData: Decodable {
    var price: Double
    var percent_change_24h: Double
    var percent_change_7d: Double
}
