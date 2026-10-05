# Task: Rate-Limited Retry Policy

Add support for handling the `RATE_LIMITED` failure code.

## Requirements

1. **Failure Code:** Handle `RateLimited` / `RATE_LIMITED`.
2. **Backoff Schedule:**
   - Attempt 1: 500 ms delay.
   - Attempt 2: 1000 ms delay.
   - Attempt 3: 2000 ms delay.
   - Attempt 4: 4000 ms delay.
   - Attempt 5 and above: Do NOT retry (`retry = false`, `delay = 0`).
3. **Existing Invariants:**
   - `AuthFailed` remains non-retryable at any attempt.
   - `Timeout` and `TemporaryUnavailable` retain their existing schedule (retry attempts 1 and 2, stop at 3).
   - Attempts < 1 must be rejected with an invalid argument error/exception.
4. **Constraints:**
   - The decision function must remain pure: calculate delay and retry flag only.
   - Do not invoke system sleep, threads, or logging.
