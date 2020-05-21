//
//  LocationManager.swift
//  Flight
//
//  Created by Anjali on 5/19/20.
//  Copyright © 2020 Anjali. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import AVFoundation


struct LocationManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func performRequest(completion: @escaping (Bool) -> Void) {
        if let url = URL(string:Constants.locationsURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                if let safedata = data {
                    self.parseJSON(locationData : safedata)
                    completion(true)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(locationData : Data) {
       DispatchQueue.main.async {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: locationData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            if let flightLocationArray = jsonResult["flightlocation"] as? NSArray {
                for data in flightLocationArray {
                    let details = data as! NSDictionary
                    let locationModel = Location(context: self.context)
                        locationModel.airportname = details["airportname"] as? String ?? ""
                        locationModel.iataCode =  details["iataCode"] as? String ?? ""
                        locationModel.location = details["location"] as? String ?? ""
                        locationModel.country = details["country"] as? String ?? ""
                    self.saveDataToLocalStorage()
                }
            }
        } catch {
            print(error)
        }
        }
    }
    
    func saveDataToLocalStorage() {
        
        do {
            try context.save()
        } catch {
            print("Erorr while storing data")
        }
    }
    
    mutating func loadDataFromLocalStorage(with request : NSFetchRequest<Location> = Location.fetchRequest()) -> [Location] {
        var airportLocationArray = [Location]()
        
        do {
            airportLocationArray = try context.fetch(request)
        } catch {
            print("Error in loading Data")
        }
        return airportLocationArray
    }
}
