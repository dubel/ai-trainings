#include "deployment_gate.hpp"

#include <stdexcept>

namespace demo03 {

GateDecision evaluate_deployment(const DeploymentInput& input) {
    if (input.active_incidents < 0) {
        throw std::invalid_argument("active_incidents must be non-negative");
    }
    if (input.test_status != TestStatus::Passed) {
        return {false, "tests-not-passed"};
    }
    if (input.active_incidents > 0) {
        return {false, "active-incident"};
    }
    if (input.environment == Environment::Production && !input.release_approved) {
        return {false, "release-not-approved"};
    }
    return {true, "ready"};
}

}  // namespace demo03
