//
//  WeatherAPIClient.swift
//  Weather-Application
//
//  Created by Hasan Akoglu on 28/02/2018.
//  Copyright © 2018 ford. All rights reserved.
//

import Foundation

//what happens here: when we call our weather function below, we are gonna create an instance of the apiclient in the viewcontroller, gonna use the default initializer below and not pass anything in, gonna use the url shared session, then we can call the weather method in the viewdidload to get data.

class WeatherAPIClient : APIClient {
    //conforms to protocol apiclient we created before
    
    var session: URLSession
    
    //default initializer
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndPoint, completion: @escaping (Either<ForecastText,APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather,APIError>) in
            switch either {
            case .value(let weather):
                let textForecast = weather.forecast.forecastText
                completion(.value(textForecast))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}
