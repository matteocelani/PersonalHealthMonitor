//
//  AllReport.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 05/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct AllReport: View {
    
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Report.entity(), sortDescriptors: [])
    var reports: FetchedResults<Report>
    
    func deleteReport(at offsets : IndexSet) {
            for index in offsets {
                let report = reports[index]
                managedObjectContext.delete(report)
            }
        
        do {
         try self.managedObjectContext.save()
         print("Report Eliminato.")
        } catch {
         print("Errore: \(error.localizedDescription)")
         }
        }
    
    @State var showFilterSheet = false
    
    var body: some View {
        List{
            ForEach(reports, id: \.id) { report in
                VStack{
                    HStack {
                        NavigationLink(destination: AllReport()) {
                            ListReportDetail(report: report, date: report.date!)
                        }
                    }
                    Divider()
                }
            }.onDelete(perform: self.deleteReport)
        }
        .sheet(isPresented: $showFilterSheet) {
        FilterSheet()
                        }
        .navigationBarTitle("Tutti i report")
        .navigationBarItems(trailing: Button(action: {
            self.showFilterSheet = true
        }) {
            Text("Filtri").bold()
        })
    }
}
