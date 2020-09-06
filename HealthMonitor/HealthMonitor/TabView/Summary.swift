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
    @FetchRequest(entity: Report.entity(), sortDescriptors: [])
    var reports: FetchedResults<Report>
    
    init() {
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
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
                                Image(systemName: "list.bullet").foregroundColor(.black).font(.largeTitle)
                            Spacer()
                            Text("Tutti i report")
                            .font(.headline)
                            Spacer()
                            }
                ))
                }
                Divider()
                HStack {
            LineChartView(data: self.reportTempArray(), title: "Temperatura",rateValue: 0)
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
