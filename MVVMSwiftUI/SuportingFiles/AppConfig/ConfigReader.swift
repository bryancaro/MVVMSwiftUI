//
//  ConfigReader.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

class ConfigReader: NSObject {
    static func baseUrl() -> String {
        valueFromPlist("baseUrlWeb")!
    }
    
    static func environment() -> String {
        valueFromPlist("environment")!
    }
    
    static func userKey() -> String {
        valueFromPlist("userKey")!
    }
    
    static func passKey() -> String {
        valueFromPlist("passKey")!
    }
    
    static func actualVersion() -> String {
        valueFromPlist("version")!
    }
    
    static func actualBuild() -> String {
        valueFromPlist("build")!
    }
    
    static func valueFromPlist(_ key: String) -> String? {
        guard let dictionary = ConfigurationManager().readConfiguration() else { return nil }
        return dictionary[key]
    }
}
