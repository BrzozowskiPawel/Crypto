//
//  APICaller.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import Foundation

protocol APIProtocol: AnyObject {
    func dataRetrieved(_ retrievedData: [Coin])
}

class APIService {
    weak var delegate: APIProtocol?
    func fetchData() {
        guard let url  = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=32461a18-c3a1-474d-8b3f-da1d6d8be698&convert=USD")
        else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, errorURL in
            if errorURL == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    var decodedData = try decoder.decode(APIResponse.self, from: data!)
                    DispatchQueue.main.async {
                        // Parse the returned JSON back to the view controller with the protocol and deleagte pattern
                        let dataFromAPI = decodedData.data.sorted(by: {$0.quote.USD.price > $1.quote.USD.price})
                        self?.delegate?.dataRetrieved(dataFromAPI)
                    }
                } catch {
                    print("Sorry there was and error while decoding JSON: \(error)")
                }
                
            }
            else if let errorURL = errorURL {
                print("HTTP Request Failed \(errorURL)")
            }
        }
        task.resume()
    }
}


