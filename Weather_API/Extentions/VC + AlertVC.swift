//
//  VC + AlertVC.swift
//  Weather_API
//
//  Created by Александр Старков on 29.03.2022.
//

import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping(String) -> Void) {
        let al = UIAlertController(title: title, message: message, preferredStyle: style)
        al.addTextField { textField in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            textField.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { _ in
            let textField = al.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
          //      self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
                //создаем сити (если название города состоит из двух слов, метод split делает из него массив через разделитель, и потом соединяет
                let city = cityName.split(separator: " ").joined(separator: "%20") // %20 - это URL - код пробела
                completionHandler(city)
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        al.addAction(search)
        al.addAction(cancel)
        present(al, animated: true, completion: nil)
    }
}
