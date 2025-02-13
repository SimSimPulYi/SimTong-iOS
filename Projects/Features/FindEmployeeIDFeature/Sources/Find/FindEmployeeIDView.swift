import SwiftUI
import DesignSystem

public struct FindEmployeeIDView: View {
    private enum FocusField: Hashable {
        case name
        case email
    }
    @StateObject var viewModel: FindEmployeeIDViewModel
    @FocusState private var focusField: FocusField?

    let employeeIDSpotListComponent: EmployeeIDSpotListComponent
    let employeeIDResultComponent: EmployeeIDResultComponent

    public init(
        viewModel: FindEmployeeIDViewModel,
        employeeIDSpotListComponent: EmployeeIDSpotListComponent,
        employeeIDResultComponent: EmployeeIDResultComponent
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.employeeIDSpotListComponent = employeeIDSpotListComponent
        self.employeeIDResultComponent = employeeIDResultComponent
    }

    public var body: some View {
        VStack(spacing: 8) {
            STTextField("이름을 입력해주세요", text: $viewModel.name, style: .clear, isError: viewModel.isError, onCommit: {
                focusField = .email
            })
            .focused($focusField, equals: .name)
            .padding(.top, 64)

            STTextField("E-mail을 입력해주세요", text: $viewModel.email, style: .clear, isError: viewModel.isError, onCommit: {
                focusField = nil
                viewModel.isPresentedSpotList = true
            })
            .focused($focusField, equals: .email)

            Group {
                STTextField(
                    "근무지점을 선택해주세요",
                    text: $viewModel.spot,
                    errorText: viewModel.errorMessage,
                    isError: viewModel.isError
                )
                .disabled(true)
            }
            .onTapGesture {
                viewModel.isPresentedSpotList.toggle()
            }

            CTAButton(text: "확인") {
                viewModel.findID()
            }
            .padding(.top, 32)
            .disabled(!viewModel.isFormValid)

            Spacer()
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $viewModel.isPresentedSpotList) {
            employeeIDSpotListComponent.makeView(selectedSpot: viewModel.selectedSpot) { spot in
                viewModel.selectedSpot = spot
                viewModel.spot = spot.name
            }
        }
        .navigate(
            to: employeeIDResultComponent.makeView(username: viewModel.name, resultID: viewModel.resultID),
            when: $viewModel.isNavigateResultID
        )
    }
}
