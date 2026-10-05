#include "deployment_gate.hpp"

#include <exception>
#include <iostream>
#include <stdexcept>
#include <string>

using demo03::DeploymentInput;
using demo03::Environment;
using demo03::GateDecision;
using demo03::TestStatus;

namespace {

void require(bool condition, const std::string& message) {
    if (!condition) {
        throw std::runtime_error(message);
    }
}

void require_decision(const GateDecision& actual, bool allowed, const std::string& reason) {
    require(actual.allowed == allowed, "unexpected allowed value: expected " + std::to_string(allowed));
    require(actual.reason == reason, "unexpected reason: expected '" + reason + "', got '" + actual.reason + "'");
}

}  // namespace

int main() {
    try {
        // Baseline checks
        require_decision(demo03::evaluate_deployment(
            {Environment::Staging, TestStatus::Passed, false, 0}), true, "ready");
        require_decision(demo03::evaluate_deployment(
            {Environment::Production, TestStatus::Passed, true, 0}), true, "ready");
        require_decision(demo03::evaluate_deployment(
            {Environment::Production, TestStatus::Passed, false, 0}), false, "release-not-approved");
        require_decision(demo03::evaluate_deployment(
            {Environment::Staging, TestStatus::Passed, true, 1}), false, "active-incident");
        require_decision(demo03::evaluate_deployment(
            {Environment::Production, TestStatus::Failed, true, 0}), false, "tests-not-passed");

        bool rejected = false;
        try {
            (void)demo03::evaluate_deployment(
                {Environment::Development, TestStatus::Passed, true, -1});
        } catch (const std::invalid_argument&) {
            rejected = true;
        }
        require(rejected, "negative incident count must be rejected");

        std::cout << "PASS: deployment gate baseline tests passed successfully\n";
        return 0;
    } catch (const std::exception& error) {
        std::cerr << "FAIL: " << error.what() << '\n';
        return 1;
    }
}
