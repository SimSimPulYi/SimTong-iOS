import DomainModule
import NeedleFoundation
import SwiftUI
import MyPageFeature

public protocol HomeDependency: Dependency {
    var fetchMenuListUseCase: any FetchMenuListUseCase { get }
    var fetchScheduleUseCase: any FetchScheduleUseCase { get }
    var fetchHolidayUseCase: any FetchHolidayUseCase { get }
    var checkIsHolidayPeriodUseCase: any CheckIsHolidayPeriodUseCase { get }
    var writeHolidayComponent: WriteHolidayComponent { get }
    var scheduleCalendarComponent: ScheduleCalendarComponent { get }
    var myPageComponent: MyPageComponent { get }
}

public final class HomeComponent: Component<HomeDependency> {
    public func makeView() -> some View {
        HomeView(
            viewModel: .init(
                fetchMenuListUseCase: dependency.fetchMenuListUseCase,
                fetchScheduleUseCase: dependency.fetchScheduleUseCase,
                fetchHolidayUseCase: dependency.fetchHolidayUseCase,
                checkIsHolidayPeriodUseCase: dependency.checkIsHolidayPeriodUseCase
            ),
            writeHolidayComponent: dependency.writeHolidayComponent,
            scheduleCalendarComponent: dependency.scheduleCalendarComponent,
            myPageComponent: dependency.myPageComponent
        )
    }
}
