//
//  MapView.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//MARK: MapView Class
final class MapView: PaperlessUserInterface {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map View"

        let stadiums = [Stadium(name: "Katowice", lattitude: 50.2598987, longtitude: 19.0215852),
                        Stadium(name: "Home", lattitude: 50.40279, longtitude: 18.87327),
                        Stadium(name: "Work", lattitude: 50.3466585, longtitude: 18.9005171)]
        
        chekLocationServices()
        fetchStadiumsOnMap(stadiums)
        
        centerViewOnUserLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewWillAppear(true)
//         centerViewOnUserLocation()
         print("asdasda")
     }
    
    @IBAction func mainTabAction(_ sender: Any) {
        router.goToMainTab()
    }
    @IBAction func historyAction(_ sender: Any) {
        router.goToHistory()
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            print("SET CENTER!")
            mapView.setRegion(region, animated: false)
        } else {
            print("some error")
        }
    }
    
    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
        for stadium in stadiums {
            let annotations = MKPointAnnotation()
            annotations.title = stadium.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                stadium.lattitude, longitude: stadium.longtitude)
            mapView.addAnnotation(annotations)
            print(stadiums)
        }
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func chekLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            chekLocationAutorization()
        } else {
            print("no permissions")
        }
    }
    
    func chekLocationAutorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            print("when use")
//            mapView.showsUserLocation = true
//            centerViewOnUserLocation()
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//            break
//        case .authorizedAlways:
//            print("always")
//            break
//        case .restricted:
//            break
//        @unknown default:
//            fatalError()
//        }
    }
    
}

//MARK: - MapView API
extension MapView: MapViewApi {
}

// MARK: - MapView MVC Components API
extension MapView {
    var viewModel: MapViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MapViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: MapDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! MapDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: MapRouterApi {
        // swiftlint:disable force_cast
        return _router as! MapRouterApi
        // swiftlint:enable force_cast
    }
}

extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,   locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        chekLocationAutorization()
    }
}
