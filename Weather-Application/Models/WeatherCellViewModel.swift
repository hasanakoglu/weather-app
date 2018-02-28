//
//  WeatherCellViewModel.swift
//  Weather-Application
//
//  Created by Hasan Akoglu on 28/02/2018.
//  Copyright © 2018 ford. All rights reserved.
//

import UIKit

//have the same propeties that our forecastday stuff has as it needs to be presented in the cell
struct WeatherCellViewModel {
    let url: URL
    let day: String
    let description: String
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let imageData = try? Data(contentsOf: self.url) else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
    }
    
}
