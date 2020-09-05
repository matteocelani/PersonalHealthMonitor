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
    @State var tempImportance = 2
    @State var heartImportance = 2
    @State var glycemiaImportance = 2
    @State var breathImportance = 2
    
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

    //Clear TextField
    func clearField() {
        self.title = ""
        self.text = ""
        self.date = Date()
        self.temperature = ""
        self.heartbeat = ""
        self.glycemia = ""
        self.breath = ""
        
        self.tempImportance = 2
        self.heartImportance = 2
        self.glycemiaImportance = 2
        self.breathImportance = 2
    }
    
    // MARK: -CoreData Control
    @Environment(\.managedObjectContext) var managedObjectContext
    
    func newReport() {
        let newReport = Report(context: self.managedObjectContext)
        
        newReport.id = UUID()
        newReport.date = self.date
        
        newReport.title = self.title
        newReport.text = self.text
        
        newReport.temperature = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
        newReport.tempImportance = Int16(self.tempImportance+1)
        
        newReport.heartbeat = Int16(self.heartbeat)!
        newReport.heartImportance = Int16(self.heartImportance+1)
        
        newReport.glycemia = Int16(self.glycemia)!
        newReport.glycemiaImportance = Int16(self.glycemiaImportance+1)
        
        newReport.breath = Int16(self.breath)!
        newReport.breathImportance = Int16(self.breathImportance+1)
        
        do {
         try self.managedObjectContext.save()
         print("Report Salvato.")
        } catch {
         print("Errore: \(error.localizedDescription)")
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
                            
                            
                            TextField("Titolo", text: $title){self.endEditing()}
                                .frame(height: 30.0)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            TextField("Descrizione", text: $text){self.endEditing()}
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
                        
                        Text("\(date, formatter: dateFormatter)")

                    }
))
                    
                    Spacer()
                    
                    // MARK: -Add Temperature
                     CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Temperatura")
                                .font(.title)
                            
                            
                            TextField("valore compreso tra 30 e 45", text: $temperature){self.endEditing()}
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
                            
                            
                            TextField("valore maggiore di 40", text: $heartbeat){self.endEditing()}
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $heartImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                            }.pickerStyle(SegmentedPickerStyle())


                        }
                    ))

                        
                    // MARK: -Add Glycemia
                     CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Glicemia")
                                .font(.title)
                            
                            
                            TextField("valore maggiore di 40", text: $glycemia){self.endEditing()}
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $glycemiaImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                            }.pickerStyle(SegmentedPickerStyle())


                        }
                    ))

                    
                    // MARK: -Add Breath
                     CardView(content: AnyView(
                        VStack(alignment: .center) {
                            Text("Frequenza Respiratoria")
                                .font(.title)
                            
                            
                            TextField("valore maggiore di 10", text: $breath){self.endEditing()}
                                .frame(height: 30.0)
                                .keyboardType(.decimalPad)
                                .background(Color(UIColor.systemBackground))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(TextAlignment.center)
                            
                            Text("Importanza:")
                            Picker(selection: $breathImportance, label: Text("Determinare un importanza")) {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                            }.pickerStyle(SegmentedPickerStyle())


                        }
                    ))
                    
                    // MARK: -Button to Add Report
                    Divider()
                    
                    Button(action: {
                        self.newReport()
                        self.clearField()
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
