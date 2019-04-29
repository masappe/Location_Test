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
    
    @IBOutlet weak var isRegion: UILabel!
    let textLabel = UILabel()
    let placeLabel = UILabel()
    let getButton = UIButton()
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textLabel.text = "位置情報取得"
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        placeLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 50)
        placeLabel.textAlignment = .center
        placeLabel.numberOfLines = 0
        placeLabel.sizeToFit()
        view.addSubview(placeLabel)
        getButton.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 60, y: UIScreen.main.bounds.size.height / 2 + 100, width: 120, height: 60)
        getButton.setTitle("取得", for: .normal)
        getButton.setTitleColor(.blue, for: .normal)
        getButton.layer.borderWidth = 1
        getButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        getButton.layer.cornerRadius = 15
        view.addSubview(getButton)
        getButton.addTarget(self, action: #selector(getInformation), for: .touchUpInside)
        
        //位置情報の取得の許可
        setupLocationManager()
    }
    //simulatorでは東京の場所の設定をしなければいけない
    @objc func getInformation() {
        
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        placeLabel.text = "latutude:\(latitude!)\nlongitude:\(longitude!)"
        print("latutude:\(latitude),longitude:\(longitude)")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        placeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        placeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
    }
    //位置情報の取得の許可と位置情報取得の許可
    func setupLocationManager(){
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else {return}
        //userからの許可
        locationManager.requestAlwaysAuthorization()
        //許可の状況確認
        let status = CLLocationManager.authorizationStatus()
        //許可状態が一致したら
        if status == .authorizedAlways {
            locationManager.delegate = self
            locationManager.distanceFilter = 0.1
            //位置情報の取得を開始する
            locationManager.startUpdatingLocation()
            //モニタリング場所
            let nowLatitude = (locationManager.location?.coordinate.latitude)!
            let nowLongitude = (locationManager.location?.coordinate.longitude)!
            let moniteringCordinate = CLLocationCoordinate2DMake(0,0)
            print("latitude: \(nowLatitude)\nlongitude: \(nowLongitude)")
            //モニタリングの設定
            let moniteringRegion = CLCircularRegion(center: moniteringCordinate, radius: 0.1, identifier: "Nitech")

            //モニタリング開始
            locationManager.startMonitoring(for: moniteringRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        isRegion.text = "start"
        print("-------")
        print(manager)
        print("-------")
        print(region)
        print("-------")
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        locationManager.requestState(for: region)
        print(region)
        print("B")
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("C")
    }
    //領域内に侵入した時
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        isRegion.text = "侵入中"
        print("VVVVV")
        print("-------")
        print(manager)
        print("-------")
        print(region)
        print("-------")

    }
    //領域外になった時
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        isRegion.text = "エリア外"
        print("BBBB")
    }
    
    //距離的にアップデートされた時
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        print("-------")
        print(manager)
        print("-------")
        print(locations)
        print("-------")

//        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
    }


}

