Object
instVarAt: offset put: anObject
	^ self withArgs: {offset. anObject} executeMethod: (Object >> #instVarAt:put:)