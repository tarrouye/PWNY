//
//  Paste.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

class Paste : Codable, Identifiable {
    var source : String
    var id : String
    var title : String?
    var date : Date?
    var emailCount : Int?
    var prettyDate : String? = nil
    var resolvedURLString : String? = nil
    var prettyEmailCount : String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case title = "Title"
        case id = "Id"
        case date = "Date"
        case emailCount = "EmailCount"
        case prettyDate = "PrettyDate"
        case resolvedURLString = "ResolvedURLString"
        case prettyEmailCount = "PrettyEmailCount"
    }
    
    init(source: String, id : String, title : String?, dateStr : String?, emailCount: Int?) {
        self.source = source
        self.id = id
        self.title = title
        self.date = dateFromISOString(dateStr) ?? defaultDate
        self.emailCount = emailCount
        
        self.prettyDate = prettyLongDate(self.date)
        self.prettyEmailCount = prettyNumber(self.emailCount)
        self.resolvedURLString = resolveURLString()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.source = try container.decode(String.self, forKey: .source)
        self.title = try container.decode(String?.self, forKey: .title)
        let dateStr = try container.decode(String?.self, forKey: .date)
        self.date = dateFromISOString(dateStr) ?? defaultDate
        self.emailCount = try container.decode(Int?.self, forKey: .emailCount)
        
        self.prettyDate = prettyLongDate(self.date)
        self.prettyEmailCount = prettyNumber(self.emailCount)
        self.resolvedURLString = resolveURLString()
    }
    
    func resolveURLString() -> String? {
        // Sources: Pastebin, Pastie, Slexy, Ghostbin, QuickLeak, JustPaste, AdHocUrl, PermanentOptOut, OptOut
        switch(self.source) {
            case "Pastebin":
                return "https://pastebin.com/raw/\(self.id)"
                
            case "Pastie":
                return ""
                
            case "Slexy":
                return ""
                
            case "Ghostbin":
                return ""
                
            case "QuickLeak":
                return ""
                
            case "JustPaste":
                return ""
                
            case "AdHocUrl":
                return self.id
                
            case "PermanentOptOut":
                return ""
                
            case "OptOut":
                return ""
                
            default:
                return nil
        }
    }
}
