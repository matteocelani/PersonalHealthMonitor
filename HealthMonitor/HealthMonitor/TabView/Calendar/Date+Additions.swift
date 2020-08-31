//
//  Date+Additions.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 30/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import Foundation

extension Date {
    
    static func startFrom() -> Date {
        let start = DateFormatter()
        start.dateFormat = "yyyy/MM/dd"
        return start.date(from: "2018/12/31")!
    }

    static func endFrom() -> Date {
        let end = DateFormatter()
        end.dateFormat = "yyyy/MM/dd"
        return end.date(from: "2022/01/01")!
    }

}

extension Date {

    var fullDate: String {
        DateFormatter.fullDate.string(from: self)
    }

    var timeOnlyWithPadding: String {
        DateFormatter.timeOnlyWithPadding.string(from: self)
    }

}

extension DateFormatter {

    static var fullDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }

    static let timeOnlyWithPadding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

}
