//
//  WeatherVC.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 24.11.2021.
//

import UIKit

class WeatherVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        loading(true)
        downloadWeather { weather in
            self.setView(weather)
            self.loading(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading(true)
        
        if let weather = RealmPersistance.shared.getWeather() {
            setView(weather)
            loading(false)
        } else {
            loading(true)
            downloadWeather { weather in
                RealmPersistance.shared.addWeather(weather)
                self.setView(weather)
                self.loading(false)
            }
        }
    }
    
    func setView(_ weather: Weather) {
        cityNameLabel.text = weather.cityName
        tempLabel.text = String(weather.temp)
        weatherLabel.text = weather.weather
        maxTempLabel.text = "Max: \(weather.maxTemp)"
        minTempLabel.text = "Min: \(weather.minTemp)"
    }
    
    func loading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            contentView.isHidden = true
        } else {
            contentView.isHidden = false
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
}
