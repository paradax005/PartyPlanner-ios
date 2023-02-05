//
//  Event.swift
//  partyPlaner
//
//  Created by iMac on 26/4/2022.
//

import Foundation
struct Event: Codable {
    let eventTitle, venue: String
    let maxParticipant: Int
    let date, time, email: String

    enum CodingKeys: String, CodingKey {
        case eventTitle = "event_title"
        case venue, maxParticipant, date, time, email
    }
    init(eventTitle: String ,venue: String, maxParticipant: Int ,date: String, time: String,  email: String ){
        self.eventTitle = eventTitle
        self.venue = venue
        self.maxParticipant = maxParticipant
        self.time = time
        self.date = date
        self.email = email
    }
    func toJson(event : Event ) -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(event)
        return jsonData
    }
}

