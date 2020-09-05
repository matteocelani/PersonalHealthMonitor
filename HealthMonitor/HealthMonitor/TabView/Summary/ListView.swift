//
//  ListView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 05/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    var content : AnyView
    
    var body: some View {
            Group {
                self.content
            }
            .padding(.all)
            .frame(maxWidth: .infinity)
            .frame(height: 50.0)
            .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
            .cornerRadius(12.0)

        }
    }

