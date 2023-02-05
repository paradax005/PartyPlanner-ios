//
//  User.swift
//  partyPlaner
//
//  Created by iMac on 26/4/2022.
//

import Foundation
struct User: Codable {
    var id : String
    var name, email: String
    var age: Int
    var phone : String
    //var token : String
    init(id: String , name: String, age: Int, email: String, phone: String){
        self.id = id
        self.name = name
        self.age = age
        self.email = email
        self.phone = phone
    }
    
    func toJson(user : User ) -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(user)
        return jsonData
    }
    
}
