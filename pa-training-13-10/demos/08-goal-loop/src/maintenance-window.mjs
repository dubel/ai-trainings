export function insideWindow(currentMinute, startMinute, endMinute) {
  return currentMinute >= startMinute && currentMinute <= endMinute;
}

