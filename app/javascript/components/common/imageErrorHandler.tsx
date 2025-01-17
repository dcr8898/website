import { assetUrl } from '../../utils/assets'

const errorIcon = assetUrl('graphics/missing-exercise.svg')

export const imageErrorHandler = (
  e: React.SyntheticEvent<HTMLImageElement, Event>
) => {
  const el = e.target as HTMLImageElement
  if ((el.src = errorIcon)) {
    return
  }
  el.onerror = null
  el.src = errorIcon
}
