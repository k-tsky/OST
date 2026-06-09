== Why do we need Distributed Systems - Key takeaways
=== Why do we need distributed systems?

We need distributed systems mainly for scaling, location, and fault-tolerance. Distributed systems add complexity, so this should be avoided unless needed.

==== Scaling (if one machine is not enough)

Scaling means increasing system capacity.

*Vertical scaling* means using a stronger machine, for example more memory or a faster CPU.

Advantages:
- Lower cost at small scale
- No software adaptation required
- Less complexity

Disadvantages:
- Hardware limits
- Hardware failure can cause an outage
- Fault-tolerance is harder
- Speedup is limited by sequential work, see Amdahl's Law

*Horizontal scaling* means using more machines.

Advantages:
- Lower cost at massive scale
- Easier to add fault-tolerance
- Higher availability

Disadvantages:
- Software adaptation required
- More complex system with more components

==== Location (to move closer to the user)

Location matters because hardware can get faster, but latency remains limited by the speed of light. Distributed systems can reduce latency by placing systems closer to users, for example with a CDN.

Other reason for location:
- Legal requirements for data location, such as GDPR

Latency is the time for a signal to travel from source to destination and back.

Important points:
- Real network paths are usually not direct
- Fiber is slower than vacuum because light travels through glass
- Single-mode fiber has lower latency than multimode fiber
- Hollow-core fiber can have lower latency because light travels mostly through air
- Copper can be slightly faster than standard fiber, but not by much
- Traceroute shows network hops, while ping only shows total RTT

==== Fault-tolerance (HW will fail eventually)

Fault-tolerance means preparing for failures. Hardware will eventually fail, and at scale rare failures become expected.

Examples:
- Random bit flips in memory
- HDDs break
- SSDs wear out
- Network outages happen, including sea cable failures

Distributed systems help because:
- Multiple machines provide redundancy
- If one machine fails, others can take over
- Load can be redistributed
- The system can continue despite individual failures

Reliability techniques from Week 2:
- Replication
- Checksums
- Redundancy
- Consensus
- Monitoring
- ECC memory

