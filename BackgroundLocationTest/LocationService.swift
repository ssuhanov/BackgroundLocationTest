import CoreLocation
import CoreMotion

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        configurate()
    }
    
    private func configurate() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func start() {
        setActiveMode(true)
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startMonitoringVisits()
    }
    
    private func setActiveMode(_ value: Bool) {
        if value {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            //locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.distanceFilter = 10
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = CLLocationDistanceMax
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Logger.log(message: "New locations")
        locations.forEach { self.logAndSaveCoordinate($0.coordinate) }
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        Logger.log(message: "New visit")
        self.logAndSaveCoordinate(visit.coordinate)
    }
    
    private func logAndSaveCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        Logger.log(message: "\(latitude), \(longitude)")
        Coordinate.create(latitude: "\(latitude)", longitude: "\(longitude)", completion: nil)
    }
}
