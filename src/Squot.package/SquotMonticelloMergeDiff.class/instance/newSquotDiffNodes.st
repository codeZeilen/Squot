converting
newSquotDiffNodes
	| operationNodes classNodes nodesWithClass rest nodesByClassification topNodes |
	operationNodes := Array streamContents: [:nodes |
		operations do: [:each |
			nodes nextPut: each definition -> (SquotDiffNode
				title: each squotDiffNodeSummary
				content: each
				children: #())].
		conflicts do: [:each |
			nodes nextPut: each definition -> (SquotMergeDiffNode
				title: each operation squotDiffNodeSummary
				content: each
				children: #())]].
	nodesWithClass := operationNodes select: [:each "definition -> node" |
		each key respondsTo: #isCodeDefinition].
	classNodes :=
		((nodesWithClass groupBy: [:each "definition -> node" | each key className])
		collect: [:eachGroup "(definition -> node)*" | | classOperation |
			"lift class definition changes to the top of each group"
			classOperation := eachGroup detect: [:each | each key isClassDefinition] ifNone: [].
			classOperation
				ifNil: [eachGroup]
				ifNotNil: [{classOperation}, (eachGroup copyWithout: classOperation)]])
		associations collect: [:each "className -> (definition -> node)*" |
			SquotDiffNode
				title: each key
				content: nil
				children: (each value collect: [:pair | pair value])].
	rest := operationNodes difference: nodesWithClass.
	nodesByClassification :=
		(rest groupBy: [:each "definition -> node" |
			each key class allSelectors
				detect: [:selector | ('is*Definition' match: selector) and:
							[(each key perform: selector) == true]]
				ifNone: ['other']])
		associations collect: [:each "selector -> (definition -> node)*" | | selector |
			selector := each key.
			SquotDiffNode
				title: (selector = 'other'
					ifTrue: [selector]
					ifFalse: [selector copyFrom: 3 to: selector size - 'Definition' size])
				content: nil
				children: (each value collect: [:pair | pair value])].
	topNodes := classNodes, nodesByClassification.
	^ topNodes