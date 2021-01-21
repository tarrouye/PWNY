//
//  Utils.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation
import CommonCrypto

// Date stuff

let defaultDate = Date(timeIntervalSince1970: 0)

func dateFromISOString(_ str : String?) -> Date? {
    if let str = str {
        // try iso formatter first
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: str) {
            return date
        }
        
        // fallback to try yyyy-MM-dd for breach date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: str) {
            return date
        }
    }
    
    return nil
}

func prettyLongDate(_ date_may : Date?) -> String {
    if let date = date_may {
        let formatter2 = DateFormatter()
        let formatter3 = DateFormatter()
        formatter2.dateFormat = "d MMM, y"
        formatter3.dateFormat = "HH:mm a"
        
        return formatter2.string(from: date) + " at " + formatter3.string(from: date)
    }
    
    return "Date Unknown"
}

func prettyShortDate(_ date_mayb : Date?) -> String {
    if let date = date_mayb {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "d MMM, y"
        return formatter2.string(from: date)
    }
    
    return "Date Unknown"
}

func prettyNumber(_ num : Int?) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    if let count = num {
        return numberFormatter.string(from: NSNumber(value: count)) ?? "Unknown number of"
    } else {
        return "Unknown number of"
    }
}


// Crypto stuff

extension Data {

    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    var sha1 : Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA1_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(self.count), &hash)
        }
        return Data(hash)
    }

}

extension String {

    var hexString: String {
        return self.data(using: .utf8)!.hexString
    }

    var sha1: Data {
        return self.data(using: .utf8)!.sha1
    }

}


// 
