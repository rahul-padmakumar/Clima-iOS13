//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBAction func onUserLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTF.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    
        requestLocationPermission()
    }
    
    func requestLocationPermission(){
        if #available(iOS 14.0, *) {
            let status = locationManager.authorizationStatus
            switch status{
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func onSearchPressed(_ sender: UIButton) {
        search()
    }

    func search(){
        print(searchTF.text!)
        searchTF.endEditing(true)
    }
}

// Mark - CLLocationManager

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let safeLocation = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = safeLocation.coordinate.latitude
            let long = safeLocation.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, long: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location error")
    }
}

// Mark - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let place = searchTF.text{
            weatherManager.fetchWeather(place: place)
        }
        searchTF.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTF.text == ""{
            searchTF.placeholder = "Please type something"
            return false
        } else {
            return true
        }
    }
}

// Mark - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func updateWeather(_ data: WeatherUIModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = data.temperatureName
            self.cityLabel.text = data.cityName
            self.conditionImageView.image = UIImage(systemName: data.conditionName)
        }
    }
    
    func didErrorOccurred(_ error: any Error) {
        print(error)
    }
}

