= Week 9 - Application Protocols
== Key takeways
=== Overview over important protocols on layer 7
Layer 7 application protocols in this document include HTTP, WebSockets, Server Sent Events, WebRTC, DNS, Let's Encrypt / ACME, and mail protocols such as SMTP, POP, and IMAP.

=== Custom protocols, ASN.1, RPC, HTTP, JSON, WebSockets, Server Sent Events
Custom protocols can use less space, encode and decode faster, avoid unnecessary fields, and improve performance. Their downsides are development effort, testing/debugging, compatibility, and documentation.

ASN.1 is used for serialization/deserialization and certificates. RPC lets programs execute code on remote machines; examples include gRPC with HTTP/2 and Protocol Buffers. JSON is a human-readable data format, HTTP is the transport, and REST/RPC describe the API style.

WebSockets provide full-duplex communication over TCP after an HTTP upgrade. Server Sent Events are one-way communication from server to browser over a kept-open HTTP connection.

=== Bencoding, WebRTC, DNS, Let's Encrypt, Mail Protocols
WebRTC enables browser-to-browser real-time communication and uses STUN, TURN, and ICE for NAT traversal. DNS translates domain names to IP addresses and uses records such as SOA, NS, MX, A/AAAA, TXT, and PTR.

Let's Encrypt is a non-profit CA for automated TLS certificates via ACME. Mail protocols include SMTP for sending/receiving emails, POP, and IMAP. Mail security and spam prevention include STARTTLS, SMTPS, SPF, DKIM, DMARC, BIMI, greylisting, DNSBL, SURBL, and Bayesian analysis.

== Protocols
Custom Protocols:\
`+` less space\
`+` faster encoding/decoding (custom)\
`+` fewer unecessary fields\
`+` better performance\

`-` development\
`-` testing/debugging\
`-` compatibility\
`-` documentation\

Protocol generators:
- Thrift: RPC framework from facebook, IDL and binary protocol
- Avro: data serialization system, remote procedure call and data serialization framework - Hadoop (Big-data framework)
- Protocol Buffers: data serialization from Google, IDL -> goals: smaller and faster than XML
- ASN.1: serializ. / deserializ, used for certs

IDL = Interface Description Language -> describe the protocol once, the tool generates code for different programming languages

#grid(
columns: (auto, auto),
gutter: 2em,
[
Little-endian / big endian:
- Sequential order where bytes are converted into numbers
- Networking (TCP headers): Big-endian
- Most CPUs: Little-endian
],
[
  #align(center, image("img/week09/little-endian.png", width: 100%))
],
)

== RPC Examples
Remote Procedure Call: lets programs execute code on remote machines.

Examples:
- gRPC: Uses HTTP/2 for transport, uses Protocol Buffers
- Features: Authentication, bidirectional streaming and flow control, blocking or nonblocking bindings, and cancellation and timeouts

=== JSON/REST/HTTP
Human-readable text to transmit data. Can sometimes be RPC:
- REST ideally stateless, RPC can be stateful
- REST responses contain all metadata, RPC often needs interface definitions
- Parsing overhead: JSON slower than binary protocol
- Often used for web apps

So JSON is just the data format, HTTP is the transport, and REST/RPC describe the API style.

== Application Protocol: HTTP
- Foundation of web data communication
- Request/response model, resources identified by URL
- URL structure: scheme, user info, host, port, path, query, fragment
- Stateless (server keeps no state)
- Browser sends additional headers (User-Agent, Accept, Accept-Encoding)

#align(center, image("img/week09/url.png", width: 100%))

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *Response: header + status code + content body*

    Header:
    #align(center, image("img/week09/header.png", width: 100%))
  ],
  [
    Status Codes:
    - 1xx (informational),
    - 2xx (success – 200 OK), 
    - 3xx (redirection), 
    - 4xx (client error – 404 Not Found, 403 Forbidden), 
    - 5xx (server error)

    Body/Content: <!DOCTYPE html> ...
  ],
)

*Request Methods:* GET, HEAD, POST, PUT,
DELETE, TRACE, OPTIONS, CONNECT,
PATCH

== WebSockets
- Full-duplex (two way) communication over TCP (REST/JSON is in one direction)
- HTTP handshake, then upgrade to communication channel (WebSocket)
- With SSL/TLS -> `wss://`
- Example usages: WhatsApp, Google Docs, YouTube
- Many languages support it, e.g Golang

