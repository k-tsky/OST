= Week 8 - Communication Protocols
== Key takeaways
=== How do network layers work?
Network layers provide services to the layer above them. Protocols allow an entity at one layer to interact with the same layer on another host.

Each PDU contains a protocol header and a payload, called the SDU.

=== What are the TCP mechanisms?
TCP is reliable and ordered. It uses retransmission, sequence numbers, ACKs, checksums, flow control, and congestion control.

Connections are established with SYN, SYN-ACK, ACK and terminated with FIN and ACK messages. Lost data can be detected with retransmission timeouts, duplicate ACKs, and selective ACKs.

=== What are the problems of TCP, and how other protocols (HTTP/3) can improve that
TCP handshakes are not very flexible and can require multiple round trips, especially with TLS and DNS. TCP also requires packets to arrive in order, so one missing packet can delay everything.

HTTP/3 uses QUIC, which has a 1 RTT connection and security handshake, 0 RTT for known connections, built-in security, and multiplexing where other streams can continue even if one stream has packet loss.

== Networking Layers
#align(center, image("img/week08/OSI.png", width: 100%))
- Protocols enable an entity/instance to interact with an entity/instance at the same layer in another host
- Service definitions: provide functionality to an (N)-layer by an (N-1) layer
- Each PDU (protocol data unit) contains a protocol header and payload, the service data unit (SDU)

#align(center, image("img/week08/pdu.png", width: 90%))

== Layer 4 - Transport
=== TCP

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
  - Reliable (retransmission)
  - Ordered
  - Window - capacity of receiver
  - Checksum - 16bit (crc16)
  - TCP overhead: 20bytes (MTU 1500 bytes)
    - IP overhead: 20 bytes
    - Ethernet frame: 18 bytes (crc32)
  - TCP tries to correct errors
  ],
  [
    #align(center, image("img/week08/tcp.png", width: 100%))
  ],
)
- Connection establishment
  - SYN, SYN-ACK, ACK (three way)
  - Initiates TCP sessions: initial sequence number is ~random
- Connection termination
  - FIN, ACK + FIN, ACK (three/four way)
  - 3-way handshake, when host 1 sends a FIN and host 2 replies with a FIN & ACK
- Sequences and ACKs
  - Identification each byte of data
  - Order of the bytes -> reconstruction
  - Detecting lost data: RTO, DupACK
- Retransmission timeout
  - If no ACK is received after timeout (e.g 2xRTT), resend
- Duplicate cumulative acknowledgements, selective ACK
  - ACKs for last consecutive packets
  - 3 times same ACK -> retransmit missing packets (fast retransmit)

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    - Flow Control
      - Sender is not overwhelming a receiver
      - Back pressure
      - Sliding window:
        - Receiver specifies the amount of additionally received data in bytes that can be buffered
        - Sender up to that amount of data before the ACK
    - Congestion Control
      - slow-start
      - congestion avoidance
      ],
  [
    #align(center, image("img/week08/tcp-2.png", width: 100%))
  ],
)
  
=== TCP/IP from an Application Developer View
Problem: TCP handshake is not flexible
  - You need a handshake (1RT)
    - If you want to make sure the other side accepts packets (and not drop it), ensure both sides are ready to transmit and receive data
    - If you want to exchange public / private keys
  - TCP + Security = at least 2 RT
    - DNS query may be required too: 3 RT
    - Old security protocols add RT: 4 RT
  - Worst case: 1.4s before data can be sent

=== TCP + TLS
Security: Transport Layer Security (TLS)
+ "client hello" lists cryptographic information, TLS version, ciphers/keys
+ "server hello" chosen cipher, the session ID, random bytes, digital certificate (checked by client), optional: "client certificate request"
+ Key exchange using random bytes, now server and client can calc secret Key
+ "finished" message, encrypted with the secret key

Total: 3 RTT to send first byte, 4 RTT to receive first byte

#align(center, image("img/week08/tls.png", width: 90%))

*TLS 1.3: 1 RTT instead of 2*
- Client Hello, Key Share
- Server Hello, key share, verify certificate, finished

=== QUIC / HTTP3
- QUIC: 1RTT connection + security handshake
- For known connections 0 RTT
- Built-in security
- HTTP/2 introduced multiplexing
- If one stream has packet loss, other streams can continue normally

The problem with HTTP/2: TCP requires packets to arrive in order, one missing packet can delay everything

Downsides of HTTP/3:
- NAT: TCP (SYN, ACK, FIN) knows when connection ends, with UDP you get many timeouts (creates many entries)
- HTTP header compression: Can reference previous headers which can create dependency
- Cannot benefit from TCP optimizations

=== UDP
- UDP is used for DNS, streaming audio and video
- Simple connectionless communication model
- No guarantee
  - Delivery
  - Ordering
  - Duplicate protection

=== Layer 4 - SCTP
- Message-based
- Allows data to be divided into multiple streams
- Syn cookies - SCTP uses a four-way handshake with a signed cookie
- Multi-homing multiple IP addresses of endpoints
- Not widely used
  - Problems with home routers
  - Used by WebRTC but tunneled over UDP

=== DDoS Amplification Attacks
DDoS amplification abuses UDP services that respond with more data than they receive. The attacker spoofs the victim’s address, so the server sends the large response to the victim. Tools like hping3 can create such spoofed UDP packets, while normal programming languages usually do not support this easily.

=== Comparison
#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: left,
    inset: 6pt,
    stroke: 0.5pt,

    table.header(
      [*TCP*],
      [*UDP*],
      [*SCTP*],
      [*QUIC*],
    ),

    [Transport layer],
    [Transport layer],
    [Transport layer],
    [Transport layer],

    [Connection oriented],
    [Connection less],
    [Connection oriented],
    [Connection oriented],

    [Reliable transfer],
    [Unreliable transfer],
    [Reliable transfer],
    [Reliable transfer],

    [Streams],
    [Messages],
    [Messages],
    [Multistream],

    [Guaranteed order],
    [Unordered],
    [User can choose],
    [Guaranteed order],

    [Widely used - HTTP/1, HTTP/2],
    [Widely used - DNS, HTTP/3],
    [WebRTC],
    [HTTP/3],

    [Flow and congestion control],
    [No flow, congestion],
    [Flow and congestion control],
    [Flow and congestion control],

    [Heavyweight],
    [Lightweight],
    [Heavyweight],
    [Heavyweight],

    [Error checking and recovery],
    [Error checking, no recovery],
    [Error checking and recovery],
    [Integrity check],
  ),
  caption: [Comparison of transport protocols]
)

== Alternatives to QUIC
There are several alternative transport protocols or libraries, but most have drawbacks:

- KCP: A transport protocol without built-in encryption.
  - GFCP: A variant of KCP.
- UDT: No longer maintained.
- utp4j: Java implementation of Micro Transport Protocol, later handed over to Tribler at Delft University of Technology.
- Other related projects include:
  - 0-RTT protocol in Go
  - ATP, a peer-to-peer protocol
  - P2P library in Go

== QOI - The quite ok image format
- Simple version of png
- Enocoder / decoder in 300 loc
- PNG generates smaller images, QOI is much faster
- Compression not much worse but simpler
