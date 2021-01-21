//
//  Breach.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

class Breach: Codable, Identifiable {
    let name, modifiedDateStr : String
    let title, domain, description: String?
    let breachDateStr, addedDateStr : String?
    let pwnCount : Int?
    let dataClasses : [String]?
    let isVerified, isFabricated, isSensitive, isRetired, isSpamList : Bool?
    let logoPath : URL?
    
    let modifiedDate, breachDate, addedDate: Date?
    
    let prettyPwnCount, prettyAddedDate, prettyModifiedDate, prettyBreachDate : String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDateStr = "BreachDate"
        case addedDateStr = "AddedDate"
        case modifiedDateStr = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case logoPath = "LogoPath"
        case dataClasses = "DataClasses"
        case isVerified = "IsVerified"
        case isFabricated = "IsFabricated"
        case isSensitive = "IsSensitive"
        case isRetired = "IsRetired"
        case isSpamList = "IsSpamList"
        case modifiedDate = "ModifiedDateObj"
        case addedDate = "AddedDateObj"
        case breachDate = "BreachDateObj"
        case prettyPwnCount = "PrettyPwnCount"
        case prettyAddedDate = "PrettyAddedDate"
        case prettyModifiedDate = "PrettyModifiedDate"
        case prettyBreachDate = "PrettyBreachDate"
    }

    init(name: String, title : String? = nil, domain : String? = nil, breachDate : String? = nil, addedDate : String? = nil, modifiedDate : String, pwnCount : Int? = nil, description : String? = nil, logoPath : URL? = nil, dataClasses : [String]? = nil, isVerified : Bool? = nil, isFabricated : Bool? = nil, isSensitive : Bool? = nil, isRetired : Bool? = nil, isSpamList : Bool? = nil, logoURL : URL? = nil) {
        self.name = name
        self.title = title
        self.domain = domain
        self.breachDateStr = breachDate
        self.addedDateStr = addedDate
        self.modifiedDateStr = modifiedDate
        self.pwnCount = pwnCount
        self.description = description
        self.logoPath = logoPath
        self.dataClasses = dataClasses
        self.isVerified = isVerified
        self.isFabricated = isFabricated
        self.isSensitive = isSensitive
        self.isRetired = isRetired
        self.isSpamList = isSpamList
        self.breachDate = dateFromISOString(breachDate)
        self.addedDate = dateFromISOString(addedDate)
        self.modifiedDate = dateFromISOString(modifiedDate)
        
        self.prettyPwnCount = prettyNumber(self.pwnCount)
        self.prettyAddedDate = prettyLongDate(self.addedDate)
        self.prettyModifiedDate = prettyLongDate(self.modifiedDate)
        self.prettyBreachDate = prettyShortDate(self.breachDate)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.title = try container.decode(String?.self, forKey: .title)
        self.domain = try container.decode(String?.self, forKey: .domain)
        let breachDateStr = try container.decode(String?.self, forKey: .breachDateStr)
        self.breachDateStr = breachDateStr
        self.breachDate = dateFromISOString(breachDateStr)
        let addedDateStr = try container.decode(String?.self, forKey: .addedDateStr)
        self.addedDateStr = addedDateStr
        self.addedDate = dateFromISOString(addedDateStr)
        let modifiedDateStr = try container.decode(String.self, forKey: .modifiedDateStr)
        self.modifiedDateStr = modifiedDateStr
        self.modifiedDate = dateFromISOString(modifiedDateStr)
        self.pwnCount = try container.decode(Int?.self, forKey: .pwnCount)
        self.description = try container.decode(String?.self, forKey: .description)
        self.logoPath = try container.decode(URL?.self, forKey: .logoPath)
        self.dataClasses = try container.decode([String]?.self, forKey: .dataClasses)
        self.isVerified = try container.decode(Bool?.self, forKey: .isVerified)
        self.isFabricated = try container.decode(Bool?.self, forKey: .isFabricated)
        self.isSensitive = try container.decode(Bool?.self, forKey: .isSensitive)
        self.isRetired = try container.decode(Bool?.self, forKey: .isRetired)
        self.isSpamList = try container.decode(Bool?.self, forKey: .isSpamList)
        
        self.prettyPwnCount = prettyNumber(self.pwnCount)
        self.prettyAddedDate = prettyLongDate(self.addedDate)
        self.prettyModifiedDate = prettyLongDate(self.modifiedDate)
        self.prettyBreachDate = prettyShortDate(self.breachDate)
    }
}

