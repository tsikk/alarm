//
//  ViewModelCovid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit


protocol CovidListViewModelProtocol: AnyObject {
    var didFinishedLoading: (() -> Void)? { get set }
    var navigationItem: UINavigationItem? { get set }
    func setTitle(with text: String, on navigationItem: UINavigationItem)
    var controller: CoordinatorDelegate { get }
    
    func getCovidData(completion: @escaping (([CovidViewModel]) -> Void))
 
    init(controller: CoordinatorDelegate, covidManager : CovidManagerProtocol) 
}

final class CovidListViewModel: CovidListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishedLoading: (() -> Void)?
    var navigationItem: UINavigationItem?
    
    init(controller: CoordinatorDelegate, covidManager : CovidManagerProtocol)  {
        self.controller       = controller
        self.covidManager     = covidManager
    }
    
    func getCovidData(completion: @escaping (([CovidViewModel]) -> Void)) {
        covidManager.fetchCovidStats { result in

            DispatchQueue.main.async {
                let covidViewModel = result.map { CovidViewModel(covid: $0) }
                completion(covidViewModel)
            }
        }
    }
  
    func setTitle(with text: String, on navigationItem: UINavigationItem) {
        navigationItem.title = text
    }
}



