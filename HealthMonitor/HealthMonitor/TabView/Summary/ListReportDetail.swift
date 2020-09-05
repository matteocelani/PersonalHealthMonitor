//
//  ListReportDetail.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 05/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ListReportDetail: View {
    var report : Report
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date = Date()
    
    var body: some View {
        Group{
                VStack(alignment: .leading) {
                    Text(report.title!)
                    .font(.headline)
                    Text("\(date, formatter: dateFormatter)")
                    .font(.subheadline)
                }
        }
        .frame(height: 50.0)
    }
}
