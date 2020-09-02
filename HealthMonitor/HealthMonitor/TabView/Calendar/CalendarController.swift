//
//  CalendarController.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct CalendarController: View {
    
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @ObservedObject var CalendarManager: CalendarManager
    
    
    var body: some View {
            List {
                ForEach(0..<numberOfMonths()) { index in
                    CalendarMonth(reports: self.reports, CalendarManager: self.CalendarManager, monthOffset: index)
                }
            }
    }
    
    func numberOfMonths() -> Int {
        return CalendarManager.calendar.dateComponents([.month], from: CalendarManager.minimumDate, to: MaximumDateMonthLastDay()).month! + 1
    }
    
    func MaximumDateMonthLastDay() -> Date {
        var components = CalendarManager.calendar.dateComponents([.year, .month, .day], from: CalendarManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return CalendarManager.calendar.date(from: components)!
    }
}
