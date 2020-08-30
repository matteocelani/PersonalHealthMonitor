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
import ElegantCalendar


struct CalendarTab: View {
    
    var body: some View {
        NavigationView {
//            Color.blue
            CalendarView(
            ascVisits: Visit.mocks(
                start: .daysFromToday(-20*36),
                end: .daysFromToday(55*36)),
            initialMonth: Date())
            
            .navigationBarTitle(Text("Calendario"))
        }
    }
}

/*struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}*/
