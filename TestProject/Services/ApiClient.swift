//
//  ApiClient.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class ApiClient: NSObject {
    
    public static let shared = ApiClient()
    private override init() {}
    private let base_url = Constants.BASE_URL
    
    func requestRate(base: String, rate: String,  completion: @escaping (Result<CGFloat, Error>) -> ()) {
        guard let url = URL(string: base_url + "latest?base=\(base)&symbols=\(rate)") else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let rates = json["rates"] as? [String: Any]{
                        if let rateValue = rates.first?.value as? CGFloat{
                            completion(.success(rateValue))
                        }
                    }
                }
            } catch let jsonError{
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
    
}
