//
//  RemoveImage.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/6.
//

import SwiftUI
import SDWebImage
struct RemoveImage: View {
    var url: String = ""
    var placeholderImage: UIImage? = nil
    
    var body: some View {
        if url.count > 0 {
            RemoveImageInnerView(url: url,placeholderImage: placeholderImage)
        } else {
            Text("")
        }
            
    }
}

struct RemoveImageInnerView: View {
    
    @State private var remoteImgage: UIImage? = nil
    
    var url: String
    
    var placeholderImage: UIImage? = nil
    
    var body: some View {
        Image(uiImage: self.remoteImgage ?? self.placeholderImage ?? UIImage())
            .resizable()
            .clipped()
            .onAppear {
                fetchRemoveImage()
            }
            
    }
    
    func fetchRemoveImage() {
        guard let tempUrl = URL(string: url) else { return }
        
        Task { @MainActor in
            do {
                self.remoteImgage = try await SDWebImageManager.shared.loadImage(with: tempUrl)
            } catch {
                print(error)
            }
        }
    }
}

struct RemoveImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoveImage(url: "")
    }
}


extension SDWebImageManager {
    
    @MainActor
    func store(image: UIImage, data: Data, for url: URL) async throws {
        try await withCheckedThrowingContinuation({ c in
            self.imageCache.store(image, imageData: data, forKey: self.cacheKey(for: url), cacheType: .all) {
                c.resume()
            }
        })
    }
    
    @MainActor
    func loadImage(with url: URL?) async throws -> UIImage {
        class OperationWrapper: @unchecked Sendable {
            private var operation: SDWebImageOperation?
            func updateOperation(_ operation: SDWebImageOperation?) {
                DispatchQueue.main.async {
                    self.operation = operation
                }
            }
            func cancelOperation() {
                DispatchQueue.main.async {
                    self.operation?.cancel()
                }
            }
        }
        let operationWrapper = OperationWrapper()
        return try await withTaskCancellationHandler(operation: {
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation({ c in
                let operation = SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (uiImage, _, error, _, _, _) in
                    if let image = uiImage {
                        c.resume(returning: image)
                    } else if let err = error {
                        c.resume(throwing: err)
                    } else {
                        c.resume(throwing: DescriptiveError("[CoImageLoading] 未知错误"))
                    }
                }
                operationWrapper.updateOperation(operation)
            })
        }, onCancel: {
            operationWrapper.cancelOperation()
        })
    }
    
    @MainActor
    func loadImageData(with url: URL?) async throws -> Data {
        class OperationWrapper: @unchecked Sendable {
            private var operation: SDWebImageOperation?
            func updateOperation(_ operation: SDWebImageOperation?) {
                DispatchQueue.main.async {
                    self.operation = operation
                }
            }
            func cancelOperation() {
                DispatchQueue.main.async {
                    self.operation?.cancel()
                }
            }
        }
        let operationWrapper = OperationWrapper()
        return try await withTaskCancellationHandler(operation: {
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation({ c in
                let operation = SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (uiImage, data, error, _, _, _) in
                    if let image = data {
                        c.resume(returning: image)
                    } else if let err = error {
                        c.resume(throwing: err)
                    } else {
                        c.resume(throwing: DescriptiveError("[CoImageLoading] 未知错误"))
                    }
                }
                operationWrapper.updateOperation(operation)
            })
        }, onCancel: {
            operationWrapper.cancelOperation()
        })
    }

}

struct DescriptiveError: Hashable, LocalizedError {
    let errorDescription: String?
    init(_ info: String) {
        self.errorDescription = info
    }
}
