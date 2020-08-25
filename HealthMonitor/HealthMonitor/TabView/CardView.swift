//
//  CardView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI


struct CardView: View {
    
    //MARK: -PROPERTIES
    
    let id = UUID()
    var insert : Report
    @State var value = ""
    @State var importance = 2
    
    var body: some View {
        VStack(alignment: .center) {
            Text(insert.title)
                .font(.title)
            
            
            TextField(insert.description, text: $value)
                .frame(height: 30.0)
            
                .keyboardType(.decimalPad)
                .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
                .multilineTextAlignment(TextAlignment.center)
            
            Text("Importanza:")
            Picker(selection: $importance, label: Text("Determinare un importanza")) {
                Text("1").tag(0)
                Text("2").tag(1)
                Text("3").tag(2)
                Text("4").tag(3)
                Text("5").tag(4)
            }.pickerStyle(SegmentedPickerStyle())


        }
        .padding(.all)
        .frame(width: 370.0, height: 210.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.1))
        .cornerRadius(25.0)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(insert : ReportData[0])
    }
}
