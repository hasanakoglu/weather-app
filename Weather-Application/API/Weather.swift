//
//  Weather.swift
//  Weather-Application
//
//  Created by DevPair3 on 23/02/2018.
//  Copyright © 2018 ford. All rights reserved.
//

import Foundation

class Weather: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastText: ForecastText
    
    private enum CodingKeys: String, CodingKey {
        case forecastText = "txt_forecast"
    }
}

struct ForecastText: Codable {
    let date: String
    let forecastDays: [ForecastDay] //array of data we want to display
    
    private enum CodingKeys: String, CodingKey {
        case date
        case forecastDays = "forecastday" //gets the array from json file
    }
}

//this stuff also needed in the weathercellviewmodel
struct ForecastDay: Codable {
    let iconUrl: URL
    let day: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case day = "title"
        case description = "fcttext"
    }
}
