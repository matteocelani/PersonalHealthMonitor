//
//  CalendarMonth.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 02/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct CalendarMonth: View {
    
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @ObservedObject var CalendarManager: CalendarManager
    
    let monthOffset: Int
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth = CGFloat(32)
    
    @State var showSheet = false
    
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            Text(getMonthHeader()).foregroundColor(self.CalendarManager.colors.monthHeaderColor)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack() {
                        ForEach(row, id:  \.self) { column in
                            HStack() {
                                Spacer()
                                if self.isThisMonth(date: column) {
                                    CalendarCell(CalendarDate: CalendarDate(
                                        date: column,
                                        CalendarManager: self.CalendarManager,
                                        isDisabled: !self.isEnabled(date: column),
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSpecialDate(date: column),
                                        isReport: self.isReport(date: column)
                                        ),
                                        cellWidth: self.cellWidth)
                                        .onTapGesture {
                                            self.dateTapped(date: column)
                                            self.showSheet = true
                                    }
                                    .sheet(isPresented: self.$showSheet) {
                                        if self.isReport(date: self.CalendarManager.selectedDate ?? Date()) {
                                            ReportSheet(showSheet: self.$showSheet, reports: self.reports, date: self.CalendarManager.selectedDate)
                                            .environment(\.managedObjectContext, self.managedObjectContext)
                                        }
                                        else if (self.CompareDate(date: Date(), referenceDate: self.CalendarManager.selectedDate!)) {
                                            AddReportSheet(showSheet: self.$showSheet, date: self.CalendarManager.selectedDate ?? Date(), reports: self.reports)
                                            .environment(\.managedObjectContext, self.managedObjectContext)
                                        } else {
                                            FutureDay(showSheet: self.$showSheet)
                                        }
                                    }
                                } else {
                                    Text("").frame(width: self.cellWidth, height: self.cellWidth)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }.background(CalendarManager.colors.monthBackColor)
        .padding()
    }
    
    func CompareDate(date: Date, referenceDate: Date) -> Bool {
        let order = Calendar.current.compare(date, to: referenceDate, toGranularity: .day)
        
        switch order {
        case .orderedDescending:
            return true
        case .orderedAscending:
            return false
        case .orderedSame:
            return false
        default:
            return false
        }
    }

     func isThisMonth(date: Date) -> Bool {
         return self.CalendarManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
            if (self.CalendarManager.mode == 0)  {
                if self.CalendarManager.selectedDate != nil &&
                    self.CalendarManager.calendar.isDate(self.CalendarManager.selectedDate, inSameDayAs: date) {
                    self.CalendarManager.selectedDate = nil
                } else {
                    self.CalendarManager.selectedDate = date
                }
            }
                else {
                self.CalendarManager.selectedDate = date
            }
    }
     
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = CalendarManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: CalendarManager.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = CalendarManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - CalendarManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset
        
        return CalendarManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }
    
    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = CalendarManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return CalendarManager.calendar.date(byAdding: offset, to: FirstDateMonth())!
    }
    
    func FormatDate(date: Date) -> Date {
        let components = CalendarManager.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return CalendarManager.calendar.date(from: components)!
    }
    
    func FormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = FormatDate(date: referenceDate)
        let clampedDate = FormatDate(date: date)
        return refDate == clampedDate
    }
    
    func FirstDateMonth() -> Date {
        var components = CalendarManager.calendar.dateComponents(calendarUnitYMD, from: CalendarManager.minimumDate)
        components.day = 1
        
        return CalendarManager.calendar.date(from: components)!
    }
    
    // MA: - Date Property Checkers
    
    func isToday(date: Date) -> Bool {
        return FormatAndCompareDate(date: date, referenceDate: Date())
    }
    
    func isReport(date: Date) -> Bool {
        //if (reports.first!.date! != nil) {
            for list in self.reports  {
                if FormatAndCompareDate(date: date, referenceDate: list.date ?? Date()) {
                    return true
                }
            }
     //   }
        return false
    }
     
    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date)
    }
    
    func isOneOfSelectedDates(date: Date) -> Bool {
        return self.CalendarManager.selectedDatesContains(date: date)
    }

    func isSelectedDate(date: Date) -> Bool {
        if CalendarManager.selectedDate == nil {
            return false
        }
        return FormatAndCompareDate(date: date, referenceDate: CalendarManager.selectedDate)
    }
    
    func isStartDate(date: Date) -> Bool {
        if CalendarManager.startDate == nil {
            return false
        }
        return FormatAndCompareDate(date: date, referenceDate: CalendarManager.startDate)
    }
    
    func isEndDate(date: Date) -> Bool {
        if CalendarManager.endDate == nil {
            return false
        }
        return FormatAndCompareDate(date: date, referenceDate: CalendarManager.endDate)
    }
    
    func isOneOfDisabledDates(date: Date) -> Bool {
        return self.CalendarManager.disabledDatesContains(date: date)
    }
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = FormatDate(date: date)
        if CalendarManager.calendar.compare(clampedDate, to: CalendarManager.minimumDate, toGranularity: .day) == .orderedAscending || CalendarManager.calendar.compare(clampedDate, to: CalendarManager.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return !isOneOfDisabledDates(date: date)
    }
    
    func isStartDateAfterEndDate() -> Bool {
        if CalendarManager.startDate == nil {
            return false
        } else if CalendarManager.endDate == nil {
            return false
        } else if CalendarManager.calendar.compare(CalendarManager.endDate, to: CalendarManager.startDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}
