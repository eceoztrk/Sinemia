//
//  SinemalarViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 31.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SinemalarViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    
    @IBOutlet var mapView: MKMapView!
    let locationManager  = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true


        
    }
    

   /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            self.mapView.setRegion(region, animated: true)
            let lat : Double = location.coordinate.latitude
            let long : Double = location.coordinate.longitude
            //setupmm(lat: lat, long: long)
        }
    }*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            let lati : Double = location.coordinate.latitude
            let longt : Double = location.coordinate.longitude
            print(lati)
            print(longt)
            map(lat: lati, long: longt)
        }
    }
    func setupmm(lat : Double, long : Double) {
        
        let sourceLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let destinationLocation = CLLocationCoordinate2D(latitude: 37.333333, longitude: 35.315591)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        //sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        //destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
            
        }
        
        
        mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (response, error) in
            if error != nil {
                return
            }
            
            let route = response?.routes[0]
            self.mapView.addOverlay((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
            
            let rect = route?.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect!), animated: true)
            
            print("\((route?.expectedTravelTime)! / 60) minute walking distance")
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 4.0
        
        
        return renderer
    }

   func map(lat: Double, long: Double)
    {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Sinema"
        request.region = mapView.region
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occurred in search:\(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    let mkanot = MKPointAnnotation()
                    mkanot.coordinate = item.placemark.coordinate
                    self.mapView.addAnnotation(mkanot)
                    mkanot.title = item.name
                }
            }
        })
    }
}
