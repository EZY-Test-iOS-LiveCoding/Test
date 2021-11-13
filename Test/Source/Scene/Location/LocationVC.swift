//
//  LocationVC.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import UIKit
import MapKit
import Then
import SnapKit
import GoogleMaps
import GoogleMapsCore
import RxSwift

final class LocationVC: baseVC<LocationReactor>, CLLocationManagerDelegate{
    // MARK: - Properties
    private let dimView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let container = UIView().then {
        $0.backgroundColor = .white
    }
    private let currentDateLabel = UILabel().then {
        $0.textColor = .white
        $0.dynamicFont(fontSize: 30, fontName: "AppleSDGothicNeo-SemiBold")
    }
    private let currentTempLabel = UILabel().then {
        $0.textColor = .white
        $0.dynamicFont(fontSize: 52, fontName: "AppleSDGothicNeo-light")
    }
    var locationManager = CLLocationManager()
    private var mapView = GMSMapView()
    
    // MARK: - Helpers
    override func addView() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37, longitude: 25, zoom: 17)
        let id = GMSMapID(identifier: "98fe16cf114d1688")
        mapView = GMSMapView(frame: .zero, mapID: id, camera: camera)
        
        [container, dimView].forEach{view.addSubview($0)}
        [currentDateLabel, currentTempLabel].forEach{dimView.addSubview($0)}
        [mapView].forEach{container.addSubview($0)}
    }
    override func setLayout() {
        container.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(500)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        container.backgroundColor = .black
        container.layer.cornerRadius = 41
        dimView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(container.snp.top)
        }
        mapView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        currentDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(15)
        }
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(currentDateLabel.snp.bottom)
            $0.trailing.equalTo(currentDateLabel)
        }
        mapView.layer.cornerRadius = 41
    }
    override func configureUI() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 41
        view.clipsToBounds = true
        
        setDate()
    }
    
    func setDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 hh시"
        self.currentDateLabel.text = "\(dateFormatter.string(from: Date()))"
    }
    
    override func bindState(reactor: LocationReactor) {
        reactor.state.observe(on: MainScheduler.instance)
            .subscribe(onNext: { s in
                self.currentTempLabel.text = "\(s.temp ?? "")°C"
            })
            .disposed(by: disposeBag)
    }
    
    
    override func bindAction(reactor: LocationReactor) {
        self.rx.viewWillAppear
            .map{ _ in Reactor.Action.loadTemp }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}