- How can the server notify the browser
  - Polling:
    - Short: Request e.g every 0.5s
    - Long: request until timeout or reply
  - Server Sent Events (alternative) SSE
    - One way communication from server to browser
    - Server receives a regular HTTP request, keeps connection open (Accept or Content-Type: text/event-stream)
    - Native browser support via EventSource API
    - Automatic reconnection if connection is lost
    - Max number of concurrent connections per domain

== WebRTC
- Browser to browser communication (P2P)
- Real time communication (RTC) via API
- Goal: eliminate plugins or native apps
- Supported by: Google, MS, Mozilla, Opera, Apple
- Replaced need for Flash, Java plugins -> allows e.g Chrome `<->` Communication
- Used in WhatsApp, Facebook Messenger, MS Teams etc.

=== Concerns
- HTML browsers get bloated
  - Several GB RAM to open couple of tabs (Hint: adblocker)
- WebRTC API could be simplified
- Security concerns: May reveal IP information despite using VPN/tor
- WebRTC forbids unencrypted communication
  - DTLS (data), SRTP (media)
  - Complexity - SCTP over DTLS over UDP

=== WebRTC NAT Traversal

WebRTC allows browsers to communicate directly with each other, even if they are behind NATs or firewalls. The developer does not need to handle NAT directly, because WebRTC uses STUN, TURN and ICE as abstractions.

==== STUN

STUN is used to discover which public IP address and port a client has from the outside.

```
Client asks STUN server: Who am I?
STUN server replies: You are public-ip:port
```

STUN can also help detect the NAT type. However, STUN is not a complete NAT traversal solution by itself. It only discovers possible connection addresses, but some NATs or firewalls may still block direct connections.

==== TURN

TURN is used when a direct peer-to-peer connection is not possible. In this case, the traffic is relayed through a TURN server.

```
Client A <-> TURN server <-> Client B
```

This is more reliable, but less efficient because all data or media must pass through the relay server. TURN can use UDP, TCP or TLS, which is useful because some firewalls block UDP entirely.

==== ICE

ICE stands for Interactive Connectivity Establishment. It is the overall process that collects and tests possible connection paths between peers.

ICE candidates can include:
- local IP addresses
- public addresses discovered via STUN
- relay addresses from TURN

The peers exchange these candidates and test which connection works best.

+ Try direct connection
+ Try STUN-discovered public address
+ If that fails, use TURN relay

In short, STUN discovers addresses, TURN provides a relay fallback and ICE chooses the best working connection path.

=== WebRTC Architecture
#align(center, image("img/week09/WebRTC.png", width: 90%))

== Application Protocol: DNS

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    Translates human-readable domain names to IP addresses "phone book of the internet"

    - No special characters: ASCII
    - Punycode: bücher.tld -> xn--bcher-kva.tld
    - Hierarchical and decentralized naming system for computers
    - UDP Port 53
    - Primary + secondary DNS for redundancy
    - Typical setup
      - User
      - Caching/forwarding DNS
      - Recursive servers: DNS name resolution for applications (e.g bind/unbound)
      - Authoritative servers: providing a definitive answer
        - Authoritative DNS: allows others to find your domain
        - Recursive DNS: allows you to resolve other domains
    - Restriction to 13 root servers due to 512 byte packet limit
      - With anycast ~2000 root server instances worldwide
      - l.root-servers.net , 1 root IP with anycast mirrored in 90 locations
      - Are regularly attacked (e.g DDoS)
      - Root zone managed by ICANN
    - TTL defines the duration in seconds that the record may be cached by any resolver. “0” means no cache. Recommendation: > 1d

    *Type of records:*
    - SOA: Start of Authority
    - NS: Name Server Record
    - MX: Name and relative preference of mail servers
    - A/AAAA: IPv4/IPv6 address record
    - TXT: arbitrary and unformatted text
    - PTR: opposite of A/AAAA
  ],
  [
    #align(center, image("img/week09/dns.png", width: 100%))
    #align(center, image("img/week09/recursive.png", width: 100%))
  ],
)

=== DNS Security
TSIG can be used to run a DynDNS service. It allows DNS updates to be authenticated before they are written to the DNS database. It uses a shared secret and cryptographic hashing.

DNSSEC is a DNS security extension. It provides authentication and data integrity, but not confidentiality. This means the receiver can verify that DNS data is authentic and unchanged, but the DNS query itself is still visible.

DNSSEC can also be used to bootstrap other security systems, for example certificates, SSH fingerprints or IPsec public keys.

Important DNSSEC keys:
- KSK: Key Signing Key, signs the ZSK public key
- ZSK: Zone Signing Key, signs the DNS records / RRsets

