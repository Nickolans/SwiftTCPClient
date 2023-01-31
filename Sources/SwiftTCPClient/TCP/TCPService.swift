//
//  TCPService.swift
//  
//
//  Created by Nickolans Griffith on 1/30/23.
//

import Foundation
import NIO
import Combine

@available(iOS 13.0, *)
final class TCPService {
    
    private let ip: String
    private let port: String
    private let autoreconnect: Bool
    
    static var shared: TCPService?
    
    public var publisher = NotificationCenter.Publisher(center: .default, name: Constants.Notifications.readName)
    
    /**
     Owns single file descriptor we will interact with and manages its lifetime.
     */
    private var channel: Channel?
    
    /**
     This manages and create our event loops.
     */
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    /**
     Higher-level abstraction for the registering of channels with event loops.
     */
    private var bootstrap: ClientBootstrap {
        return ClientBootstrap(group: group)
            .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .channelInitializer { channel in
                channel.pipeline.addHandler(TCPClientHandler())
            }
    }
    
    init(ip: String, port: String, autoreconnect: Bool) {
        self.ip = ip
        self.port = port
        self.autoreconnect = autoreconnect
    }
    
    public func disconnect() {
        self.channel?.close(mode: .all, promise: nil)
    }
}

//
//   ╔══════════════════════════════════════════════╗
// ╔══════════════════════════════════════════════════╗
// ║                                                  ║
// ║  HANDLERS                                        ║
// ║                                                  ║
// ╚══════════════════════════════════════════════════╝
//   ╚══════════════════════════════════════════════╝
//

@available(iOS 13.0, *)
extension TCPService {
    func startTCPNIO() throws {
        do {
            self.channel = try bootstrap.connect(host: self.ip, port: Int(self.port)!).wait()
        } catch let error {
            throw error
        }
    }
    
    func sendTestMessage(_ message: String) {
        print("Sending Message: \(message)")
        let buffer: ByteBuffer = ByteBuffer(string: message)
        
        guard let channel = channel else {
            print("Channel Not Found")
            return
        }
        
        _ = channel.writeAndFlush(buffer)
    }
}

//
//   ╔══════════════════════════════════════════════╗
// ╔══════════════════════════════════════════════════╗
// ║                                                  ║
// ║  TEST FUNCTIONS                                 ║
// ║                                                  ║
// ╚══════════════════════════════════════════════════╝
//   ╚══════════════════════════════════════════════╝
//

@available(iOS 13.0, *)
extension TCPService {
    private func sendRepeatingMessage(withInterval seconds: UInt32, message: String) {
        while (true) {
            sleep(seconds)
            self.sendTestMessage(message)
        }
    }
}
