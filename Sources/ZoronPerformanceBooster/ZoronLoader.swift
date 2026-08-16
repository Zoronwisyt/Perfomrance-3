import UIKit

/**
 * ZoronLoader - Auto-initializing entrypoint hook for Performance Booster
 */
public final class ZoronLoader: NSObject {

    @objc public static let shared: ZoronLoader = {
        let instance = ZoronLoader()
        instance.setup()
        return instance
    }()

    private var retryTimer: Timer?

    private override init() {
        super.init()
    }

    private func setup() {
        // Enable performance hooks
        ZoronProMotionUnlocker.enable120FPS()
        ZoronMemoryOptimizer.enableOptimization()
        ZoronThreadPriorityBooster.boostProcessPriority()
        
        // Start aggressive timer to ensure UI shows up
        DispatchQueue.main.async {
            self.retryTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] timer in
                let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
                let activeScene = scenes.first(where: { $0.activationState == .foregroundActive }) ?? scenes.first
                
                if let scene = activeScene {
                    // Show the floating button
                    ZoronOverlayWindow.shared.present(in: scene)
                    self?.showSuccessAlert(in: scene)
                    timer.invalidate()
                }
            }
        }
    }
    
    private func showSuccessAlert(in scene: UIWindowScene) {
        if let root = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let alert = UIAlertController(title: "✅ Zoron Performance Active", message: "120FPS ProMotion & Memory Optimizer injected successfully into Alight Motion!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Boost Now!", style: .default))
            root.present(alert, animated: true)
        }
    }
}

// C-Bridge function that gets called by the C Constructor
@_cdecl("zoron_perf_swift_entry")
public func zoron_perf_swift_entry() {
    _ = ZoronLoader.shared
}
