# Instructor Notes — Demo 04

## Didactic Goal
Show why a vague prompt fails on legacy C++ (adds heap memory, new interfaces, C++20 features that break MSVC 2017) and Go (adds goroutines, channels, unnecessary third-party dependencies), whereas a specification contract keeps the diff minimal, pure, and backward-compatible.

## Comparison Points between Run A and Run B

| Dimension | Run A (Vague Prompt) | Run B (Spec Contract) |
|---|---|---|
| **Abstractions** | Often invents `IRiskPolicy`, `RiskEvaluatorFactory`, or strategy patterns | Single pure extension in existing `evaluate_deployment` |
| **Allocations** | Frequently introduces `std::make_shared` or string manipulation | Zero heap allocations; uses enums and value types |
| **Toolchain** | May attempt C++20 concepts/ranges or non-MSVC-compatible features | Clean C++17 compatible with MSVC `/W4 /WX` |
| **Signatures** | Sometimes alters existing parameters breaking callers | Extends struct fields with defaults, preserving callers |

## Reference Solution (C++)

### Header (`deployment_gate.hpp` extension):
```cpp
enum class ChangeRisk { Low, Medium, High };

struct DeploymentInput {
    Environment environment;
    TestStatus test_status;
    bool release_approved;
    int active_incidents{0};
    ChangeRisk change_risk{ChangeRisk::Low};
    bool architecture_approved{false};
};
```

### Implementation (`deployment_gate.cpp`):
```cpp
    if (input.change_risk == ChangeRisk::High && 
        input.environment == Environment::Production && 
        !input.architecture_approved) {
        return {false, "architecture-not-approved"};
    }
```

## Reference Solution (Go)

### `gate.go`:
```go
type Input struct {
	Environment          string
	TestStatus           string
	ReleaseApproved      bool
	ActiveIncidents      int
	ChangeRisk           string
	ArchitectureApproved bool
}

// In Evaluate():
if input.ChangeRisk == "high" && input.Environment == "production" && !input.ArchitectureApproved {
    return Decision{Allowed: false, Reason: "architecture-not-approved"}, nil
}
```
