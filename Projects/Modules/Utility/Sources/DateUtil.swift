import Foundation

public extension String {
    func toSimtongDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.date(from: self) ?? .init()
    }

    func toSmallSimtongDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.date(from: self) ?? .init()
    }
}

public extension Date {
    func toSimtongDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.string(from: self)
    }

    func toSmallSimtongDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.string(from: self)
    }

    func isSameDay(_ target: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: target)
    }

    func adding(by component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }

    func fetchAllDatesInCurrentMonth() -> [Date] {
        let calendar = Calendar.current

        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? .init()
        let range = calendar.range(of: .day, in: .month, for: self) ?? .init(uncheckedBounds: (1, 28))
        return range.compactMap {
            return calendar.date(byAdding: .day, value: $0 - 1, to: startDate)
        }
    }

    func fetchAllDatesInCurrentMonthWithPrevNext() -> [Date] {
        let calendar = Calendar.current
        var days = self.fetchAllDatesInCurrentMonth()

        let prevDate = self.adding(by: .month, value: -1)
        var prevDays = prevDate.fetchAllDatesInCurrentMonth()
        let firstWeekDay = calendar.component(.weekday, from: days.first ?? .init())
        for _ in 0..<firstWeekDay - 1 {
            days.insert(prevDays.popLast() ?? .init(), at: 0)
        }

        let nextDate = self.adding(by: .month, value: 1)
        var nextDays = nextDate.fetchAllDatesInCurrentMonth()
        let lastWeekDay = calendar.component(.weekday, from: days.last ?? .init())
        for _ in 0..<7 - lastWeekDay {
            days.append(nextDays.removeFirst())
        }

        return days
    }

    func fetchAllDatesInCurrentWeek() -> [Date] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: self)
        return calendar.range(of: .weekday, in: .weekOfMonth, for: self)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: self) }
    }

    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = .init(identifier: "UTC")
        return formatter.string(from: self)
    }
}

public extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }

    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
}
