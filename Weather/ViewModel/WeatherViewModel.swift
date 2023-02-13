//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 26.01.2023.
//

import Foundation
import Alamofire

class WeatherViewModel {
    var weeather = Observable<WeatherModel>()
    var isLoading = Observable<Bool>()
    var alertItem = Observable<AlertItem>()
    
    func getWeather(lang:String,city: String){
        isLoading.value = true
        
        NetworkManager.instance.fetch(endpoint: WeatherEndPoint.weather(lang: lang, city: city), responseModel: WeatherModel.self){ [self] result in
            
            DispatchQueue.main.async { [self] in
                isLoading.value = false
                
                switch result {
                case .success(let result):
                    self.weeather.value = result
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem.value = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem.value = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem.value = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem.value = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
