private protocol
requireStartTLS
	(self lastResponse includesSubString: 'STARTTLS')
		ifFalse: [ ^ self error: 'Server does not seem to support STARTTLS' ].
