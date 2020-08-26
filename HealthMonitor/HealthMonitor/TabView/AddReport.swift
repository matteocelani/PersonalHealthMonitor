//
//  AddReport.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct AddReport: View {
    
    @State var keyboardHeight : CGFloat = 0.0
    
    // MARK: -Report Values
    //@State var date = Date()
    @State var temperature = ""
    @State var heartbeat = ""
    @State var glycemia = ""
    @State var breath = ""
    @State var text = ""
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var heartImportance = 3
    @State var glycemiaImportance = 3
    @State var breathImportance = 3
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    
                    CardView(insert : ReportData[0])
                        
                    CardView(insert : ReportData[1])
                        
                    CardView(insert : ReportData[2])
                        
                    CardView(insert : ReportData[3])
                    
                    CardViewText()
                    
                    Spacer()
                }
                    /* .offset(y: -self.keyboardHeight)
                    .animation(.spring())
                    .onAppear {
                                
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) {
                                    (notification) in
                                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                                        return
                                    }
                                    
                                    self.keyboardHeight = keyboardFrame.height
                                    
                                }
                                 
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                                    (notification) in
                                    
                                    self.keyboardHeight = 0
                                    
                                }
                                
                    }
                    */
                .navigationBarTitle(Text("Nuovo Report"))
            }
        }
    }
}

struct AddReport_Previews: PreviewProvider {
    static var previews: some View {
        AddReport()
    }
}
