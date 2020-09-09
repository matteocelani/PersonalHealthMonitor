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
    @FetchRequest(entity: Report.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Report.date, ascending: false)])
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
    
    @State var showSheet = false
    @State var avgImportance = 1
    @State var showFilter = false
    
    private func filterReport() -> [FetchedResults<Report>.Element] {
        return self.reports.filter({
            avgImp(tempImp: $0.tempImportance, heartImp: $0.heartImportance, glyImp: $0.glycemiaImportance, breImpo: $0.breathImportance) >= self.avgImportance
        })
    }
    
    func avgImp(tempImp: Int16, heartImp: Int16, glyImp: Int16, breImpo: Int16) -> Int16 {
        let avgImp : Int16 = (tempImp + heartImp + glyImp + breImpo)/4
        return avgImp
    }
    
    var body: some View {
        List{
            VStack {
                Toggle(isOn: $showFilter){
                    Text("Attiva filtri")
                }
            }
            
            if showFilter {
                VStack(alignment: .leading) {
                    Text("Importanza").font(.headline)
                    Text("Solo elementi che hanno una media di importanza:").font(.subheadline)
                    Picker(selection: $avgImportance, label: Text("Determinare un importanza")) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                    }.pickerStyle(SegmentedPickerStyle())
                    Divider()
                }
                ForEach(filterReport(), id: \.id) { report in
                    VStack{
                        HStack {
                            NavigationLink(destination: ReportView(report: report, date: report.date!, showSheet: self.$showSheet, reports: self.reports).environment(\.managedObjectContext, self.managedObjectContext)) {
                                ListReportDetail(report: report, date: report.date!)
                            }
                        }
                        Divider()
                    }
                }.onDelete(perform: self.deleteReport)
            } else {
                ForEach(reports, id: \.id) { report in
                    VStack{
                        HStack {
                            
                            NavigationLink(destination: ReportView(report: report, date: report.date!, showSheet: self.$showSheet, reports: self.reports).environment(\.managedObjectContext, self.managedObjectContext)) {
                                ListReportDetail(report: report, date: report.date!)
                            }
                        }
                        Divider()
                    }
                }.onDelete(perform: self.deleteReport)
            }
        }
        .navigationBarTitle("Tutti i report")
    }
    
}

struct ListReportDetail: View {
    var report : Report
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date = Date()
    
    var body: some View {
        Group{
            VStack(alignment: .leading) {
                Text(report.title!)
                    .font(.headline)
                Text("\(date, formatter: dateFormatter)")
                    .font(.subheadline)
            }
        }
        .frame(height: 50.0)
    }
}
