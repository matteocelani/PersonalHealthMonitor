//
//  ReportSheet.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ReportSheet: View {
    
    @Binding var showSheet : Bool
    
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    var date = Date()
    
    @State var showEditSheet = false
    
    var body: some View {        
        for list in self.reports {
            if CompareDate(date: date, referenceDate: list.date ?? Date()) {
                return AnyView (
                    VStack {
                    Text("\(list.title!)")
                    Text("\(list.text!)")
                    Text(String(list.temperature))
                    Text(String(list.tempImportance))
                    Text(String(list.heartbeat))
                    Text(String(list.heartImportance))
                    Text(String(list.glycemia))
                    Text(String(list.glycemiaImportance))
                    Text(String(list.breath))
                    //Text(String(list.breathImportance))
                        Button(action: {
                                self.showEditSheet.toggle()
                            }) {
                                Text("Modifica Report")
                            }.sheet(isPresented: $showEditSheet) {
                                EditViewSheet(
                                    reports : self.reports,
                                    showEditSheet: self.$showEditSheet,
                                    title: list.title!,
                                    text: list.text ?? "",
                                    date: list.date!,
                                    temperature: String(list.temperature),
                                    heartbeat: String(list.heartbeat),
                                    glycemia: String(list.glycemia),
                                    breath: String(list.breath),
                                    tempImportance: list.tempImportance,
                                    heartImportance: list.heartImportance,
                                    glycemiaImportance: list.glycemiaImportance,
                                    breathImportance: list.breathImportance,
                                    id : list.id!)
                            }
                        }
                    )
                }
            }
        return AnyView(Text("Ops, qualcosa è andato storto"))
    }
    
    func CompareDate(date: Date, referenceDate: Date) -> Bool {
        return date == referenceDate
    }

    func deleteReport(at offsets : IndexSet) {
            for index in offsets {
                let report = reports[index]
                managedObjectContext.delete(report)
            }
        
        do {
         try self.managedObjectContext.save()
         print("Report Salvato.")
        } catch {
         print("Errore: \(error.localizedDescription)")
         }
        }
}
