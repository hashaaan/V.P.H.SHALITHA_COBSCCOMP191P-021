//
//  HomeViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 8/25/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MapKit

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"

class HomeViewController: UIViewController {
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationInputUIView = LocationInputUIView()
    private let locationManager = LocationHandler.shared.locationManager
    private var route: MKRoute?
    
    private var user: User? {
        didSet {
            locationInputUIView.user = user
            //if user?.accountType == .passenger {
                //fetchDrivers()
                //configureLocationInputActivationView()
                //observeCurrentTrip()
            //} else {
                //observeTrips()
            //}
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthenticated()
        enableLocationServices()
        view.backgroundColor = .white
    }
    
    // MARK: - Selectors
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    // MARK: - Helper Function
    
    func configController() {
        configUI()
        fetchUserData()
    }
    
    func configUI() {
        configNavBar()
        configMapView()
        //configureRideActionView()
        //view.addSubview(actionButton)
        //actionButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
        //                    paddingTop: 16, paddingLeft: 20, width: 30, height: 30)
        //configureTableView()
    }
    
    func configMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }

    func checkUserAuthenticated() {
        if(Auth.auth().currentUser?.uid == nil) {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: AuthViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configController()
        }
    }
    
}

// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view.image = #imageLiteral(resourceName: "chevron-sign-to-right")
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let route = self.route {
            let polyline = route.polyline
            let lineRenderer = MKPolylineRenderer(overlay: polyline)
            lineRenderer.strokeColor = .mainBlueTint
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer()
    }
}

// MARK: - LocationServices

extension HomeViewController {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
}
