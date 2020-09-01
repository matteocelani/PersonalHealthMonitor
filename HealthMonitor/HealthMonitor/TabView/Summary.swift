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
    var body: some View {
        NavigationView {
//          Color.red
            
            LineChartView(data: [40,41,39,39,38,37,37,37,36], title: "Title", legend: "Legendary")
            
            .navigationBarTitle(Text("Sommario"))
        }
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
