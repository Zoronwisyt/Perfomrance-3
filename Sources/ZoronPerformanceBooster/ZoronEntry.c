#include <stdio.h>

// This references the Swift function we exposed
extern void zoron_perf_swift_entry(void);

// This tells iOS to run this function the EXACT millisecond the dylib is loaded into memory
__attribute__((constructor))
static void ZoronPerformanceDylibConstructor(void) {
    printf("[ZoronPerformanceBooster] C Constructor Fired! Waking up Swift performance engine...\n");
    zoron_perf_swift_entry();
}
