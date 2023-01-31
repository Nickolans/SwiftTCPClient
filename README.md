# SwiftTCPClient

Simple Swfit TCP client using SwiftNIO and Combine.

## Usage

```swift
// Create client
self.client = SwiftTCPClient(ip: ip, port: port)

// Subscribe to incoming data
self.subscriber = self.client.publisher.sink { data in
  guard let data = data.object as? Data else { return }
  // Use data...
}

// Start client
self.client.start()

// Send string message
self.client.sendStringMessage("Hello!")

// Close client
self.client.close()
```
