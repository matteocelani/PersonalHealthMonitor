//
//  Calendar.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Foundation
import ElegantCalendar


struct CalendarView: View {
    
//    let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
//      let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))

//    @ObservedObject var calendarManager = YearlyCalendarManager(
//        configuration: CalendarConfiguration(startDate: startDate,
//                                             endDate: endDate))
    
    var body: some View {
        NavigationView {
            Color.blue
//            YearlyCalendarView(calendarManager: calendarManager)
            
            .navigationBarTitle(Text("Calendario"))
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
