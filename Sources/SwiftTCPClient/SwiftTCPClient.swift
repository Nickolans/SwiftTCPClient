public struct SwiftTCPClient {
    private var client: TCPService
    
    /**
     Handles publishing incoming data values from socket.
     */
    public var publisher: NotificationCenter.Publisher

    public init(ip: String, port: String) {
        self.client = TCPService(ip: ip, port: port)
        self.publisher = self.client.publisher
    }
}
