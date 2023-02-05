//
//  MapViewController.swift
//  partyPlaner
//
//  Created by Apple Esprit on 19/4/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let initialLoc = CLLocation(latitude: 34.4739, longitude: 9.4613)
        setStartingLocation(location: initialLoc, distance: 30000)
        addAnnotaton()
        
    }
    
    func setStartingLocation(location: CLLocation,distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate , latitudinalMeters: distance, longitudinalMeters: distance)
        mapview.setRegion(region, animated: true)
        mapview.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange =
        MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 50000)
        mapview.setCameraZoomRange(zoomRange, animated: true)
        
    }
    func addAnnotaton (){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 34.4739, longitude: 9.4613)
        pin.title = "My Position"
        pin.subtitle = "My SUbtitle"
        mapview.addAnnotation(pin)
    }
   

}
