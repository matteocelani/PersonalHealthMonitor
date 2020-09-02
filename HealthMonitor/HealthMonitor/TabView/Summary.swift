//
//  Summary.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct Summary: View {
    
    @FetchRequest(
        entity: Report.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Report.date, ascending: false)]
    )
    var reports: FetchedResults<Report>
    
    var body: some View {
        NavigationView {
            if (self.reports.isEmpty){
                LineChartView(data: [40,41,39,39,38,37,37,37,36], title: "Title", legend: "Legendary")
            } else {
            HStack {
                VStack {
                    Text("\(reports.first!.title!)")
                    Text("\(reports.first!.text!)")
                    Text(String(reports.first!.temperature))
                    Text(String(reports.first!.tempImportance))
                    Text(String(reports.first!.heartbeat))
                    Text(String(reports.first!.heartImportance))
                    Text(String(reports.first!.glycemia))
                    Text(String(reports.first!.glycemiaImportance))
                    Text(String(reports.first!.breath))
                    Text(String(reports.first!.breathImportance))
                }
            }
            }
//            LineChartView(data: [40,41,39,39,38,37,37,37,36], title: "Title", legend: "Legendary")
        }
        .navigationBarTitle(Text("Sommario"))
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
