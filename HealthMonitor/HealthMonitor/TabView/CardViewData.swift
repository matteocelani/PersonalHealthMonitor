//
//  CardViewData.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 26/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI


struct CardViewData: View {
    
    //MARK: -PROPERTIES
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var date = Date()
    
    var body: some View {
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
        .padding(.all)
        .frame(width: 370.0, height: 300.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(25.0)
        
    }
}

struct CardViewData_Previews: PreviewProvider {
    static var previews: some View {
        CardViewData()
    }
}
