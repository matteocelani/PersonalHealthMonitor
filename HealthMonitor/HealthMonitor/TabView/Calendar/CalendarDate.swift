//
//  CalendarDate.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct CalendarDate {
    
    var date: Date
    let CalendarManager: CalendarManager
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false
    var isReport: Bool = false
    
    init(date: Date, CalendarManager: CalendarManager, isDisabled: Bool, isToday: Bool, isSelected: Bool, isReport: Bool) {
        self.date = date
        self.CalendarManager = CalendarManager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isReport = isReport
    }
    
    func getText() -> String {
        let day = formatDate(date: date, calendar: self.CalendarManager.calendar)
        return day
    }
    
    func getTextColor() -> Color {
        var textColor = CalendarManager.colors.textColor
        if isDisabled {
            textColor = CalendarManager.colors.disabledColor
        } else if isSelected {
            textColor = CalendarManager.colors.selectedColor
        } else if isToday {
            textColor = CalendarManager.colors.todayColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = CalendarManager.colors.textBackColor
        if isReport {
            backgroundColor = CalendarManager.colors.reportBackColor
        }
        if isToday {
            backgroundColor = CalendarManager.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = CalendarManager.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = CalendarManager.colors.selectedBackColor
        }
        return backgroundColor
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.heavy
        } else if isToday {
            fontWeight = Font.Weight.heavy
        }
        return fontWeight
    }
    
    // MARK: - Date Formats
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
}

