//
//  User.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/2/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import CoreLocation

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let role: String
    var location: CLLocation?
    let uid: String
    let temperature: String
    var surveyResult: Int
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.role = dictionary["role"] as? String ?? ""
        self.temperature = dictionary["temperature"] as? String ?? "0"
        self.surveyResult = dictionary["surveyResult"] as? Int ?? 0
    }
}
