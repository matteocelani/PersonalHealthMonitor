//
//  EditViewSheet.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 04/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct EditViewSheet: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @Binding var showEditSheet : Bool
    
    // MARK: -Report Values
    @State var title : String
    @State var text : String
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date : Date
    @State var temperature : String
    @State var heartbeat : String
    @State var glycemia : String
    @State var breath : String
    
    // MARK: -Report Importance
    @State var tempImportance: Int16
    @State var heartImportance: Int16
    @State var glycemiaImportance: Int16
    @State var breathImportance: Int16
    
    @State var id : UUID
    

    
    // MARK: -Button Control
    @State private var showingAlert = false
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
    
    // MARK: -Edit Report

    func editReport() {
        for list in self.reports {
            if CompareId(id: id,  referenceId: list.id!) {
                list.date = self.date
                
                list.title = self.title
                list.text = self.text
                
                list.temperature = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
                list.tempImportance = Int16(self.tempImportance+1)
                
                list.heartbeat = Int16(self.heartbeat)!
                list.heartImportance = Int16(self.heartImportance+1)
                
                list.glycemia = Int16(self.glycemia)!
                list.glycemiaImportance = Int16(self.glycemiaImportance+1)
                
                list.breath = Int16(self.breath)!
                list.breathImportance = Int16(self.breathImportance+1)
                
            }
        }
        do {
          try self.managedObjectContext.save()
          print("Report Modificato.")
         } catch {
          print("Errore: \(error.localizedDescription)")
          }
    }
    
    func CompareId(id: UUID, referenceId: UUID) -> Bool {
        return id == referenceId
    }
    
    var body: some View {
        NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer()
                        VStack() {
                            // MARK: -Add Title
                                VStack(alignment: .center) {
                                    Text("Nome del Report")
                                        .font(.title)
                                    
                                    
                                     TextField("Titolo", text: $title)
                                        .frame(height: 30.0)
                                        .background(Color(UIColor.systemBackground))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .multilineTextAlignment(TextAlignment.center)
                                    
                                    TextField("Descrizione", text: $text)
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
                                    
                                    
                                    TextField("valore compreso tra 30 e 45", text: $temperature)
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
                                    
                                    
                                    TextField("valore maggiore di 40", text: $heartbeat)
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
                                    
                                    
                                    TextField("valore maggiore di 40", text: $glycemia)
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
                                    
                                    
                                    TextField("valore maggiore di 10", text: $breath)
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
                                self.editReport()
                                self.showEditSheet = false
                            }) {
                                VStack(alignment: .center){
                                    Text("Modifica Report")
                                        .font(.title)
                                }
                                .padding(.all)
                                .frame(width: 370.0, height: 70.0)
                                .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                                .cornerRadius(14.0)
                            }.disabled(!self.validateForm())
                
                            Spacer()
                            
                        }
                    }
                    .navigationBarTitle(Text("Modifica il report"), displayMode: .inline)
                    .modifier(AdaptsKeyboard())
                    .navigationBarItems(trailing: Button(action: {
                        self.showEditSheet = false
                    }) {
                        Text("Chiudi").bold()
                    })
                }
            }
}
