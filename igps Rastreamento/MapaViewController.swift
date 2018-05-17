//
//  MapaViewController.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 16/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var veiculos:Veiculos?
    
    var latitude = 23.5475000
    var longitude = -46.6361100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let latitude = veiculos?.latitude {
//           let latitude = Double(latitude)
//        }
//
//        if let longitude = veiculos?.latitude {
//           let longitude = Double(longitude)
//        }
//
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1500, 1500), animated: true)
        
        let pin = Pin(coordinate: location)
        
        mapView.addAnnotation(pin)
        
        let camera = MKMapCamera()
        camera.centerCoordinate = location
        camera.pitch = 80
        camera.altitude = 100
        mapView.setCamera(camera, animated: true)
    
    }
}


