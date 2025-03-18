//
//  WeatherModel.swift
//  Clima
//
//  Created by Rahul Padmakumar on 18/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable{
    let name: String?
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
}

struct Coord: Decodable{
    let lon: Double?
    let lat: Double?
}

struct Weather: Decodable{
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable{
    let temp: Double?
}
