//
//  AddReport.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine


struct AddReport: View {
    
    // MARK: -Report Values
    @State var temperature = ""
    @State var heartbeat = ""
    @State var glycemia = ""
    @State var breath = ""
    @State var text = ""
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var heartImportance = 3
    @State var glycemiaImportance = 3
    @State var breathImportance = 2
    
    // MARK: -Button Control
    
    // Enable "Add Report" button
    /* func checkForm() -> Bool {
        let checkTemp: Float = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
        
        let checkHeart: Int = Int(self.heartbeat) ?? 0
        let checkGlycemia: Int = Int(self.glycemia) ?? 0
        let checkBreath: Int = Int(self.breath) ?? 0
        
        if (checkTemp >= 30.0 && checkTemp <= 45.0){
            if (checkHeart >= 40){
                if (checkGlycemia >= 40){
                    if (checkBreath >= 10){
                        return true
                    }
                }
            }
        }
        return false
    }*/func checkForm() -> Bool {
        let checkTex: String = (self.text) 
        
        if (checkTex == ""){
                        return true
                    }
        return false
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    
                    CardViewData()
                    
                    Spacer()
                    
                    CardView(insert : DescriptionData[0])
                        
                    CardView(insert : DescriptionData[1])
                        
                    CardView(insert : DescriptionData[2])
                        
                    CardView(insert : DescriptionData[3])
                    
                    CardViewText()
                    
                    // MARK: -Button to Add Report
                    Divider()
                    
                    Button(action: {
                        //Your Action Here
                    }) {
                        ButtonView()
                    }.disabled(!self.checkForm())
                    
                    Spacer()
                    
                }
            }
            .navigationBarTitle(Text("Nuovo Report"))
            .modifier(AdaptsKeyboard())
        }
    }
}

struct AddReport_Previews: PreviewProvider {
    static var previews: some View {
        AddReport()
    }
}
