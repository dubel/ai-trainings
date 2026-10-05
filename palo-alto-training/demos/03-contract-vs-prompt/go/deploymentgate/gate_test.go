package deploymentgate

import (
	"testing"
)

func TestBaselineDeploymentGate(t *testing.T) {
	tests := []struct {
		name        string
		input       Input
		wantAllowed bool
		wantReason  string
		wantErr     bool
	}{
		{
			name: "staging passed",
			input: Input{
				Environment:     "staging",
				TestStatus:      "passed",
				ReleaseApproved: false,
				ActiveIncidents: 0,
			},
			wantAllowed: true,
			wantReason:  "ready",
		},
		{
			name: "production passed with approval",
			input: Input{
				Environment:     "production",
				TestStatus:      "passed",
				ReleaseApproved: true,
				ActiveIncidents: 0,
			},
			wantAllowed: true,
			wantReason:  "ready",
		},
		{
			name: "production without approval",
			input: Input{
				Environment:     "production",
				TestStatus:      "passed",
				ReleaseApproved: false,
				ActiveIncidents: 0,
			},
			wantAllowed: false,
			wantReason:  "release-not-approved",
		},
		{
			name: "active incidents blocks",
			input: Input{
				Environment:     "staging",
				TestStatus:      "passed",
				ReleaseApproved: true,
				ActiveIncidents: 2,
			},
			wantAllowed: false,
			wantReason:  "active-incident",
		},
		{
			name: "failed tests blocks",
			input: Input{
				Environment:     "production",
				TestStatus:      "failed",
				ReleaseApproved: true,
				ActiveIncidents: 0,
			},
			wantAllowed: false,
			wantReason:  "tests-not-passed",
		},
		{
			name: "negative incidents error",
			input: Input{
				Environment:     "development",
				TestStatus:      "passed",
				ReleaseApproved: true,
				ActiveIncidents: -1,
			},
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := Evaluate(tt.input)
			if (err != nil) != tt.wantErr {
				t.Fatalf("Evaluate() error = %v, wantErr %v", err, tt.wantErr)
			}
			if !tt.wantErr {
				if got.Allowed != tt.wantAllowed {
					t.Errorf("got allowed %v, want %v", got.Allowed, tt.wantAllowed)
				}
				if got.Reason != tt.wantReason {
					t.Errorf("got reason %q, want %q", got.Reason, tt.wantReason)
				}
			}
		})
	}
}
