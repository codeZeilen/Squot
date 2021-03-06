navigating
relativeToPath: aPath
	"Return the receiver as relative to the argument aPath"
	
	"(FSPath / 'griffle' / 'plonk' / 'nurp') 
		relativeToPath: (FSPath / 'griffle') 
			returns  plonk/nurp"

	| prefix relative |
	prefix := self lengthOfStemWith: aPath.
	relative := FSRelativePath parents: (aPath size - prefix).
	prefix + 1 to: self size do: [:i | relative := relative / (self at: i)].
	^ relative