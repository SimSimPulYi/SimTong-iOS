import SwiftUI
import PhotosUI

public extension View {
    func imagePicker(
        isShow: Binding<Bool>,
        completion: @escaping (UIImage?) -> Void = { _ in },
        uiImage: Binding<UIImage?>
    ) -> some View {
        self
            .sheet(isPresented: isShow) {
                ImagePicker(configuration: .init(photoLibrary: .shared()), completion: completion, requests: uiImage)
            }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    let completion: (UIImage?) -> Void
    @Binding var requests: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = configuration
        config.filter = .images
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                let provider = result.itemProvider
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.completion(image)
                                self?.parent.requests = image
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}
