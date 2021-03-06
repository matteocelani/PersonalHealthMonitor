//
//  ReportSheet.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Foundation

struct ReportSheet: View {
    @Binding var showSheet : Bool
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    var date = Date()
    
    @State var showEditSheet = false
    
    func deleteReport(reports: Report) {
        for report in self.reports {
            if (report.id == reports.id) {
                managedObjectContext.delete(report)
            }
        }
        
        do {
            try self.managedObjectContext.save()
            print("Report Salvato.")
        } catch {
            print("Errore: \(error.localizedDescription)")
        }
    }
    
    var body: some View {        
        for list in self.reports {
            if CompareDate(date: date, referenceDate: list.date ?? Date()) {
                return AnyView (
                    VStack {
                        Spacer()
                        Text("\(list.title!)").font(.largeTitle)
                        Text("\(list.text!)").font(.headline)
                        Divider()
                        Spacer()
                        HStack {
                            ReportData(content: AnyView(
                                VStack(){
                                    Text("Temperatura").font(.headline)
                                    Image(systemName: "staroflife.fill").foregroundColor(.blue).font(.largeTitle)
                                    Spacer()
                                    HStack {
                                        Text(String(list.temperature)).font(.largeTitle)
                                        Text("°C").font(.title)
                                    }
                                    Spacer()
                                    Text("Importanza valore").font(.subheadline)
                                    Text(String(list.tempImportance+1))
                                }
                            )).padding()
                            
                            ReportData(content: AnyView(
                                VStack{
                                    Text("Battito Cardiaco").font(.headline)
                                    Image(systemName: "heart.fill").foregroundColor(.red).font(.largeTitle)
                                    Spacer()
                                    HStack {
                                        Text(String(list.heartbeat)).font(.largeTitle)
                                        Text("bpm").font(.title)
                                    }
                                    Spacer()
                                    Text("Importanza valore").font(.subheadline)
                                    Text(String(list.heartImportance+1))
                                }
                            )).padding()
                        }
                        HStack {
                            ReportData(content: AnyView(
                                VStack{
                                    Text("Glicemia").font(.headline)
                                    Image(systemName: "bandage.fill").foregroundColor(.yellow).font(.largeTitle)
                                    Spacer()
                                    HStack {
                                        Text(String(list.glycemia)).font(.largeTitle)
                                        Text("mg/dl").font(.title)
                                    }
                                    Spacer()
                                    Text("Importanza valore").font(.subheadline)
                                    Text(String(list.glycemiaImportance+1))
                                }
                            )).padding()
                            
                            ReportData(content: AnyView(
                                VStack{
                                    Text("Frequenza Respiratoria").font(.headline)
                                    Image(systemName: "waveform.path.ecg").foregroundColor(.green).font(.largeTitle)
                                    Spacer()
                                    Text(String(list.breath)).font(.largeTitle)
                                    Spacer()
                                    Text("Importanza valore").font(.subheadline)
                                    Text(String(list.breathImportance+1))
                                }
                            )).padding()
                        }
                        Divider()
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                self.showEditSheet.toggle()
                            }) {
                                VStack(alignment: .center){
                                    Text("Modifica il Report")
                                        .font(.title)
                                }
                                .padding(.all)
                                .frame(width: 370.0, height: 70.0)
                                .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                                .cornerRadius(14.0)
                            }.sheet(isPresented: $showEditSheet) {
                                EditViewSheet(
                                    reports : self.reports,
                                    showEditSheet: self.$showEditSheet,
                                    showSheet: self.$showSheet,
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
                                    id : list.id!).environment(\.managedObjectContext, self.managedObjectContext)
                            }
                            
                            Button(action: {
                                self.showSheet = false
                                self.deleteReport(reports: list)
                            }) {
                                VStack(alignment: .center){
                                    Text("Elimina il Report")
                                        .font(.title)
                                        .foregroundColor(.red)
                                }
                                .padding(.all)
                                .frame(width: 370.0, height: 70.0)
                                .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                                .cornerRadius(14.0)
                            }
                            .padding()
                        }
                    }
                )
            }
        }
        return AnyView(Text("Ops, qualcosa è andato storto"))
    }
    
    func CompareDate(date: Date, referenceDate: Date) -> Bool {
        let order = Calendar.current.compare(date, to: referenceDate, toGranularity: .day)
        
        switch order {
        case .orderedDescending:
            return false
        case .orderedAscending:
            return false
        case .orderedSame:
            return true
        default:
            return false
        }
    }
}

struct ReportData: View {
    var content : AnyView
    
    var body: some View {
        Group {
            self.content
        }
        .padding(.all)
        .frame(width: 170.0, height: 200.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(12.0)
        
    }
}
