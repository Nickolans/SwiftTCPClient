import NotificationCenter

@available(iOS 13.0, *)
public struct SwiftTCPClient {
    private var client: TCPService
    
    /**
     Handles publishing incoming data values from socket.
     */
    public var publisher: NotificationCenter.Publisher

    public init(ip: String, port: String, autoreconnect: Bool = false) {
        self.client = TCPService(ip: ip, port: port, autoreconnect: autoreconnect)
        self.publisher = self.client.publisher
    }
    
    public func start() {
        do {
            try self.client.startTCPNIO()
        } catch let error {
            print("TCP START ERROR: \(error.localizedDescription)")
        }
    }
    
    public func close() {
        self.client.disconnect()
    }
    
    public func sendStringMessage(_ message: String) {
        self.client.sendTestMessage(message)
    }
}
