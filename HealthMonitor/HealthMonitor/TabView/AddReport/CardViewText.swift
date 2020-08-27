//
//  CardViewText.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 26/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine

struct CardViewText: View {
    
    //MARK: -PROPERTIES
    
    @State var value = ""
    
    var body: some View {
    VStack(alignment: .center) {
            Text("Note")
                .font(.title)
            
            
            TextField("Aggiungi delle note. Sezione facolatativa.", text: $value)
                .frame(height: 100.0)
                //.background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .multilineTextAlignment(TextAlignment.center)
        
        }
        .padding(.all)
        .frame(width: 370.0, height: 210.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(25.0)

    }
}

struct CardViewText_Previews: PreviewProvider {
    static var previews: some View {
        CardViewText()
    }
}
