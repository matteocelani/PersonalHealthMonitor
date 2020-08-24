//
//  HeaderView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 24/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Button(action: {
                print("Information")
            }) {
                Image(systemName: "info.circe").font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
        
            Spacer()
            
            Text ("Header")
            
            Spacer()
            
            Button(action: {
                print("Guide")
            }) {
                Image(systemName: "questionmark.circe").font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
        }
    .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
        .previewLayout(.fixed(width: 375, height: 80))
    }
}
