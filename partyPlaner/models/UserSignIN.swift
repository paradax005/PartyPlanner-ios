//
//  UserSignIN.swift
//  partyPlaner
//
//  Created by iMac on 26/4/2022.

import Foundation
struct UserSignIn : Codable {
    var name, email: String?
    var age: Int?
    var phone : String?
    var password: String?
    var id: String?
    init(id: String ,name: String , email: String , age: Int , phone: String ,password: String){
        self.name = name
        self.email = email
        self.age = age
        self.phone = phone
        self.password = password
        self.id = id
    }
    init(name: String , email: String , age: Int , phone: String ,password: String){
        self.name = name
        self.email = email
        self.age = age
        self.phone = phone
        self.password = password
        self.id = nil
    }
    init(id: String , password: String){
        self.id = id
        self.password = password
        self.name = nil
        self.email = nil
        self.age = nil
        self.phone = nil
    }
    func toJson(usersignIn : UserSignIn ) -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(usersignIn)
        return jsonData
    }
    
}
