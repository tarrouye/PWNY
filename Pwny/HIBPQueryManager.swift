//
//  HIBPQueryManager.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

enum QueryError: Error {
    case url
    case input
    case input_need_email
    case network
    case decode
}

struct NetworkStatus : Codable {
    var statusCode : Int
    var message : String
}

class HIBPQueryManager {
    static let shared = HIBPQueryManager()
    
    private let user_agent = "Pwny iOS"
    private let api_key = API_KEY

    /*
     GET https://haveibeenpwned.com/api/v3/breachedaccount/{account}
     hibp-api-key: [your key]
     Parameter           Example                    Description
     truncateResponse    ?truncateResponse=false    Returns the full breach model.
     domain              ?domain=adobe.com          Filters the result set to only breaches against the domain specified. It is possible that one site (and consequently domain), is compromised on multiple occasions.
    */
    
    func getAllBreachesForAccount(_ account : String, _ completionHandler : @escaping (QueryError?) -> ()) {
        // check cache first
        if BreachCache.shared.get(forKey: account) != nil {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            
            return
        }
        
        // else load from API
        if let stripped = account.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            let urlString = "https://haveibeenpwned.com/api/v3/breachedaccount/\(stripped)"
            
            var urlBuilder = URLComponents(string: urlString)
            urlBuilder?.queryItems = [
                URLQueryItem(name: "truncateResponse", value: "false")
            ]

            guard let url = urlBuilder?.url else {
                completionHandler(QueryError.url)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(user_agent, forHTTPHeaderField: "user-agent")
            request.setValue(api_key, forHTTPHeaderField: "hibp-api-key")


            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    // handle error
                    completionHandler(QueryError.network)
                    return
                } else {
                    if (data != nil) {
                        // Serialize the data into an object
                        do {
                            let breaches = try JSONDecoder().decode([Breach].self, from: data! )
                            
                            DispatchQueue.main.async {
                                BreachCache.shared.set(breaches, forKey: account)
                            
                                completionHandler(nil)
                            }
                        } catch {
                            if let str = String(data: data!, encoding: .utf8), str.isEmpty {
                                DispatchQueue.main.async {
                                    BreachCache.shared.set([], forKey: account)
                                    completionHandler(nil)
                                }
                            } else {
                                do {
                                    let status = try JSONDecoder().decode(NetworkStatus.self, from: data! )
                                    if (status.statusCode == 404) {
                                        completionHandler(QueryError.input)
                                    } else {
                                        completionHandler(QueryError.network)
                                    }
                                } catch {
                                    completionHandler(QueryError.decode)
                                }
                            }
                        }
                    }
                }
                
            }.resume()
        } else {
            completionHandler(QueryError.input)
        }
    }
    
    func getAllPastesForAccount(_ account : String, _ completionHandler : @escaping (QueryError?) -> ()) {
        // check cache first
        if PasteCache.shared.get(forKey: account) != nil {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            
            return
        }
        
        // else load from API
        if let stripped = account.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            let urlString = "https://haveibeenpwned.com/api/v3/pasteaccount/\(stripped)"
            
            guard let url = URL(string: urlString) else {
                completionHandler(QueryError.url)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(user_agent, forHTTPHeaderField: "user-agent")
            request.setValue(api_key, forHTTPHeaderField: "hibp-api-key")


            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    // handle error
                    completionHandler(QueryError.network)
                    return
                } else {
                    if (data != nil) {
                        // Serialize the data into an object
                        do {
                            let pastes = try JSONDecoder().decode([Paste].self, from: data! )
                            
                            DispatchQueue.main.async {
                                PasteCache.shared.set(pastes, forKey: account)
                            
                                completionHandler(nil)
                            }
                        } catch {
                            if let str = String(data: data!, encoding: .utf8) {
                                if (str.isEmpty) {
                                    DispatchQueue.main.async {
                                        PasteCache.shared.set([], forKey: account)
                                        completionHandler(nil)
                                    }
                                } else if (str == "\"Invalid email address\"") {
                                    completionHandler(QueryError.input_need_email)
                                }
                            } else {
                                do {
                                    let status = try JSONDecoder().decode(NetworkStatus.self, from: data! )
                                    if (status.statusCode == 404) {
                                        completionHandler(QueryError.input)
                                    } else {
                                        completionHandler(QueryError.network)
                                    }
                                } catch {
                                    completionHandler(QueryError.decode)
                                }
                            }
                        }
                    }
                }
                
            }.resume()
        } else {
            completionHandler(QueryError.input)
        }
    }
    
    func checkPwnedPassword(_ pass : String, _ completionHandler : @escaping (QueryError?, String, Int) -> ()) {
        // (1) Hash password with SHA-1
        let sha = pass.sha1.hexString.uppercased()
        
        // (2) Get first 5 prefix
        let prefix = sha.prefix(5)
        let suffix = sha.suffix(sha.count - 5)
        
        // (3) Search API for prefix
        if let url = URL(string: "https://api.pwnedpasswords.com/range/\(prefix)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    // handle error
                    completionHandler(QueryError.network, String(prefix), 0)
                    return
                } else {
                    if (data != nil) {
                        // (4) When a password hash with the same first 5 characters is found in the Pwned Passwords repository, the API will respond with an HTTP 200 and include the suffix of every hash beginning with the specified prefix, followed by a count of how many times it appears in the data set. The API consumer can then search the results of the response for the presence of their source hash and if not found, the password does not exist in the data set.
                        
                        if let data_str = String(data: data!, encoding: .utf8) {
                            let lines = data_str.split(separator: "\r\n")
                            
                            for line in lines {
                                let pieces = line.split(separator: ":")
                                // pieces[0] will be hash suffix, pieces[1] will be count
                                if (suffix.compare(pieces[0]) == .orderedSame) {
                                    // found the users password in the database
                                    DispatchQueue.main.async {
                                        completionHandler(nil, String(prefix), Int(pieces[1]) ?? 0)
                                    }
                                    return
                                }
                            }
                            
                            // we went through the data and the password wasnt found
                            DispatchQueue.main.async {
                                completionHandler(nil, String(prefix), 0)
                            }
                        } else {
                            do {
                                let status = try JSONDecoder().decode(NetworkStatus.self, from: data! )
                                print(status.statusCode)
                                print(status.message)
                                
                                if (status.statusCode == 404) {
                                    completionHandler(QueryError.input, String(prefix), 0)
                                } else {
                                    completionHandler(QueryError.network, String(prefix), 0)
                                }
                            } catch {
                                completionHandler(QueryError.decode, String(prefix), 0)
                            }
                        }
                    }
                }
                
            }.resume()
        } else {
            completionHandler(QueryError.url, String(prefix), 0)
        }
    }
    
    func getAllBreachInfo(_ completionHandler : @escaping (QueryError?) -> ()) {
        // check cache first
        if BreachCache.shared.get(forKey: "all") != nil {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            
            return
        }
        
        // else load from API
        if let url = URL(string: "https://haveibeenpwned.com/api/v3/breaches") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completionHandler(QueryError.network)
                    return
                } else {
                    if (data != nil) {
                        // Serialize the data into an object
                        do {
                            let breaches = try JSONDecoder().decode([Breach].self, from: data! )
                            
                            DispatchQueue.main.async {
                                BreachCache.shared.set(breaches, forKey: "all")
                            
                                completionHandler(nil)
                            }
                        } catch {
                            completionHandler(QueryError.decode)
                        }
                    }
                }
                
            }.resume()
        } else {
            completionHandler(QueryError.url)
        }
    }
}
