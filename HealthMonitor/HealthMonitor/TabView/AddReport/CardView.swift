//
//  CardView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine

struct CardView: View {
    
    var content : AnyView
    
    var body: some View {
        Group {
            self.content
        }
        .padding(.all)
        .frame(width: 370.0, height: 210.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(25.0)

    }
    private func endEditing() {
           UIApplication.shared.endEditing()
       }
}
