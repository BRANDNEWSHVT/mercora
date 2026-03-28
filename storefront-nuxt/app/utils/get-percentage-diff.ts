export function getPercentageDiff(original: number, calculated: number): string {
  const diff = original - calculated
  const percentage = (diff / original) * 100
  return percentage.toFixed(0)
}
