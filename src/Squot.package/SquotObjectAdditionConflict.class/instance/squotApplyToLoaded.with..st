Squot-diff-patching
squotApplyToLoaded: anObject with: aPatcher
	"Modify anObject such that it matches what I model and answer the modified object, even if it was modified in-place."
	choice ifNil: [self error: 'Conflict must be resolved first'].
	^ aPatcher rematerialize: (self instVarNamed: choice)