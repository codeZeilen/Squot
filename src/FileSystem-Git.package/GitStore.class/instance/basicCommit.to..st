internal
basicCommit: aMessage to: branchName
	| commit |
	"Disallow empty commits"
	modManager hasModifications ifFalse: [ ^ self ].
	(commit := self prepareNewCommit)
		message: aMessage;
		store.
	repository 
		updateRef: repository headsDir / branchName 
		to: commit hexHash
		message: 'commit: ', aMessage asString.
	self revision: commit. "calls basicReset and discards the cached files!"