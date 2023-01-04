//
//  DateEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/11/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import Foundation

extension Date {
    
    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current
        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)
        return abs(components.day ?? 0)
    }
    
    func getDays(after: Int) -> [Date]{
        var days = [Date]()
        for i in 0...after{
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            let interval = TimeInterval(60 * 60 * 24 * i)
            let newDate = self.addingTimeInterval(interval)
            days.append(newDate)
        }
        return days
    }
    
    func getDay(after: Int) -> Date{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        let interval = TimeInterval(60 * 60 * 24 * after)
        let newDate = self.addingTimeInterval(interval)
        return newDate
    }
    
    var persianFormat: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.calendar = Calendar(identifier: .persian)
        return formatter.string(from: self)
    }
    
    var gregorianFormat: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.string(from: self)
    }
    
    var persianWeekDay: String{
        let weekdayReplace = ["Saturday": "شنبه", "Sunday": "یکشنبه", "Monday": "دوشنبه", "Tuesday": "سه شنبه", "Wednesday": "چهارشنبه", "Thursday": "پنجشنبه", "Friday": "جمعه"]
        let day = persianFormat.components(separatedBy: ", ")
        return day[0].replace(weekdayReplace)
    }
    
    var weekDay: String{
        let day = persianFormat.components(separatedBy: ", ")
        return day[0]
    }
    
    var persianDay: String{
        let replaceNumberChars = ["0": "۰",  "1": "۱", "2": "۲", "3": "۳", "4": "۴", "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹", ".": "", " ": "", ",": ""]
        let day = persianFormat.components(separatedBy: " ")
        let dayCharCount = day[1].count
        let option01 = day[1].substring(from: dayCharCount - 2 , to: dayCharCount).replace(replaceNumberChars)
        let option02 = day[2].replace(replaceNumberChars)
        return option01.enNumber.isNumber ? option01 : option02
    }
    
    var day: String{
        let day = gregorianFormat.components(separatedBy: " ")
        let dayCharCount = day[1].count
        let option01 = day[1].substring(from: dayCharCount - 2 , to: dayCharCount).replace([" ": ""])
        let option02 = day[2].replace([" ": "", ",": ""])
        return option01.isNumber ? option01 : option02
    }
    
    var shortPersianTime: String{
        var d = persianDay.enNumber
        d = Int(d)!<10 ? "0\(d)" : d
        return persianMonthNumber + " / " + d.faNumber
    }
    
    var shortTime: String{
        var d = day
        d = Int(day)!<10 ? "0\(day)" : day
        return monthNumber + " / " + d
    }
    
    var persianMonth: String{
        let monthReplace = ["Farvardin": "فروردین", "Ordibehesht": "اردیبهشت", "Khordad": "خرداد", "Tir": "تیر", "Mordad": "مرداد", "Shahrivar": "شهریور", "Mehr": "مهر", "Aban": "آبان", "Azar": "آذر", "Dey": "دی", "Bahman": "بهمن", "Esfand": "اسفند", " ": "", ",":""]
        let day = persianFormat.components(separatedBy: " ")
        let option01 = day[1].replace(monthReplace)
        let option02 = day[2].replace(monthReplace)
        return option02.isNumber ? option01 : option02
    }
    
    var month: String{
        let day = gregorianFormat.components(separatedBy: " ")
        let option01 = day[1].replace([" ": "", ",":""])
        let option02 = day[2].replace([" ": "", ",":""])
        return option02.isNumber ? option01 : option02

    }
    
    var persianMonthNumber: String{
        let monthReplace = ["Farvardin": "۰۱", "Ordibehesht": "۰۲", "Khordad": "۰۳", "Tir": "۰۴", "Mordad": "۰۵", "Shahrivar": "۰۶", "Mehr": "۰۷", "Aban": "۰۸", "Azar": "۰۹", "Dey": "۱۰", "Bahman": "۱۱", "Esfand": "۱۲", " ": "", ",":""]
        let day = persianFormat.components(separatedBy: " ")
        return day[2].isNumber ? day[1].replace(monthReplace) : day[2].replace(monthReplace)
    }
    
    var monthNumber: String{
        let monthReplace = ["January":"01", "February":"02", "March":"03", "April":"04", "May":"05", "June":"06", "July":"07", "August":"08", "September":"09", "October":"10", "November":"11", "December":"12", " ": ""]
        let day = gregorianFormat.components(separatedBy: " ")
        return day[2].isNumber ? day[1].replace(monthReplace) : day[2].replace(monthReplace)

    }
    
    var persianYear: String{
        let replaceNumberChars = ["0": "۰", "1": "۱", "2": "۲", "3": "۳", "4": "۴", "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹", ".": "", " ": ""]
        let day = persianFormat.components(separatedBy: " ")
        return day[3].substring(to: 4).replace(replaceNumberChars)
    }
    
    var year: String{
        let day = gregorianFormat.components(separatedBy: " ")
        return day[3].substring(to: 4)
    }
    
    var persianFullDate: String{ persianWeekDay + " " + persianDay + " " + persianMonth + " " + persianYear }
    
    var fullDate: String{ weekDay + " " + day + " " + month + " " + year }
    
    func days(to: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: to)
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
    
    var toString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func years(since: Date) -> Int? {
        Calendar.current.dateComponents([.year], from: since, to: self).year
    }
    
    func months(since: Date) -> Int? {
        Calendar.current.dateComponents([.month], from: since, to: self).month
    }
    
    func days(since: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: since, to: self).day
    }
    
    func hours(since: Date) -> Int? {
        Calendar.current.dateComponents([.hour], from: since, to: self).hour
    }
    
    func minutes(since: Date) -> Int? {
        Calendar.current.dateComponents([.minute], from: since, to: self).minute
    }
    
    func seconds(since: Date) -> Int? {
        Calendar.current.dateComponents([.second], from: since, to: self).second
    }
}

