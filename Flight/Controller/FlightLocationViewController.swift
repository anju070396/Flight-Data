//
//  ViewController.swift
//  Flight
//
//  Created by Anjali on 5/19/20.
//  Copyright © 2020 Anjali. All rights reserved.
//

import UIKit
import CoreData

class FlightLocationViewController: UITableViewController {
    var locationDataArray = [Location]()
    var locationanager = LocationManager()
//    @IBOutlet weak var label : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Airports"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationanager.performRequest { (result) in
            if result {
                self.locationDataArray = self.locationanager.loadDataFromLocalStorage()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.flightLocationCell) as! FlightLocationTableViewCell
        let locationObj = locationDataArray[indexPath.row]
        cell.airportnameLabel.text = locationObj.airportname
        cell.iataCodeLabel.text = "\(locationObj.iataCode ?? "") - "
        cell.locationLabel.text = locationObj.location
        cell.countryLabel.text = locationObj.country
        return cell
    }
}

extension FlightLocationViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Location> = Location.fetchRequest()
        let predicate = NSPredicate(format: "airportname CONTAINS[CD] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptors = NSSortDescriptor(key: "airportname", ascending: true)
        request.sortDescriptors = [sortDescriptors]
        
        self.locationDataArray = self.locationanager.loadDataFromLocalStorage(with: request)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
         locationDataArray = locationanager.loadDataFromLocalStorage()
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
