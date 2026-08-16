# 🚀 Zoron Performance & FPS Booster iOS Framework

A standalone Swift iOS performance tweak that hooks into Alight Motion's rendering loops, thread schedulers, and memory policies to unlock buttery-smooth 120Hz ProMotion and instant timeline scrubbing.

---

## 🌟 Optimizations Included:

1. **120Hz ProMotion Unlocker:** Forces 120 FPS frame pacing on `CADisplayLink` across all timeline scrubbing and playback on supported devices (iPhone 13 Pro+, iPad Pro).
2. **Real-Time CPU/GPU Priority (QoS):** Elevates rendering threads to `QOS_CLASS_USER_INTERACTIVE` so iOS gives Alight Motion maximum hardware priority.
3. **Smart Texture & RAM Cache Policy:** Expands in-memory cache capacities to 256MB+ to prevent premature layer cache evictions.
4. **Auto-Background Execution:** Starts automatically on app launch with zero setup needed.

---

## 🛠️ How to Build on GitHub (Free Cloud Build)

1. Create a new GitHub repository named `ZoronPerformanceBooster`.
2. Upload the contents of this `Zoron_PerformanceBooster_Swift_Project` folder to your repository.
3. Go to the **Actions** tab $\to$ select **"Build Zoron Performance Booster Framework"** $\to$ click **"Run workflow"**.
4. Download **`ZoronPerformanceBooster-iOS-Framework.zip`** from the Artifacts section!

---

## 📱 How to Inject with KSign:

1. Unzip `ZoronPerformanceBooster-iOS-Framework.zip` to get `ZoronPerformanceBooster.framework`.
2. Rename the binary file inside (`ZoronPerformanceBooster`) to `ZoronPerformanceBooster.dylib`.
3. In **KSign**, tap your Alight Motion IPA $\to$ **Signature** $\to$ **Add Dylib** $\to$ select `ZoronPerformanceBooster.dylib`.
4. Tap **Sign & Install**!
