//
//  AddReportSheet.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 04/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine

struct AddReportSheet: View {
    
    @Binding var showSheet : Bool
    
    // MARK: -Report Values
    @State var title = ""
    @State var text = ""
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date = Date()
    @State var temperature = ""
    @State var heartbeat = ""
    @State var glycemia = ""
    @State var breath = ""
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var heartImportance = 3
    @State var glycemiaImportance = 3
    @State var breathImportance = 3
    
    // MARK: -Button Control
    func validateForm() -> Bool {
        let checkTemp: Float = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
        
        let checkHeart: Int = Int(self.heartbeat) ?? 0
        let checkGlycemia: Int = Int(self.glycemia) ?? 0
        let checkBreath: Int = Int(self.breath) ?? 0
        
        if (checkTemp >= 30.0 && checkTemp <= 45.0){
            if (checkHeart >= 40){
                if (checkGlycemia >= 40){
                    if (checkBreath >= 10){
                        if (title != "") {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    // MARK: -CoreData Control
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    func controlReport() {
        for report in reports {
            if CompareDate(date: report.date!, referenceDate: self.date){
                avgReport(report: report)
                return
            }
        }
        newReport()
    }
    
    func newReport() {
        let newReport = Report(context: self.managedObjectContext)
        
        newReport.id = UUID()
        newReport.date = self.date
        
        newReport.title = self.title
        newReport.text = self.text
        
        newReport.temperature = Float(self.temperature.replacingOccurrences(of: ",", with: "."))!
        newReport.tempImportance = Int16(self.tempImportance)
        
        newReport.heartbeat = Int16(self.heartbeat)!
        newReport.heartImportance = Int16(self.heartImportance)
        
        newReport.glycemia = Int16(self.glycemia)!
        newReport.glycemiaImportance = Int16(self.glycemiaImportance)
        
        newReport.breath = Int16(self.breath)!
        newReport.breathImportance = Int16(self.breathImportance)
        
        do {
            try self.managedObjectContext.save()
            print("Report Salvato.")
        } catch {
            print("Errore: \(error.localizedDescription)")
        }
    }
    
    func avgReport(report:Report) {
        
        report.title = self.title
        report.text = self.text
        
        report.temperature = (report.temperature + Float(self.temperature.replacingOccurrences(of: ",", with: "."))!)/2
        report.tempImportance = Int16(self.tempImportance)
        
        report.heartbeat = (report.heartbeat + Int16(self.heartbeat)!)/2
        report.heartImportance = Int16(self.heartImportance)
        
        report.glycemia = (report.glycemia + Int16(self.glycemia)!)/2
        report.glycemiaImportance = Int16(self.glycemiaImportance)
        
        report.breath = (report.breath + Int16(self.breath)!)/2
        report.breathImportance = Int16(self.breathImportance)
        
        do {
            try self.managedObjectContext.save()
            print("Report Salvato.")
        } catch {
            print("Errore: \(error.localizedDescription)")
        }
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
    
    
    // MARK: -Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                VStack() {
                    // MARK: -Add Title
                    VStack(alignment: .center) {
                        Text("Nome del Report")
                            .font(.title)
                        
                        
                        TextField("Titolo", text: $title, onCommit: {self.endEditing()})
                            .frame(height: 30.0)
                            .background(Color(UIColor.systemBackground))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(TextAlignment.center)
                        
                        TextField("Descrizione", text: $text, onCommit: {self.endEditing()})
                            .frame(height: 30.0)
                            .background(Color(UIColor.systemBackground))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(TextAlignment.center)
                    }
                    .padding(.all)
                    .frame(width: 370.0, height: 140.0)
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                    .cornerRadius(25.0)
                    
                    // MARK: -Select Data
                    CardViewData(contentData: AnyView(
                        VStack(alignment: .center) {
                            Text("Seleziona una data")
                                .font(.title)
                            
                            Spacer()
                            
                            DatePicker("", selection: $date, in: ...Date(),displayedComponents: .date)
                                .labelsHidden()
                                .padding()
                                .frame(maxHeight: 100)
                            
                            Spacer()
                            
//                            Text("\(date, formatter: dateFormatter)")
                            
                        }
                    ))
                    
                    Spacer()
                    
                    // MARK: -Add Temperature
                    CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Temperatura")
                                .font(.title)
                            
                            
                            TextField("valore compreso tra 30 e 45", text: $temperature, onCommit: {self.endEditing()})
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $tempImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            
                        }
                    ))
                    
                    
                    // MARK: -Add Heartbeat
                    CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Battito Cardiaco")
                                .font(.title)
                            
                            
                            TextField("valore maggiore di 40", text: $heartbeat, onCommit: {self.endEditing()})
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $heartImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                                Text("4").tag(4)
                                Text("5").tag(5)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            
                        }
                    ))
                    
                    
                    // MARK: -Add Glycemia
                    CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Glicemia")
                                .font(.title)
                            
                            
                            TextField("valore maggiore di 40", text: $glycemia, onCommit: {self.endEditing()})
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $glycemiaImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                                Text("4").tag(4)
                                Text("5").tag(5)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            
                        }
                    ))
                    
                    
                    // MARK: -Add Breath
                    CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Frequenza Respiratoria")
                                .font(.title)
                            
                            
                            TextField("valore maggiore di 10", text: $breath, onCommit: {self.endEditing()})
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $breathImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                                Text("4").tag(4)
                                Text("5").tag(5)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            
                        }
                    ))
                    
                    // MARK: -Button to Add Report
                    Divider()
                    
                    Button(action: {
                        self.controlReport()
                        self.showSheet = false
                    }) {
                        ButtonView()
                    }.disabled(!self.validateForm())
                    
                    Spacer()
                    
                }
            }
            .navigationBarTitle(Text("Nuovo Report"), displayMode: .inline)
            .modifier(AdaptsKeyboard())
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = false
            }) {
                Text("Chiudi").bold()
            })
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}
