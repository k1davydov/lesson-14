//
//  RealmModel.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import Foundation
import RealmSwift
import UIKit

class RealmTask: Object {
    @objc dynamic var name = ""
}

class RealmPersistance {
    static let shared = RealmPersistance()
    
    private let realm = try! Realm()
    
    func addWeather (_ weather: Weather) {
        let newWeather = RealmWeather()
        newWeather.cityName = weather.cityName
        newWeather.temp = weather.temp
        newWeather.weather = weather.weather
        newWeather.maxTemp = weather.maxTemp
        newWeather.minTemp = weather.minTemp
        try! realm.write({
            realm.add(newWeather)
        })
    }
    
    func addTask(_ task: String) {
        let newTask = RealmTask()
        newTask.name = task
        try! realm.write({
            realm.add(newTask)
        })
    }
    
    func getWeather() -> Weather? {
        guard let weather = realm.objects(RealmWeather.self).first else {return nil}
        return Weather(temp: weather.temp, weather: weather.weather, maxTemp: weather.maxTemp, minTemp: weather.minTemp)
    }
    
    func getTasks() -> [String]{
        var finalTasks = [String]()
        let tasks = realm.objects(RealmTask.self)
        for task in tasks {
            finalTasks.append(task.name)
        }
        return finalTasks
    }
    
    func deleteWeather() {
        let weather = realm.objects(RealmWeather.self)
        try! realm.write({
            realm.delete(weather)
        })
    }
    
    func deleteAllTasks() {
        try! realm.write({
            realm.deleteAll()
        })
    }
}