extension TimeInterval {
    var second: TimeInterval { 1 }
    var minute: TimeInterval { 60 }
    var hour: TimeInterval { 3_600 }
    var day: TimeInterval { 86_400 }
    var week: TimeInterval { 604_800 }
}

import Foundation

extension Date {

    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
   
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    
    func timeSinceDate(fromDate: Date) -> String {
        let earliest = self < fromDate ? self  : fromDate
        let latest = (earliest == self) ? fromDate : self
    
        let components:DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        
        if year >= 2{
            return "\(year) years ago"
        }else if (year >= 1){
            return "1 year ago"
        }else if (month >= 2) {
             return "\(month) months ago"
        }else if (month >= 1) {
         return "1 month ago"
        }else  if (week >= 2) {
            return "\(week) weeks ago"
        } else if (week >= 1){
            return "1 week ago"
        } else if (day >= 2) {
            return "\(day) days ago"
        } else if (day >= 1){
           return "1 day ago"
        } else if (hours >= 2) {
            return "\(hours) hours ago"
        } else if (hours >= 1){
            return "1 hour ago"
        } else if (minutes >= 2) {
            return "\(minutes) minutes ago"
        } else if (minutes >= 1){
            return "1 minute ago"
        } else if (seconds >= 3) {
            return "\(seconds) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}

extension Date {
    var firstDayOfWeek: Date {
        var beginningOfWeek = Date()
        var interval = TimeInterval()
        
        _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self)
        return beginningOfWeek
    }
    
    func addWeeks(_ numWeeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = numWeeks
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func weeksAgo(_ numWeeks: Int) -> Date {
        return addWeeks(-numWeeks)
    }
    
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func daysAgo(_ numDays: Int) -> Date {
        return addDays(-numDays)
    }
    
    func addHours(_ numHours: Int) -> Date {
        var components = DateComponents()
        components.hour = numHours
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func hoursAgo(_ numHours: Int) -> Date {
        return addHours(-numHours)
    }
    
    func addMinutes(_ numMinutes: Double) -> Date {
        return self.addingTimeInterval(60 * numMinutes)
    }
    
    func minutesAgo(_ numMinutes: Double) -> Date {
        return addMinutes(-numMinutes)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let cal = Calendar.current
        var components = DateComponents()
        components.day = 1
        return cal.date(byAdding: components, to: self.startOfDay)!.addingTimeInterval(-1)
    }
    
    var zeroBasedDayOfWeek: Int? {
        let comp = Calendar.current.component(.weekday, from: self)
        return comp - 1
    }
    
    func hoursFrom(_ date: Date) -> Double {
        return Double(Calendar.current.dateComponents([.hour], from: date, to: self).hour!)
    }
    
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.startOfDay, to: date.startOfDay)
        
        return components.day!
    }
    
    var percentageOfDay: Double {
        let totalSeconds = self.endOfDay.timeIntervalSince(self.startOfDay) + 1
        let seconds = self.timeIntervalSince(self.startOfDay)
        let percentage = seconds / totalSeconds
        return max(min(percentage, 1.0), 0.0)
    }
    
    var numberOfWeeksInMonth: Int {
        let calendar = Calendar.current
        let weekRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.weekOfYear, in: NSCalendar.Unit.month, for: self)
        
        return weekRange.length
    }
}
