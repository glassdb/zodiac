initialize-release
close
	"Close the stream, flush if necessary. 
	Destory the SSLSession object."

	super close.
	sslSession isNil ifTrue: [ ^ self ]. 
	sslSession destroy.
	sslSession := nil