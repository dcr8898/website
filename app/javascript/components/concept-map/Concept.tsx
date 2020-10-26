import React, { useEffect, useRef, useState, MouseEventHandler } from 'react'
import { CompleteIcon } from './CompleteIcon'

import { IConcept, ConceptStatus } from './concept-map-types'

import { emitConceptElement } from './helpers/concept-element-svg-handler'
import {
  addVisibilityListener,
  removeVisibilityListener,
  Visibility,
} from './helpers/concept-visibility-handler'
import { wrapAnimationFrame } from './helpers/animation-helpers'

export const Concept = ({
  slug,
  name,
  web_url,
  handleEnter,
  handleLeave,
  status,
  isActive,
}: IConcept & {
  handleEnter: MouseEventHandler
  handleLeave: MouseEventHandler
  status: ConceptStatus
  isActive: boolean
}) => {
  const [visibility, setVisibility] = useState<Visibility>('hidden')
  const conceptRef = useRef(null)

  useEffect(() => {
    const current = conceptRef.current
    emitConceptElement(slug, current)
    addVisibilityListener(setVisibility)
    return () => {
      emitConceptElement(slug)
      removeVisibilityListener(setVisibility)
    }
  }, [slug, conceptRef])

  // Build the class list
  let classes = ['card']
  classes.push(`card-${status}`)
  if (isActive) {
    classes.push('card-active')
  }
  if (visibility === 'hidden') {
    classes.push('hidden')
  }

  return (
    <a
      ref={conceptRef}
      href={web_url}
      id={conceptSlugToId(slug)}
      className={classes.join(' ')}
      data-concept-slug={slug}
      data-concept-status={status}
      onMouseEnter={wrapAnimationFrame(handleEnter)}
      onMouseLeave={wrapAnimationFrame(handleLeave)}
    >
      <div className="display">
        <div className="name">{name}</div>
        <CompleteIcon show={'completed' === status} />
      </div>
    </a>
  )
}

export const PureConcept = React.memo(Concept)

export function conceptExerciseSlugToId(slug: string): string {
  return `concept-exercise-${slug}`
}

export function conceptSlugToId(slug: string): string {
  return `concept-${slug}`
}