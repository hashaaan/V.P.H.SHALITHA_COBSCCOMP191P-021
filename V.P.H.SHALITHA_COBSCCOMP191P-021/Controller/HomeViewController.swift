//
//  HomeViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 8/25/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationInputUIView = LocationInputUIView()
    private let locationManager = LocationHandler.shared.locationManager
    private var route: MKRoute?
    var safeArea: UILayoutGuide!
    
    private var user: User? {
        didSet {
            locationInputUIView.user = user
            //ProfileViewController.user = user
            //if user?.accountType == .passenger {
            fetchOtherUsers()
                //configureLocationInputActivationView()
                //observeCurrentTrip()
            //} else {
                //observeTrips()
            //}
            
        }
    }
    
    private let mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let avatar = UIImageView()
        avatar.image = UIImage(named: "COVID19")
        tile.addSubview(avatar)
        avatar.anchor(left: tile.leftAnchor, paddingLeft: 30, width: 125, height: 125)
        avatar.centerY(inView: tile)
        
        let title = UILabel()
        title.text = "All you need is"
        title.font = UIFont(name: "Avenir-Medium", size: 26)
        title.adjustsFontSizeToFitWidth = true
        tile.addSubview(title)
        title.anchor(top: avatar.topAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingLeft: 30, paddingRight: 16)
        
        let subTitle = UILabel()
        subTitle.text = "stay at home"
        subTitle.font = UIFont(name: "Avenir-Black", size: 30)
        subTitle.adjustsFontSizeToFitWidth = true
        tile.addSubview(subTitle)
        subTitle.anchor(top: title.bottomAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingLeft: 30, paddingRight: 16)
        
        let safeActions = UIButton()
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .small)
        safeActions.setTitle("Safe Actions ", for: .normal)
        safeActions.setTitleColor(.darkGray, for: .normal)
        safeActions.setImage(UIImage(systemName: "chevron.left", withConfiguration: imgConfig), for: .normal)
        safeActions.tintColor = .darkGray
        safeActions.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        safeActions.semanticContentAttribute = .forceRightToLeft
        safeActions.sizeToFit()
        safeActions.contentHorizontalAlignment = .left
        safeActions.addTarget(self, action: #selector(showSafeActions), for: .touchUpInside)
        tile.addSubview(safeActions)
        safeActions.anchor(top: subTitle.bottomAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingRight: 16)
        
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
        title.adjustsFontSizeToFitWidth = true
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
        moreBtn.addTarget(self, action: #selector(showFullMap), for: .touchUpInside)
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
        infectedCount.font = UIFont(name: "Avenir-Medium", size: 48)
        infectedUI.addSubview(infectedCount)
        infectedCount.anchor(top: yellowDot.bottomAnchor, paddingTop: 12)
        infectedCount.centerX(inView: infectedUI)

        let deathsCount = UILabel()
        deathsCount.text = "0"
        deathsCount.font = UIFont(name: "Avenir-Medium", size: 48)
        deathsUI.addSubview(deathsCount)
        deathsCount.anchor(top: redDot.bottomAnchor, paddingTop: 12)
        deathsCount.centerX(inView: deathsUI)

        let recoveredCount = UILabel()
        recoveredCount.text = "12"
        recoveredCount.font = UIFont(name: "Avenir-Medium", size: 48)
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
    
    private let mapTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        return tile
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: 0.84 * screensize.height)
        sv.translatesAutoresizingMaskIntoConstraints = false
        //sv.backgroundColor = .cyan
        return sv
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        checkUserAuthenticated()
        enableLocationServices()
    }
    
    // MARK: - Selectors
    
    @objc func showNotific() {
        let vc = NotificationsVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showFullMap() {
        let vc = FullMapViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showSafeActions() {
        let vc = SafeActionsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    func fetchOtherUsers() {
        guard let location = locationManager?.location else { return }
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
            
            var usersVisible: Bool {
                
                return self.mapView.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }
                    
                    if userAnno.uid == user.uid {
                        userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    
                    return false
                }
            }
            
            if !usersVisible {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    // MARK: - Helper Function
    
    func configController() {
        configUI()
        fetchUserData()
        fetchOtherUsers()
    }
    
    func configUI() {
        
        let screensize: CGRect = UIScreen.main.bounds
        
        configNavBar()
        view.backgroundColor = .systemGray6
        view.addSubview(mainTile)
        mainTile.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 0.26 * screensize.height)
        view.addSubview(scrollView)
        scrollView.anchor(top: mainTile.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 1.0, paddingLeft: 1.0, paddingBottom: -1.0, paddingRight: -1.0)
        scrollView.addSubview(notificTile)
        notificTile.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        scrollView.addSubview(caseTile)
        caseTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, height: 220)
        scrollView.addSubview(mapTile)
        mapTile.anchor(top: caseTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 270)
        configMapView()
        //configureRideActionView()
        //view.addSubview(actionButton)
        //actionButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
        //                    paddingTop: 16, paddingLeft: 20, width: 30, height: 30)
        //configureTableView()
    }
    
    func configMapView() {
        mapTile.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 250)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(UserAnnotation.self))
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
            let identifier = NSStringFromClass(UserAnnotation.self)
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
            if let markerAnnotationView = view as? MKMarkerAnnotationView {
                markerAnnotationView.animatesWhenAdded = true
                markerAnnotationView.canShowCallout = false
                markerAnnotationView.markerTintColor = .red
            }
            return view
        }
        return nil
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

extension MKAnnotationView {

    public func set(image: UIImage, with color : UIColor) {
        let view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        view.tintColor = color
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: graphicsContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
    
}
