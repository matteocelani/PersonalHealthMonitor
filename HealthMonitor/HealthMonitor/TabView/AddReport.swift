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
    
    @State var keyboardHeight : CGFloat = 0.0
    
    // MARK: -Report Values
    //@State var date = Date()
    @State var temperature = ""
    @State var heartbeat = ""
    @State var glycemia = ""
    @State var breath = ""
    @State var text = ""
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var heartImportance = 3
    @State var glycemiaImportance = 3
    @State var breathImportance = 3
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    
                    CardViewData()
                    
                    Spacer()
                    
                    CardView(insert : ReportData[0])
                        
                    CardView(insert : ReportData[1])
                        
                    CardView(insert : ReportData[2])
                        
                    CardView(insert : ReportData[3])
                    
                    CardViewText()
                    
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
