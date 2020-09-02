//
//  CalendarCell.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct CalendarCell: View {
    
    var CalendarDate: CalendarDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(CalendarDate.getText())
            .fontWeight(CalendarDate.getFontWeight())
            .foregroundColor(CalendarDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .background(CalendarDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
    }
}
