= Week 2 - Location, Latency and Redundancy
== Distributed Systems Motivation - Location
- Hardware might get faster but latency stays
- Nothing is faster than the speed of light -> you will always have some latency
- Reduce latency by placing systems closer to users (or by using a CDN)
- Legal requirements for data location (GDPR)

*Latency: * time for signal to travel from source to destination and back (round-trip time)

*Traceroute:* Tool used to visualize hops
  - Ping only shows total RTT
  - Traceroute shows the path
  - Sends package with increasing TTL (Each router makes TTL - 1 when TTL = 0 then ICMP "Time Exceeded" is sent)

=== Speed of Light
- There is a difference between practical and theoretical limit (300ms vs 110ms)
- Usually no direct paths from one location to another (e.g there is no straight cable from my home to my friends home in amsterdam)
- Signals can only travel at the speed of light inside a vacuum

==== Different fiber types
*Single mode fibers:* Provide lower latency, one main path, less delay spread

*Multimode fibers:* Many paths, some longer, more delay spread

The refractive index of glass depends slightly on the wavelength of the light. This is called chromatic dispersion. Different wavelengths travel at slightly different speeds, so the latency depends on what optical wavelength is used

*Hollow core fiber:* Has less latency, guides light through air and not through solid glass. Thus, light can travel closer to its vacuum speed.

*Copper:* Propagates faster but not much (Good copper cable > standard fiber)

Quick facts:
- Network latency has a physical lower limit because signals cannot travel faster than light.
- Fiber is slower than space/air because light travels through glass at about 200,000 km/s, not 300,000 km/s.
- Real network latency is higher than the theoretical minimum due to routing, queuing, protocol overhead, traffic inspection and signal repeating.
- Satellites can sometimes be faster than fiber because they can take a more direct route and signals travel faster through air/space. However, weather conditions can affect signal strength
- Wi-Fi is not the lowest-latency option because it adds waiting time, acknowledgements, retransmissions and MAC-layer processing.
- Main idea: latency depends on distance, signal speed, routing path and protocol overhead.

== Motivation for Distributed Systems - Redundancy / Fault-tolerance
- Any hardware will crash eventually -> it's not a question of if but when
- Random bit flips in memory
  - Might happen for DNS names in your memory, that's why many providers have *Bitsquat Domains* (e.g ikamai.net -> akamai.net)
- Cosmic rays may be blamed for an electronic voting error (bit flip)
- Techniques like replication, checksums, redundancy, consensus and monitoring help keep systems reliable.
- HDD break, SSDs wear out (use NAND cells with limited lifetime, they have spare NAND)
-Distributed Systems provide a solution
  - Multiple machines provide redundancy
  - When one machine fails, others can take overhead
  - Load can be redistributed among remaining machines
  - System continues to function despite individual failures

*Trade-off consideration:*
- Distributed systems add complexity
- Use only when benefits outweigh the added complexity
- Redundancy and fault tolerance must justify the complexity


*One possible solution:*
- Error-correcting code memory (ECC)
- Hamming Code, correct 1 bitflip / detect 2 bitflips
- Used mainly for servers
- Consumer: DDR5 has on-die ECC but weaker than traditional ECC (corrects only inside the chip at rest but not on the data bus in transit)

*NAND flash memory types:*
- SLC = Single-Level Cell -> Stores 1 bit per cell.
- MLC = Multi-Level Cell -> Usually stores 2 bits per cell.
- TLC = Triple-Level Cell -> Stores 3 bits per cell.
- QLC = Quad-Level Cell -> Stores 4 bits per cell.

The tradeoff is: more bits per cell means cheaper and denser storage, but lower endurance and usually slower writes. Caching with SLC → files / cells that are frequently
changed, store on SLC, once they don’t change that
often move to MLC/TLC/QLC

The goal is to level the wear and distribute write and erase operations across all memory cells.

== Fault Tolerance
Seacables provide 99% of data connectivity. Network outages do happen from time to time.



