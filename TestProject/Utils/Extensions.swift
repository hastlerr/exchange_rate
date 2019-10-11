//
//  Extensions.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

extension UITableViewCell{
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    class func createVC<T: UIViewController>(storyboard: AppStoryboard, controllerType: T.Type) -> T {
        let st = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: controllerType.className) as! T
        return vc
    }
}

extension UIViewController {
   class var storyboardID : String {
     return String(describing: self)
   }
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

public extension UserDefaults {
    func set<T: Codable>(object: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(object)

        set(jsonData, forKey: forKey)
    }

    func gets<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
}
