//
//  ViewController.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var coordinates: [Coordinate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateCoordinates()
        self.tableView.dataSource = self
    }
    
    @IBAction func clearHistoryPressed(_ sender: UIButton) {
        Coordinate.deleteAll { [weak self] (contextDidSave, error) in
            if contextDidSave {
                self?.updateCoordinates()
            }
        }
    }
    
    @IBAction func updatePressed(_ sender: UIButton) {
        self.updateCoordinates()
    }
    
    private func updateCoordinates() {
        Coordinate.fetchAll { [weak self] (coordinates) in
            self?.coordinates = coordinates
            self?.tableView.reloadData()
            self?.totalLabel.text = "Total: \(coordinates?.count ?? 0)"
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coordinates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coordinate = self.coordinates?[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoordinateCell", for: indexPath) as? CoordinateTableViewCell {
            cell.configure(coordinate: coordinate)
            return cell
        }
        
        return UITableViewCell()
    }
}
