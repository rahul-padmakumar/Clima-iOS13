//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTF.delegate = self
    }
    
    @IBAction func onSearchPressed(_ sender: UIButton) {
        search()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }
    
    func search(){
        print(searchTF.text!)
        searchTF.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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

