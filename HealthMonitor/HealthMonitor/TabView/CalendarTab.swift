//
//  Calendar.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine
import Foundation


struct CalendarTab: View {
    
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    static func startFrom() -> Date {
        let start = DateFormatter()
        start.dateFormat = "yyyy/MM/dd"
        return start.date(from: "2020/01/01")!
    }
    
    static func endFrom() -> Date {
        let end = DateFormatter()
        end.dateFormat = "yyyy/MM/dd"
        return end.date(from: "2021/12/31")!
    }
    
    var CalManager = CalendarManager(calendar: Calendar.current, minimumDate: startFrom(), maximumDate: endFrom(), mode: 0)
    
    var body: some View {
        NavigationView {
            
            CalendarController(reports: self.reports, CalendarManager: self.CalManager)
                
                .navigationBarTitle(Text("Calendario"))
        }
    }
    
}
