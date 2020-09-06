//
//  ContentView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 21/06/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    //    MARK: -CoreData Setup
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Report.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Report.date, ascending: false)]
    ) var reports: FetchedResults<Report>
    
    var body: some View {

            TabView {
               Summary()
                 .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Riepilogo")
                  }
                
                CalendarTab(reports: self.reports)
                .tabItem {
                   Image(systemName: "calendar")
                   Text("Calendario")
                }
                
                AddReport(reports: reports)
                .tabItem {
                   Image(systemName: "plus")
                   Text("Nuovo")
                }
                
        }
    }
}
