import BaseFeature
import Combine
import DomainModule
import Foundation
import Utility

public final class HomeViewModel: BaseViewModel {
    @Published var currentMonth = Date()
    @Published var isPresentedHoliday = false
    @Published var isPresentedSchedule = false
    @Published var isPresentedMyPage = false
    @Published var isLoadingMeal = false
    @Published var holidaysDict: [String: HolidayType] = [:]
    @Published var schedules: [String: [ScheduleEntity]] = [:]
    @Published var menus: [MenuEntity] = []
    let salaryURL: URL = URL(
        string: Bundle.main.object(forInfoDictionaryKey: "SALARY_URL") as? String ?? ""
    ) ?? URL(string: "https://www.google.com")!
    private let fetchMenuListUseCase: any FetchMenuListUseCase
    private let fetchScheduleUseCase: any FetchScheduleUseCase
    private let fetchHolidayUseCase: any FetchHolidayUseCase
    private let checkIsHolidayPeriodUseCase: any CheckIsHolidayPeriodUseCase

    init(
        fetchMenuListUseCase: any FetchMenuListUseCase,
        fetchScheduleUseCase: any FetchScheduleUseCase,
        fetchHolidayUseCase: any FetchHolidayUseCase,
        checkIsHolidayPeriodUseCase: any CheckIsHolidayPeriodUseCase
    ) {
        self.fetchMenuListUseCase = fetchMenuListUseCase
        self.fetchScheduleUseCase = fetchScheduleUseCase
        self.fetchHolidayUseCase = fetchHolidayUseCase
        self.checkIsHolidayPeriodUseCase = checkIsHolidayPeriodUseCase
        super.init()
    }

    func homeDataInit() {
        Task {
            async let meal: () = fetchMeals()
            async let schedule: () = fetchSchedules()
            async let holiday: () = fetchHoliday()
            _ = await [meal, schedule, holiday]
        }
    }

    func onDateTap(date: Date) {
        isPresentedSchedule = true
    }

    @MainActor
    func writeHolidayButtonDidTap() {
        Task {
            await withAsyncTry(with: self) { owner in
                try await owner.checkIsHolidayPeriodUseCase.execute()
                owner.isPresentedHoliday = true
            }
        }
    }

    @MainActor
    func fetchSchedules() {
        Task {
            await withAsyncTry(with: self) { owner in
                owner.schedules = .init()
                let currentDates = owner.currentMonth.fetchAllDatesInCurrentMonthWithPrevNext()
                guard
                    let first = currentDates.first,
                    let last = currentDates.last
                else { return }
                let schedules = try await owner.fetchScheduleUseCase.execute(
                    start: first,
                    end: last
                )
                for schedule in schedules {
                    var start = schedule.startAt.toSmallSimtongDate()
                    let end = schedule.endAt.toSmallSimtongDate().adding(by: .day, value: 1)
                    if owner.schedules[schedule.startAt] == nil {
                        owner.schedules[schedule.startAt] = [schedule]
                    } else {
                        owner.schedules[schedule.startAt]?.append(schedule)
                    }
                    start = start.adding(by: .day, value: 1)
                    while !start.isSameDay(end) {
                        if owner.schedules[start.toSmallSimtongDateString()] == nil {
                            owner.schedules[start.toSmallSimtongDateString()] = [schedule]
                        } else {
                            owner.schedules[start.toSmallSimtongDateString()]?.append(schedule)
                        }

                        start = start.adding(by: .day, value: 1)
                    }
                }
            }
        }
    }

    @MainActor
    func fetchMeals() {
        Task {
            isLoadingMeal = true
            await withAsyncTry(with: self) { owner in
                let menus = try await owner.fetchMenuListUseCase.execute(
                    start: Date(),
                    end: Date().adding(by: .day, value: 7)
                )
                owner.menus = menus
                owner.isLoadingMeal = false
            }
        }
    }

    @MainActor
    func fetchHoliday() {
        Task {
            await withAsyncTry(with: self) { owner in
                let currentDates = owner.currentMonth.fetchAllDatesInCurrentMonthWithPrevNext()
                guard
                    let first = currentDates.first,
                    let last = currentDates.last
                else { return }
                let holidays = try await owner.fetchHolidayUseCase.execute(
                    start: first.toSmallSimtongDateString(),
                    end: last.toSmallSimtongDateString(),
                    status: .written
                )
                holidays.forEach { holiday in
                    owner.holidaysDict[holiday.date] = holiday.type
                }
            }
        }
    }
}
