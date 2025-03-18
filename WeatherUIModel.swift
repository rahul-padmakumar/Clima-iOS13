//
//  WeatherUIModel.swift
//  Clima
//
//  Created by Rahul Padmakumar on 18/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

struct WeatherUIModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureName: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId{
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 800: return "sun.max"
        default: return "cloud"
        }
    }
}