Important DNSSEC record types:
- RRSIG: signature for resource record sets
- DNSKEY: contains public DNSSEC keys
- DS: Delegation Signer record in the parent zone, used to link the trust chain

Using two keys makes key management easier. The ZSK can be changed more often, while the KSK is used to validate the ZSK.

==== DoT and DoH
DNSSEC provides signatures, while DoT and DoH provide encryption. Therefore, DNSSEC protects authenticity and integrity, while DoT and DoH protect confidentiality of DNS lookups in transit.

===== DoH: DNS over HTTPS
DoH sends DNS queries over HTTPS using HTTP/2 on port 443.

Advantages:
- DNS traffic looks like normal HTTPS traffic
- Harder to distinguish or block separately from web traffic
- Easy to deploy because DNS responses can be served like web pages
- Browsers can perform DNS queries directly using JavaScript

Disadvantages:
- Difficult client upgrade path because applications may need their own DoH support
- Performance includes TCP and TLS handshake cost, usually 2 to 3 RTT
- Can centralize DNS traffic at large providers

===== DoT: DNS over TLS
DoT sends DNS queries over TLS on the separate port 853.

Advantages:
- Provides confidentiality for DNS lookups in transit
- Easy for clients to test: try DoT on port 853 and fall back to normal DNS over port 53 if needed
- Widely supported by DNS software and public resolvers

Disadvantages:
- Easier to block because it uses a dedicated port
- Performance includes TCP and TLS handshake cost, usually 2 to 3 RTT

== Let's encrypt
Non-profit CA that provides certificates for TLS. *Domain-validation* certificates only. Automated renewal via ACME protocol.

- Certbot is an ACME client used to request and renew TLS certificates from Let’s Encrypt.
- With the webroot challenge, the challenge file must be placed where Let’s Encrypt can access it.
- The generated certificate and key paths are configured in Nginx.
- Renewal should be automated, for example with certbot renew and an Nginx reload.
- Caddy and Traefik already support ACME directly and can handle certificates automatically.

== Mail protocols
Core protocols:
- SMTP: Simple Mail Transfer Protocol
- POP
- IMAP

=== SMTP
- Standard protocol for sending/receiving emails
- DNS MX records for mail server discovery
- Port numbers:
  - 25: non-encrypted communication
  - 587: Encrypted submission from email
  - 465 (deprecated): for SMTPS (SMTP over SSL)

*Mail flow:*
- MUA (Mail User Agent) ->
- MTA (Mail Transfer Agent) ->
- MDA (Mail Delivery Agent) ->
- Recipients mailbox

Routing: domain == local -> MDA; external forward to recipients MTA

*STARTTLS (port 25/587):*
- Upgrades plain text to TLS on same port
- Backward compatible, recommended standard
- Can fall back to unencrypted -> vulnerable to downgrade attacks

*SMTPS (port 465):*
- Guaranteed encryption from the beginning
- Port confusion due to deprecation/revival history

*Greylisting:*
- Temporarily rejects emails from unknown senders
  - First email from unknown sender -> temporary rejection ("try again later")
  - Legitimate servers retry after delay (per SMTP standard)
  - On retry -> sender recognized, email accepted
  - Subsequent emails pass without delay
  - Reduces spam, low resource usage, simple to implement
  - Delays legitimate emails initially, spammers may adapt

=== Spam prevention
- SURBL (Spam URI Real-time blocklists): checks urls in emails against blacklists
- DNS Blocklists (DNSBL): lists of IP addresses known to send spam
  - e.g UCEPROTECT
  - Mail servers query DNSBLs in real-time to accept/reject
- Bayesian analysis: machine learning to classify emails by content
  - Training data: junk/not-junk emails
  - Word probability: "discount" -> likely spam, "meeting" -> likely not
  - e.g, thunderbird adaptive junk filter

SPF (Sender Policy Framework):
- Domain owner specifies allowed sending servers (DNS TXT record)
  - Receivers verify sender IP against SPF record -> prevents spoofing

DKIM (DomainKeys Identified Mail):
- Digital signature linked to domains DNS
- Verifies email integrity and sender authenticity

DMARC (Domain-based Message Authentication, Reporting and Conformance):
- Builds on SPF + DKIM, adds policy (reject/quarantine/allow) and reporting

BIMI (Brand Indicators for Message Identification):
- Publish logo (SVG) in DNS TXT record, requires VMC (verified mark certificate) in most cases




