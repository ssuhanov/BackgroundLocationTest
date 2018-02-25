//
//  Coordinate+CoreDataProperties.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//
//

import UIKit

typealias CoordinateResultCompletion = (Coordinate?) -> Void
typealias CoordinatesArrayResultCompletion = ([Coordinate]?) -> Void

extension Coordinate {
    static func create(latitude: String?,
                      longitude: String?,
                      completion: CoordinateResultCompletion?) {
        
        Coordinate.create().map { entity in
            entity.dateTime = Date().description
            entity.latitude = latitude
            entity.longitude = longitude
            entity.batteryPercent = "\(Int(UIDevice.current.batteryLevel * 100))"
            
            CoreDataManager.shared.saveContext() { (contextDidSave, error) in
                if contextDidSave {
                    completion?(entity)
                } else {
                    completion?(nil)
                }
            }
        }
    }
    
    static func fetchAll(completion: CoordinatesArrayResultCompletion?) {
        completion?(fetchAll())
    }
    
    private static func fetchAll() -> [Coordinate]? {
        return Coordinate.findAll() as? [Coordinate]
    }
    
    static func deleteAll(completion: BooleanResultCompletion?) {
        Coordinate.deleteAll()
        CoreDataManager.shared.saveContext(completion: completion)
    }
}
