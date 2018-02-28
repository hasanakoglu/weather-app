//
//  EndPoint.swift
//  Weather-Application
//
//  Created by Hasan Akoglu on 28/02/2018.
//  Copyright © 2018 ford. All rights reserved.
//

import Foundation

// when we construct url, we have baseurl a path and we can also add query items
protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get } //specify parameters to our endpoint,
    
}

//need some properties to give us default implementation, enum then uses it
extension EndPoint {
    //A structure that passes URLs into and constructs URLs from their constituent parts
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    
    //create request to return urlcomponent
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
    
}

enum WeatherEndPoint: EndPoint {
    //create one case for endpoint
    case tenDayForecast(city: String, state: String)
    
    var baseUrl: String {
        return "https://api.wunderground.com"
    }
    
    var path: String {
        switch self {
        case .tenDayForecast(let city, let state):
            return "/api/2bc26a9505dd7209/forecast10day/q/\(state)/\(city).json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        // we can add items if we want, optional
        return []
    }
    
}
