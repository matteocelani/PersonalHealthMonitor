//
//  ReportData.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 05/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ReportData: View {
    var content : AnyView
    
    var body: some View {
            Group {
                self.content
            }
            .padding(.all)
            .frame(width: 150.0, height: 200.0)
            .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
            .cornerRadius(12.0)

        }
}

struct ReportData_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
        ReportData(content: AnyView(Text("Hello Words")))
            .padding()
            ReportData(content: AnyView(Text("Hello Words")))
            .padding()
        }
    }
}
