//
//  MapaViewController.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 16/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
