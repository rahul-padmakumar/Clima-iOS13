//
//  WeatherManager.swift
//  Clima
//
//  Created by Rahul Padmakumar on 18/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func updateWeather(_ data: WeatherUIModel)
    func didErrorOccurred(_ error: Error)
}

struct WeatherManager{
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=xxx&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(place: String? = nil, lat: Double? = nil, long: Double? = nil){
        var completeUrl = url
        
        if let safePlace = place{
            completeUrl = "\(completeUrl)&q=\(safePlace)"
        }
        
        if let safeLong = long, let safeLat = lat{
            completeUrl = "\(completeUrl)&lat=\(safeLat)&lon=\(safeLong)"
        }
        
        print(completeUrl)
        
        if let u1 = URL(string: completeUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: u1){
                if($2 != nil){
                    print($2!)
                    return
                }
                if let data = $0{
                    parseData(data)
                }
            }
            
            task.resume()
        }
    }
    
    func parseData(_ data: Data){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherModel.self, from: data)
            if let safeId = decodeData.weather?[0].id, let safeTemp = decodeData.main?.temp, let safeName = decodeData.name{
                let weatherUIModel = WeatherUIModel(
                    conditionId: safeId,
                    cityName: safeName,
                    temperature: safeTemp
                )
                delegate?.updateWeather(weatherUIModel)
            }
            
        } catch{
            delegate?.didErrorOccurred(error)
        }
    }
}
