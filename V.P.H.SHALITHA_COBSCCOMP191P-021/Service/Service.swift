//
//  Service.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/2/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

//import Firebase
import FirebaseDatabase
import CoreLocation
import GeoFire

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_USER_LOCATIONS = DB_REF.child("user-locations")
let REF_NOTIFICATIONS = DB_REF.child("notifications")

// MARK: - SharedService

struct Service {
    static let shared = Service()
    
    func fetchUserData(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchUsersLocation(location: CLLocation, completion: @escaping(User) -> Void) {
        let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
        
        REF_USER_LOCATIONS.observe(.value) { (snapshot) in
            geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
                self.fetchUserData(uid: uid) { (user) in
                    var newUser = user
                    newUser.location = location
                    completion(newUser)
                }
            })
        }
    }
    
    func fetchNotifications(uid: String, completion: @escaping(User) -> Void) {
        REF_NOTIFICATIONS.observe(.value) { (snapshot) in
            print(snapshot.key)
        }
    }
}
