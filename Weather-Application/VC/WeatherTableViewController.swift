//
//  WeatherTableViewController.swift
//  Weather-Application
//
//  Created by DevPair3 on 23/02/2018.
//  Copyright © 2018 ford. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var cellViewModels = [WeatherCellViewModel]() //an empty array of our weather cells

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // we create the instance of the weather api, inside the client, we provide an endpoint. Then call the weather function to get the data or error
        let weatherApi = WeatherAPIClient()
        let weatherEndpoint = WeatherEndPoint.tenDayForecast(city: "Boston", state: "MA")
        weatherApi.weather(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let forecaseText):
                print(forecaseText)
                // forecastdays has an array of the 10 day forecast, we then map over each of the values then intialize
                self.cellViewModels = forecaseText.forecastDays.map {
                    WeatherCellViewModel(url: $0.iconUrl, day: $0.day, description: $0.description)
                }
                //update UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count //to get the amount of weather cells we need, it is set as an empty array atm
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        //configure the cell
        
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.day
        cell.detailTextLabel?.text = cellViewModel.description
        cellViewModel.loadImage { (image) in
            cell.imageView?.image = image
        }

        return cell
    }
}
