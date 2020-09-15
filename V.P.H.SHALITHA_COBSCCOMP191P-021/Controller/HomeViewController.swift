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
    var safeArea: UILayoutGuide!
    
    private let mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let avatar = UIImageView()
        avatar.image = UIImage(named: "COVID19")
        tile.addSubview(avatar)
        avatar.anchor(left: tile.leftAnchor, paddingLeft: 36, width: 125, height: 125)
        avatar.centerY(inView: tile)
        
        let title = UILabel()
        title.text = "All you need is"
        title.font = UIFont(name: "Avenir-Medium", size: 26)
        tile.addSubview(title)
        title.anchor(top: avatar.topAnchor, left: avatar.rightAnchor, paddingLeft: 34)
        
        let subTitle = UILabel()
        subTitle.text = "stay at home"
        subTitle.font = UIFont(name: "Avenir-Black", size: 30)
        tile.addSubview(subTitle)
        subTitle.anchor(top: title.bottomAnchor, left: avatar.rightAnchor, paddingLeft: 34)
        
        let safeActions = UIButton()
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .small)
        safeActions.setTitle("Safe Actions ", for: .normal)
        safeActions.setTitleColor(.darkGray, for: .normal)
        safeActions.setImage(UIImage(systemName: "chevron.left", withConfiguration: imgConfig), for: .normal)
        safeActions.tintColor = .darkGray
        safeActions.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        safeActions.semanticContentAttribute = .forceRightToLeft
        safeActions.sizeToFit()
        safeActions.addTarget(self, action: #selector(showSafeActions), for: .touchUpInside)
        tile.addSubview(safeActions)
        safeActions.anchor(top: subTitle.bottomAnchor, left: avatar.rightAnchor, paddingTop: 15, paddingLeft: 34)
        
        return tile
    }()
    
    private let notificTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
        let bell = UIImageView()
        bell.image = UIImage(systemName: "bell")
        bell.tintColor = .systemYellow
        tile.addSubview(bell)
        bell.anchor(left: tile.leftAnchor, paddingLeft: 20, width: 32, height: 32)
        bell.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .darkGray
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 26)
        arrow.centerY(inView: tile)
        
        let title = UILabel()
        title.text = "NIBM is closed until further notice"
        tile.addSubview(title)
        title.anchor(top: tile.topAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12)
        
        let description = UILabel()
        description.text = "Get quick update about lecture schedule stay tune with LMS"
        description.font = UIFont(name: "Avenir-Medium", size: 12)
        description.textColor = .darkGray
        description.numberOfLines = 2
        tile.addSubview(description)
        description.anchor(top: title.bottomAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingLeft: 12, paddingRight: 12)
        
        tile.addTarget(self, action: #selector(showNotific), for: .touchUpInside)
        return tile
    }()
    
    private let caseTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let title = UILabel()
        title.text = "University Case Update"
        tile.addSubview(title)
        title.anchor(top: tile.topAnchor, left: tile.leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        let moreBtn = UIButton()
        moreBtn.setTitle("See More", for: .normal)
        moreBtn.setTitleColor(.systemBlue, for: .normal)
        moreBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        tile.addSubview(moreBtn)
        moreBtn.anchor(top: tile.topAnchor, right: tile.rightAnchor, paddingTop: 14, paddingRight: 16)
        
        let timeAgo = UILabel()
        timeAgo.text = "1 minute ago"
        timeAgo.font = UIFont(name: "Avenir-Medium", size: 11)
        timeAgo.textColor = .darkGray
        tile.addSubview(timeAgo)
        timeAgo.anchor(top: title.bottomAnchor, left: tile.leftAnchor, paddingLeft: 16)
        
        let infectedUI = UIView()
        
        let deathsUI = UIView()
        
        let recoveredUI = UIView()
        
        let yellowDot = UIImageView()
        yellowDot.image = UIImage(systemName: "smallcircle.fill.circle")
        yellowDot.tintColor = .systemYellow
        infectedUI.addSubview(yellowDot)
        yellowDot.anchor(top: infectedUI.topAnchor, paddingTop: 18)
        yellowDot.centerX(inView: infectedUI)

        let redDot = UIImageView()
        redDot.image = UIImage(systemName: "smallcircle.fill.circle")
        redDot.tintColor = .systemRed
        deathsUI.addSubview(redDot)
        redDot.anchor(top: deathsUI.topAnchor, paddingTop: 18)
        redDot.centerX(inView: deathsUI)

        let greenDot = UIImageView()
        greenDot.image = UIImage(systemName: "smallcircle.fill.circle")
        greenDot.tintColor = .systemGreen
        recoveredUI.addSubview(greenDot)
        greenDot.anchor(top: recoveredUI.topAnchor, paddingTop: 18)
        greenDot.centerX(inView: recoveredUI)

        let infectedCount = UILabel()
        infectedCount.text = "3"
        infectedCount.font = UIFont(name: "Avenir-Medium", size: 52)
        infectedUI.addSubview(infectedCount)
        infectedCount.anchor(top: yellowDot.bottomAnchor, paddingTop: 12)
        infectedCount.centerX(inView: infectedUI)

        let deathsCount = UILabel()
        deathsCount.text = "0"
        deathsCount.font = UIFont(name: "Avenir-Medium", size: 52)
        deathsUI.addSubview(deathsCount)
        deathsCount.anchor(top: redDot.bottomAnchor, paddingTop: 12)
        deathsCount.centerX(inView: deathsUI)

        let recoveredCount = UILabel()
        recoveredCount.text = "12"
        recoveredCount.font = UIFont(name: "Avenir-Medium", size: 52)
        recoveredUI.addSubview(recoveredCount)
        recoveredCount.anchor(top: greenDot.bottomAnchor, paddingTop: 12)
        recoveredCount.centerX(inView: recoveredUI)
        
        let infectedLbl = UILabel()
        infectedLbl.text = "Infected"
        infectedLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        infectedLbl.textColor = .darkGray
        infectedUI.addSubview(infectedLbl)
        infectedLbl.anchor(top: infectedCount.bottomAnchor)
        infectedLbl.centerX(inView: infectedUI)
        
        let deathsLbl = UILabel()
        deathsLbl.text = "Deaths"
        deathsLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        deathsLbl.textColor = .darkGray
        deathsUI.addSubview(deathsLbl)
        deathsLbl.anchor(top: deathsCount.bottomAnchor)
        deathsLbl.centerX(inView: deathsUI)
        
        let recoveredLbl = UILabel()
        recoveredLbl.text = "Recovered"
        recoveredLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        recoveredLbl.textColor = .darkGray
        recoveredUI.addSubview(recoveredLbl)
        recoveredLbl.anchor(top: recoveredCount.bottomAnchor)
        recoveredLbl.centerX(inView: recoveredUI)
        
        let countStack = UIStackView(arrangedSubviews: [infectedUI, deathsUI, recoveredUI])
        countStack.axis = .horizontal
        countStack.distribution = .fillEqually
        countStack.spacing = 0
        tile.addSubview(countStack)
        countStack.anchor(top: timeAgo.bottomAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor)
        
        
        return tile
    }()
    
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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        checkUserAuthenticated()
        enableLocationServices()
    }
    
    // MARK: - Selectors
    
    @objc func showNotific() {
        print("notific")
//        let vc = SafeActionsViewController()
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showSafeActions() {
        let vc = SafeActionsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helper Function
    
    func configController() {
        configUI()
        fetchUserData()
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray6
        view.addSubview(mainTile)
        mainTile.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 30 * view.bounds.height/100)
        view.addSubview(notificTile)
        notificTile.anchor(top: mainTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        view.addSubview(caseTile)
        caseTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, height: 25 * view.bounds.height/100)
        //configMapView()
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
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
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
