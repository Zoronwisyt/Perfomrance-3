import Foundation

/**
 * ZoronThreadPriorityBooster - Elevates rendering & compositing queue priority to UserInteractive.
 */
public class ZoronThreadPriorityBooster {

    public static func boostProcessPriority() {
        // Boost main thread priority
        Thread.main.threadPriority = 1.0

        // Configure global user-interactive render queues
        DispatchQueue.global(qos: .userInteractive).async {
            Thread.current.threadPriority = 0.95
            print("[ZoronPerformanceBooster] Real-time CPU rendering priority active! ⚡")
        }
    }
}
