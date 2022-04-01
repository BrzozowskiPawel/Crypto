//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    private let APIservice = APIService()
    private var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIservice.delegate = self
        APIservice.fetchData()
        
        calculateDate()
    }
    
    override func loadView() {
        super.loadView()
        print("Load View")
        view = homeView
    }
    
    private func calculateDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatter.locale = Locale(identifier: "en")
        
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        homeView.configureTodayLabel(dayOfWeek: dayOfTheWeekString, dayOfMonth: dayOfMonth, month: monthString, year: yearString)
    }

}

extension HomeViewController: APIProtocol {
    func dataRetrieved(_ retrievedData: APIResponse) {
        homeView.configureTableView(coins: retrievedData.data)
    }
}
