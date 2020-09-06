//
//  ReportView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 06/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    
    var report : Report
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date = Date()
    
    @Binding var showSheet : Bool
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @State var showEditSheet = false
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(report.title!)").font(.title)
                        Text("\(report.text!)")
                    }
                    Spacer()
                }.padding(.horizontal)
                
                HStack {
                    ReportData(content: AnyView(
                        VStack(){
                            Text("Temperatura").font(.headline)
                            Image(systemName: "staroflife.fill").foregroundColor(.blue).font(.largeTitle)
                            Spacer()
                            Text(String(report.temperature)).font(.largeTitle)
                            Spacer()
                            Text("Importanza valore").font(.subheadline)
                            Text(String(report.tempImportance+1))
                        }
                    )).padding()
                    
                    ReportData(content: AnyView(
                        VStack{
                            Text("Battito Cardiaco").font(.headline)
                            Image(systemName: "heart.fill").foregroundColor(.red).font(.largeTitle)
                            Spacer()
                            Text(String(report.heartbeat)).font(.largeTitle)
                            Spacer()
                            Text("Importanza valore").font(.subheadline)
                            Text(String(report.heartImportance+1))
                        }
                    )).padding()
                }
                HStack {
                    ReportData(content: AnyView(
                        VStack{
                            Text("Glicemia").font(.headline)
                            Image(systemName: "bandage.fill").foregroundColor(.yellow).font(.largeTitle)
                            Spacer()
                            Text(String(report.glycemia)).font(.largeTitle)
                            Spacer()
                            Text("Importanza valore").font(.subheadline)
                            Text(String(report.glycemiaImportance+1))
                        }
                    )).padding()
                    
                    ReportData(content: AnyView(
                        VStack{
                            Text("Frequenza Respiratoria").font(.headline)
                            Image(systemName: "waveform.path.ecg").foregroundColor(.green).font(.largeTitle)
                            Spacer()
                            Text(String(report.breath)).font(.largeTitle)
                            Spacer()
                            Text("Importanza valore").font(.subheadline)
                            Text(String(report.breathImportance+1))
                        }
                    )).padding()
                }
                
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
                            title: self.report.title!,
                            text: self.report.text ?? "",
                            date: self.report.date!,
                            temperature: String(self.report.temperature),
                            heartbeat: String(self.report.heartbeat),
                            glycemia: String(self.report.glycemia),
                            breath: String(self.report.breath),
                            tempImportance: self.report.tempImportance,
                            heartImportance: self.report.heartImportance,
                            glycemiaImportance: self.report.glycemiaImportance,
                            breathImportance: self.report.breathImportance,
                            id : self.report.id!)
                    }
                    
                    Button(action: {
                        self.showEditSheet.toggle()
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
                    }.sheet(isPresented: $showEditSheet) {
                        EditViewSheet(
                            reports : self.reports,
                            showEditSheet: self.$showEditSheet,
                            showSheet: self.$showSheet,
                            title: self.report.title!,
                            text: self.report.text ?? "",
                            date: self.report.date!,
                            temperature: String(self.report.temperature),
                            heartbeat: String(self.report.heartbeat),
                            glycemia: String(self.report.glycemia),
                            breath: String(self.report.breath),
                            tempImportance: self.report.tempImportance,
                            heartImportance: self.report.heartImportance,
                            glycemiaImportance: self.report.glycemiaImportance,
                            breathImportance: self.report.breathImportance,
                            id : self.report.id!)
                    }
                    .padding()
                    
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
    }
}
