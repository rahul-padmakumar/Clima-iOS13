//
//  WeatherManager.swift
//  Clima
//
//  Created by Rahul Padmakumar on 18/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func updateWeather(data: WeatherUIModel)
}

struct WeatherManager{
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=XXXXf&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(place: String){
        let completeUrl = "\(url)&q=\(place)"
        print(completeUrl)
        
        if let u1 = URL(string: completeUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: u1){
                if($2 != nil){
                    print($2!)
                    return
                }
                if let data = $0{
                    parseData(data: data)
                }
            }
            
            task.resume()
        }
    }
    
    func parseData(data: Data){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherModel.self, from: data)
            if let safeId = decodeData.weather?[0].id, let safeTemp = decodeData.main?.temp, let safeName = decodeData.name{
                let weatherUIModel = WeatherUIModel(
                    conditionId: safeId,
                    cityName: safeName,
                    temperature: safeTemp
                )
                delegate?.updateWeather(data: weatherUIModel)
            }
            
        } catch{
            print(error)
        }
    }
}
