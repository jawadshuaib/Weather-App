//
//  File.swift
//  Weather App
//
//  Created by Jawad Shuaib on 2016-10-23.
//  Copyright © 2016 Jawad Shuaib. All rights reserved.
//

//import Foundation

extension String {
    var stringByRemovingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined(separator: "")
    }
}
