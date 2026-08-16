import UIKit
import QuartzCore
import ObjectiveC

/**
 * ZoronProMotionUnlocker - Forces 120Hz UI rendering on supported devices
 */
public class ZoronProMotionUnlocker: NSObject {
    
    private static var hasSwizzled = false
    
    // Live Tracker
    public static var currentTargetFPS: Int = 120
    public static var onFPSUpdated: ((Int) -> Void)?
    
    public static func enable120FPS() {
        guard !hasSwizzled else { return }
        hasSwizzled = true
        
        let cls: AnyClass = CADisplayLink.self
        let sel = #selector(CADisplayLink.add(to:forMode:))
        
        guard let method = class_getInstanceMethod(cls, sel) else { return }
        
        let customFunction: @convention(c) (CADisplayLink, Selector, RunLoop, RunLoop.Mode) -> Void = { (selfObj, _cmd, runloop, mode) in
            // Force 120Hz on iOS 15+ devices
            if #available(iOS 15.0, *) {
                let maxFPS = Float(UIScreen.main.maximumFramesPerSecond)
                selfObj.preferredFrameRateRange = CAFrameRateRange(minimum: 60.0, maximum: maxFPS, preferred: maxFPS)
                ZoronProMotionUnlocker.currentTargetFPS = Int(maxFPS)
            } else {
                selfObj.preferredFramesPerSecond = UIScreen.main.maximumFramesPerSecond
                ZoronProMotionUnlocker.currentTargetFPS = UIScreen.main.maximumFramesPerSecond
            }
            
            // Call original implementation (Swizzled)
            let originalIMP = class_getMethodImplementation(cls, sel)
            typealias OriginalFunction = @convention(c) (CADisplayLink, Selector, RunLoop, RunLoop.Mode) -> Void
            let original = unsafeBitCast(originalIMP, to: OriginalFunction.self)
            original(selfObj, _cmd, runloop, mode)
            
            DispatchQueue.main.async {
                ZoronProMotionUnlocker.onFPSUpdated?(ZoronProMotionUnlocker.currentTargetFPS)
            }
        }
        
        let swizzledIMP: IMP = unsafeBitCast(customFunction, to: IMP.self)
        method_setImplementation(method, swizzledIMP)
        print("[ZoronPerformanceBooster] ⚡ 120Hz ProMotion Engine Hooked & Active!")
    }
}
