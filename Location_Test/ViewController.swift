//
//  ViewController.swift
//  Location_Test
//
//  Created by Masato Hayakawa on 2019/04/14.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let placeLabel = UILabel()
    let getButton = UIButton()
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeLabel.frame = CGRect(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2 - 100, width: 250, height: 100)
        view.addSubview(placeLabel)
        getButton.frame = CGRect(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2 + 100, width: 120, height: 60)
        getButton.setTitle("取得", for: .normal)
        getButton.setTitleColor(.blue, for: .normal)
        getButton.layer.borderWidth = 1
        getButton.layer.borderColor = UIColor.blue as! CGColor
        getButton.layer.cornerRadius = 15
        view.addSubview(getButton)
        
        setupLocationManager()
    }
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else {return}
        locationManager.requestAlwaysAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways{
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            //位置情報の取得を開始する
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
    }


}

