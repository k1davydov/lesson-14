//
//  WeatherModel.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 24.11.2021.
//

import Foundation
import Alamofire
import RealmSwift

let generalUrl = "https://api.openweathermap.org/data/2.5"
let myToken = "8185f98d9196e8185589bf5651db1866"

class Weather {
    var cityName: String
    var temp: Int
    var weather: String
    var maxTemp: Int
    var minTemp: Int
    
    init(temp: Int, weather: String, maxTemp: Int, minTemp: Int) {
        self.cityName = "Moscow"
        self.temp = temp
        self.weather = weather
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
    
    init() {
        self.cityName = ""
        self.temp = 0
        self.weather = ""
        self.maxTemp = 0
        self.minTemp = 0
    }
}

class RealmWeather: Object {
    @objc dynamic var cityName = ""
    @objc dynamic var temp = 0
    @objc dynamic var weather = ""
    @objc dynamic var maxTemp = 0
    @objc dynamic var minTemp = 0
}

func downloadWeather(completion: @escaping(Weather) -> Void) {
    
    let parameters = ["q":"moscow",
                      "appid":myToken,
                      "units":"metric"]
    
    AF.request(generalUrl+"/weather", parameters: parameters).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let final = weatherParser(value)
            completion(final)
        case .failure(let error):
            print(error)
        }
    }
}

func weatherParser(_ data: Any) -> Weather {
    guard let json = data as? NSDictionary,
          let array = json["weather"] as? NSArray, let dict = array[0] as? NSDictionary, let weather = dict["description"] as? String,
          let main = json["main"] as? NSDictionary,
          let temp = main["temp"] as? Double, let maxTemp = main["temp_max"] as? Double, let minTemp = main["temp_min"] as? Double
    else {return Weather()}
    let final = Weather(temp: Int(temp), weather: weather, maxTemp: Int(maxTemp), minTemp: Int(minTemp))
    return final
}
