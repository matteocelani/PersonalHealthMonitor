//
//  CardViewData.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 26/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI
import Combine


struct CardViewData: View {
    
    var contentData : AnyView

    var body: some View {
        Group {
            self.contentData
        }
        .padding(.all)
        .frame(width: 370.0, height: 300.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(25.0)
        
    }
}
