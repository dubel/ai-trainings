package deploymentgate

import "fmt"

type Input struct {
	Environment     string
	TestStatus      string
	ReleaseApproved bool
	ActiveIncidents int
}

type Decision struct {
	Allowed bool
	Reason  string
}

func Evaluate(input Input) (Decision, error) {
	if input.Environment != "development" && input.Environment != "staging" && input.Environment != "production" {
		return Decision{}, fmt.Errorf("invalid environment: %s", input.Environment)
	}
	if input.TestStatus != "passed" && input.TestStatus != "failed" && input.TestStatus != "skipped" {
		return Decision{}, fmt.Errorf("invalid test status: %s", input.TestStatus)
	}
	if input.ActiveIncidents < 0 {
		return Decision{}, fmt.Errorf("active incidents must be non-negative")
	}
	if input.TestStatus != "passed" {
		return Decision{Allowed: false, Reason: "tests-not-passed"}, nil
	}
	if input.ActiveIncidents > 0 {
		return Decision{Allowed: false, Reason: "active-incident"}, nil
	}
	if input.Environment == "production" && !input.ReleaseApproved {
		return Decision{Allowed: false, Reason: "release-not-approved"}, nil
	}
	return Decision{Allowed: true, Reason: "ready"}, nil
}
