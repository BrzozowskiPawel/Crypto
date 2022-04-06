//
//  APICaller.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import Foundation

protocol APIProtocol: AnyObject {
    func dataRetrieved(_ retrievedData: APIResponse)
}

class APIService {
    // Deleagate-Protocol pattern to retrieve data
    weak var delegate: APIProtocol?
    
    // Function requaired to fetch data from API
    func fetchData() {
        print("WORKING ")
        
        guard let url  = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=32461a18-c3a1-474d-8b3f-da1d6d8be698&convert=USD") else {
            print("CANNOT CRATE URL - it empty ")
            return
        }

        // Create request (GET with all headers)
        // NOTE: API protection could have been added but it's not the case here.
        let request = URLRequest(url: url)

        // Create a task with request
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, errorURL in
            // Chcech that there are no errors and there is data
            if errorURL == nil && data != nil {
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                do {
                    // Parse the JSON
                    let decodedData = try decoder.decode(APIResponse.self, from: data!)
                    // Everything connected with UI should be in main thread
                    DispatchQueue.main.async {
                        // Parse the returned JSON back to the view controller with the protocol and deleagte pattern
                        self?.delegate?.dataRetrieved(decodedData)
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


