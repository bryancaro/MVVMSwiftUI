//
//  ConfigurationManager.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

class ConfigurationManager {
    func readConfiguration() -> [String: String]? {
        if let enviroment = Bundle.main.infoDictionary?["Configurations"] as? String {
            guard let pathOfPlist = Bundle.main.path(forResource: "Configuration\(enviroment)", ofType: "plist") else { return nil }
            
            let url = URL(fileURLWithPath: pathOfPlist)
            let data = try! Data(contentsOf: url)
            
            guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] else { return nil }
            return plist
        }
        return nil
    }
}
