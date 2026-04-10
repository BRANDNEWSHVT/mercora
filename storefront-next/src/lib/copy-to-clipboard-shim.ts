const copyToClipboard = (text: string) => {
  const selection = document.getSelection()
  const previousRanges =
    selection && typeof selection.rangeCount === "number"
      ? Array.from({ length: selection.rangeCount }, (_, index) =>
          selection.getRangeAt(index)
        )
      : []

  const mark = document.createElement("span")
  mark.textContent = text
  mark.style.all = "unset"
  mark.style.position = "fixed"
  mark.style.top = "0"
  mark.style.clip = "rect(0, 0, 0, 0)"
  mark.style.whiteSpace = "pre"
  mark.style.userSelect = "text"
  mark.ariaHidden = "true"

  document.body.appendChild(mark)

  const range = document.createRange()
  range.selectNodeContents(mark)

  selection?.removeAllRanges()
  selection?.addRange(range)

  let copied = false

  try {
    copied = document.execCommand("copy")
  } finally {
    selection?.removeAllRanges()
    previousRanges.forEach((previousRange) => selection?.addRange(previousRange))
    document.body.removeChild(mark)
  }

  return copied
}

export default copyToClipboard
