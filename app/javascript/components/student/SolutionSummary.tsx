import React, { useEffect } from 'react'
import { Header } from './solution-summary/Header'
import { IterationLink } from './solution-summary/IterationLink'
import { CommunitySolutions } from './solution-summary/CommunitySolutions'
import { Mentoring } from './solution-summary/Mentoring'
import { Nudge } from './solution-summary/Nudge'
import { Loading, ProminentLink } from '../common'
import { SolutionChannel } from '../../channels/solutionChannel'
import { usePaginatedRequestQuery } from '../../hooks/request-query'
import { useIsMounted } from 'use-is-mounted'
import { queryCache } from 'react-query'
import { Iteration } from '../types'

export type SolutionSummaryLinks = {
  testsPassLocallyArticle: string
  allIterations: string
  communitySolutions: string
  learnMoreAboutMentoringArticle: string
  mentoringInfo: string
  completeExercise: string
}

export type SolutionSummaryRequest = {
  endpoint: string
  options: {
    initialData: {
      iterations: readonly Iteration[]
    }
  }
}

export type SolutionSummarySolution = {
  id: string
  completedAt?: string
}

export const SolutionSummary = ({
  solution,
  request,
  isConceptExercise,
  links,
}: {
  solution: SolutionSummarySolution
  request: SolutionSummaryRequest
  isConceptExercise: boolean
  links: SolutionSummaryLinks
}): JSX.Element | null => {
  const isMountedRef = useIsMounted()
  const CACHE_KEY = `solution-${solution.id}-summary`
  const { resolvedData } = usePaginatedRequestQuery<{
    iterations: Iteration[]
  }>(CACHE_KEY, request, isMountedRef)

  useEffect(() => {
    const solutionChannel = new SolutionChannel(
      { id: solution.id },
      (response) => {
        queryCache.setQueryData(CACHE_KEY, response)
      }
    )

    return () => {
      solutionChannel.disconnect()
    }
  }, [CACHE_KEY, solution])

  if (status === 'loading') {
    return <Loading />
  }

  if (!resolvedData) {
    return null
  }

  const latestIteration =
    resolvedData.iterations[resolvedData.iterations.length - 1]

  return (
    <section className="latest-iteration">
      {solution.completedAt ? null : (
        <Nudge
          iteration={latestIteration}
          isConceptExercise={isConceptExercise}
          links={links}
        />
      )}
      <Header
        iteration={latestIteration}
        isConceptExercise={isConceptExercise}
        links={links}
      />
      <IterationLink iteration={latestIteration} />
      <ProminentLink
        link={links.allIterations}
        text="See all of your iterations"
      />
      <div className="next-steps">
        <CommunitySolutions link={links.communitySolutions} />
        <Mentoring link={links.learnMoreAboutMentoringArticle} />
      </div>
    </section>
  )
}