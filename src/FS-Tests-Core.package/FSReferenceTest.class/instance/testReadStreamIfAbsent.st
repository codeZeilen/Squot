tests
testReadStreamIfAbsent
	| ref stream path |
	path := FSPath * 'plonk'.
	filesystem store createFile: path.
	ref := filesystem referenceTo: path.
	[ 
	stream := ref readStreamIfAbsent: [ self signalFailure: 'Should not reach here.' ].
	self assert: stream class = FSReadStream ] 
		ensure: [ stream ifNotNil: [ stream close ] ]