#pragma once

#include <string>

namespace demo03 {

enum class Environment { Development, Staging, Production };
enum class TestStatus { Passed, Failed, Skipped };

struct DeploymentInput {
    Environment environment;
    TestStatus test_status;
    bool release_approved;
    int active_incidents{0};
};

struct GateDecision {
    bool allowed;
    std::string reason;
};

GateDecision evaluate_deployment(const DeploymentInput& input);

}  // namespace demo03
