actions
mergeVersionIntoActiveBranch: mergeHeadCommit ifCanceled: cancelBlock
	| selectedProject |
	selectedProject := self projectSelection.
	selectedProject
		mergeVersionInteractively: mergeHeadCommit
		ifCanceled: [^ cancelBlock value].
	selectedProject loadedHistorian version
		 ifNil: ["new branch that got an ancestor now"
			selectedProject loadedHistorian version: mergeHeadCommit.
			selectedProject loadedVersion: mergeHeadCommit.
			^ self].
	(selectedProject loadedHistorian version = mergeHeadCommit)
		ifTrue: ["fast-forward merge" ^ self].
	[self actionCommit]
		on: SquotInitialLogMessageRequested
		do: [:request | request isNested
			ifTrue: [request pass]
			ifFalse: [request resume: 'Merge branch ', selectedHistorian shortName]].