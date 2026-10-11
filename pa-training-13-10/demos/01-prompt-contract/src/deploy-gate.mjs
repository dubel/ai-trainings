export function canDeploy({ environment, planHasDestroy, approvals }) {
  if (planHasDestroy) return approvals >= 2;
  return environment === "production" ? approvals >= 1 : true;
}

