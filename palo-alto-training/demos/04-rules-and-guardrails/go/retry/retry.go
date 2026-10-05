package retry

import "fmt"

type FailureCode string

const (
	Timeout              FailureCode = "timeout"
	TemporaryUnavailable FailureCode = "temporary_unavailable"
	AuthFailed           FailureCode = "auth_failed"
	RateLimited          FailureCode = "rate_limited"
)

type Decision struct {
	Retry   bool
	DelayMs int
}

func DecideRetry(code FailureCode, attempt int) (Decision, error) {
	if attempt < 1 {
		return Decision{}, fmt.Errorf("attempt must be a positive integer, got %d", attempt)
	}
	if code == AuthFailed {
		return Decision{Retry: false, DelayMs: 0}, nil
	}
	retryable := code == Timeout || code == TemporaryUnavailable
	if !retryable || attempt >= 3 {
		return Decision{Retry: false, DelayMs: 0}, nil
	}
	return Decision{Retry: true, DelayMs: attempt * 1000}, nil
}
