//
//  FooterView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 24/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack {
            VStack {
                
            Spacer()
                
            Image(systemName: "heart.fill")
                .font(.system(size: 42, weight: .light))
            Text("Riepilogo")
                
            }
            
            Spacer()
            
            VStack {
                
                Spacer()
                
                Image(systemName: "calendar")
                    .font(.system(size: 42, weight: .light))
                
                Text("Calendario")
            }
            
            Spacer()
            
            VStack {
                Spacer()
                
                Image(systemName: "person.fill")
                    .font(.system(size: 42, weight: .light))
                
                Text("Profilo")
            }
            
            
        }
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .previewLayout(.fixed(width: 375, height: 80))
        
    }
}
