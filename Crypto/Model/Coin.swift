//
//  Coin.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import Foundation

struct APIResponse: Decodable {
    var data: [Coin]
    var info: Info
}

struct Info: Decodable {
    var coins_num: Int
    var time: Int
}

struct Coin: Decodable {
    var id: Int
    var symbol: String
    var name: String
    var nameid: String
    var rank: Int
    var price_usd: String
    var percent_change_24h: String
    var percent_change_1h: String
    var percent_change_7d: String
    var price_btc: String
    var market_cap_usd: String
//    var volume24: Double
//    var volume24a: Double
//    var csupply: String
//    var tsupply: String
//    var msupply: String
}
