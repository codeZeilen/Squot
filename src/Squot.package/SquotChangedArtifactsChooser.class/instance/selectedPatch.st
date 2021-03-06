results
selectedPatch
	| adjustedDiffs rootNodesByArtifact |
	self accepted ifFalse: [^ SquotPatch empty].
	"Answer a patch that describes all selected DiffNodes."
	rootNodesByArtifact := Dictionary withAll:
		(rootNodes collect: [:each | (artifactDiffs at: each title) -> each]).
	adjustedDiffs := artifactDiffs collect: [:each |
		rootNodesByArtifact at: each
			ifPresent: [:node | self adjustedDiff: each byExclusionsBelow: node]
			ifAbsent: [each]].
	^ SquotPatch with: (adjustedDiffs select: [:each | each hasChanges])