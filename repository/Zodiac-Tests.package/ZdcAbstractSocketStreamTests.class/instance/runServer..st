private
runServer: block
	| serverSocket semaphore |
	serverSocket := self serverSocketOn: self port.
	self assert: serverSocket notNil.
	self assert: serverSocket localPort = self port.
	semaphore := Semaphore new.
	[ 
		semaphore signal.
		[ block cull: serverSocket cull: semaphore ]
			ensure: [ 
				serverSocket closeAndDestroy. 
				semaphore signal ] 
	] forkAt: Processor userBackgroundPriority.
	semaphore wait.
	^ semaphore 
