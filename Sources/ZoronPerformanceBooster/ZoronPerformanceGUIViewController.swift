import UIKit

/**
 * ZoronPerformanceGUIViewController - Glassmorphic Performance Dashboard
 */
public class ZoronPerformanceGUIViewController: UIViewController {

    private let blurCard = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    private let fpsBadge = UIView()
    private let fpsLabel = UILabel()
    
    private let memoryBadge = UIView()
    private let memoryLabel = UILabel()
    
    private let clearRAMButton = UIButton(type: .system)
    private let logsTextView = UITextView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        ZoronProMotionUnlocker.onFPSUpdated = { [weak self] fps in
            self?.fpsLabel.text = "⚡ Target FPS: \(fps)Hz"
            self?.addLog("ProMotion Frame Rate unlocked to \(fps)Hz")
        }
        
        ZoronMemoryOptimizer.onMemoryCleared = { [weak self] clearedMB in
            self?.memoryLabel.text = "🧠 Memory Freed: \(String(format: "%.1f", ZoronMemoryOptimizer.totalClearedMB)) MB"
            self?.addLog("Garbage Collection: Freed \(String(format: "%.1f", clearedMB)) MB")
        }
        
        // Initial setup state
        fpsLabel.text = "⚡ Target FPS: \(ZoronProMotionUnlocker.currentTargetFPS)Hz"
        memoryLabel.text = "🧠 Memory Freed: \(String(format: "%.1f", ZoronMemoryOptimizer.totalClearedMB)) MB"
        addLog("Performance Engine Initialized")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        blurCard.layer.cornerRadius = 24
        blurCard.clipsToBounds = true
        blurCard.layer.borderWidth = 1.0
        blurCard.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        blurCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurCard)
        
        let content = blurCard.contentView
        
        titleLabel.text = "⚡ ZORON PERFORMANCE"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(titleLabel)
        
        subtitleLabel.text = "120FPS Unlocker & Memory Optimizer"
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        subtitleLabel.textColor = UIColor(white: 0.75, alpha: 1.0)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(subtitleLabel)
        
        closeButton.setTitle("✕", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(closeButton)
        
        setupBadge(badge: fpsBadge, label: fpsLabel, parent: content, color: UIColor(red: 0.05, green: 0.8, blue: 0.4, alpha: 1.0))
        setupBadge(badge: memoryBadge, label: memoryLabel, parent: content, color: UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0))
        
        clearRAMButton.setTitle("🧹 Force Clear RAM Cache", for: .normal)
        clearRAMButton.backgroundColor = UIColor(red: 0.85, green: 0.15, blue: 0.45, alpha: 0.9)
        clearRAMButton.setTitleColor(.white, for: .normal)
        clearRAMButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        clearRAMButton.layer.cornerRadius = 12
        clearRAMButton.addTarget(self, action: #selector(didTapClearRAM), for: .touchUpInside)
        clearRAMButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(clearRAMButton)
        
        logsTextView.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
        logsTextView.textColor = UIColor(red: 0.4, green: 0.9, blue: 1.0, alpha: 1.0)
        logsTextView.font = UIFont.monospacedSystemFont(ofSize: 10, weight: .bold)
        logsTextView.isEditable = false
        logsTextView.layer.cornerRadius = 12
        logsTextView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(logsTextView)
        
        NSLayoutConstraint.activate([
            blurCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurCard.widthAnchor.constraint(equalToConstant: 340),
            blurCard.heightAnchor.constraint(equalToConstant: 450),
            
            titleLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -18),
            
            fpsBadge.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            fpsBadge.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            fpsBadge.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -18),
            fpsBadge.heightAnchor.constraint(equalToConstant: 38),
            
            memoryBadge.topAnchor.constraint(equalTo: fpsBadge.bottomAnchor, constant: 12),
            memoryBadge.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            memoryBadge.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -18),
            memoryBadge.heightAnchor.constraint(equalToConstant: 38),
            
            clearRAMButton.topAnchor.constraint(equalTo: memoryBadge.bottomAnchor, constant: 24),
            clearRAMButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            clearRAMButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -18),
            clearRAMButton.heightAnchor.constraint(equalToConstant: 44),
            
            logsTextView.topAnchor.constraint(equalTo: clearRAMButton.bottomAnchor, constant: 20),
            logsTextView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 18),
            logsTextView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -18),
            logsTextView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -18)
        ])
    }
    
    private func setupBadge(badge: UIView, label: UILabel, parent: UIView, color: UIColor) {
        badge.backgroundColor = color.withAlphaComponent(0.2)
        badge.layer.cornerRadius = 10
        badge.layer.borderWidth = 1
        badge.layer.borderColor = color.withAlphaComponent(0.6).cgColor
        badge.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(badge)
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        badge.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: badge.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: badge.centerYAnchor)
        ])
    }
    
    @objc private func didTapClearRAM() {
        ZoronMemoryOptimizer.forceGarbageCollection()
    }
    
    private func addLog(_ message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let time = formatter.string(from: Date())
        
        let newLog = "[\(time)] \(message)\n"
        logsTextView.text = newLog + (logsTextView.text ?? "")
    }
    
    @objc private func didTapClose() {
        ZoronOverlayWindow.shared.toggleMenu()
    }
}
