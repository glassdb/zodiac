testing
testPlainClientWrite10k
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self socketStreamOn: clientSocket.
		dataRead := serverStream upToEnd.
		serverStream close.
		mySemaphore signal ].
	dataSent := self bytes: 10000.
	clientStream := self socketStreamClass openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	clientStream nextPutAll: dataSent.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait