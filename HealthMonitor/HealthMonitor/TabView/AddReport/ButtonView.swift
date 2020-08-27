//
//  ButtonView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 27/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Aggiungi il Report")
                .font(.title)
        }
        .padding(.all)
        .frame(width: 370.0, height: 70.0)
        .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
        .cornerRadius(14.0)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
