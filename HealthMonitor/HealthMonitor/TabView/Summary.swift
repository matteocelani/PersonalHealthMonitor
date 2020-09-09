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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Report.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Report.date, ascending: false)])
    var reports: FetchedResults<Report>
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            Group{
                if (reports.isEmpty){
                    VStack{
                        Text("Aggiungi il tuo primo report")
                            .font(.title)
                        
                        Spacer()
                        
                        MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Report")
                        
                        Spacer()
                        
                        CardView(content: AnyView(
                            VStack(alignment: .leading){
                                Text("Health Monitor è un app che giornalmente ti ricorda di aggiungere un nuovo report, tenendo sempre sott'occhio alcuni parametri vitali come temperatura, battito cardiaco, respirazione e glicemia.")
                                Text("E' fornita di un calendario nel quale sono presenti giornalmente i report.")
                                Text("Cosa aspetti iniza subito a monitorare i tuoi parametri.")
                            }
                        ))
                        Spacer()
                    }
                } else {
                    List{
                        NavigationLink(destination: AllReport()) {
                            ListView(content: AnyView(
                                HStack {
                                    Image(systemName: "list.bullet").font(.largeTitle)
                                    Spacer()
                                    Text("Tutti i report")
                                        .font(.headline)
                                    Spacer()
                                }
                            ))
                        }
                        Divider()
                        HStack {
                            LineChartView(data: self.reportTempArray(), title: "Temp",rateValue: 0)
                                .padding(.top)
                            //Spacer()
                            LineChartView(data: self.reportHeaArray(), title: "Battito", rateValue: 0)
                                .padding(.top)
                            // Spacer()
                        }
                        HStack {
                            LineChartView(data: self.reportGlyArray(), title: "Glicemia", rateValue: 0)
                                .padding(.top)
                            LineChartView(data: self.reportBreArray(), title: "Respiro", rateValue: 0)
                                .padding(.top)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Sommario"))
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = true
            }) {
                Image(systemName: "bell.fill").font(.title)
            })
        }.sheet(isPresented: self.$showSheet) {
            FilterSheet(showSheet: self.$showSheet)
        }
    }
    
    private func reportTempArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.temperature))
        }
        return array
    }
    
    private func reportHeaArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.heartbeat))
        }
        return array
    }
    
    private func reportGlyArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.glycemia))
        }
        return array
    }
    
    private func reportBreArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.breath))
        }
        return array
    }
}

struct ListView: View {
    
    var content : AnyView
    
    var body: some View {
        Group {
            self.content
        }
        .padding(.all)
        .frame(maxWidth: .infinity)
        .frame(height: 50.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(12.0)
        
    }
}
