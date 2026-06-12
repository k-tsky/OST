= Week 7 - Categorization
== Key takeaways
=== What is a distributed system?
A distributed system is a group of computers working together so that, to the user, they appear like a single computer.

=== How can it be categorized?
There is no single universally applicable categorization. Distributed systems can be categorized by transparency, fault tolerance, scalability, consistency, data replication, data partitioning, and heterogeneity.

Examples are tightly vs. loosely coupled, homogeneous vs. heterogeneous, small-scale vs. large-scale, stateful vs. stateless, decentralized systems, client-server, peer-to-peer, hybrid, monolithic vs. microservices, and synchronous vs. asynchronous communication.

=== What are transparencies?
Transparencies are ways a distributed system hides its distributed nature from users.

Examples:
- Location transparency: users do not know the physical location
- Access transparency: users access resources in one uniform way
- Migration/relocation transparency: users do not notice resources moved
- Replication transparency: replicas appear as one resource
- Concurrent transparency: users do not notice other users
- Failure transparency: users do not notice recovery mechanisms
- Security transparency: users are minimally aware of security mechanisms

== Distributed System Definition
A distributed system in its simplest definition is a
group of computers working together as to appear as a
single computer to the user

== Distributed Systems Categorization
*Classification:* degree of transparency, fault tolerance, scalability, consistency (strong, eventual, and causal), data replication, data partitioning, heterogeneity. 

There is no single universally applicable categorization of distributed systems

*Classifications:*
- Tightly coupled: Processing elements or nodes have access to a common memory
- Loosely coupled: Do not

*Homogeneous System:* All processors within the system have the same type\
*Heterogeneous System:* Contains processors of different types

*Small-scale system:* WebApp + Database\
*Large-scale system:* 2+ machines

*Stateful:* Maintains state between requests (e.g databases, session-based applications)\
*Stateless:* System treats each request independently (e.g REST APIs behind a load balancer)

*Decentralized:* Distributed in a technical sense but not owned by one actor

*More classifications:*
- Based on architecture (Client-server, peer-to-peer, hybrid, software architecture)
- Based on deployment architecture (monolithic vs. microservices)
- Based on communication model (synchronous or asynchronous)

=== Controlled distributed systems vs. fully decentralized systems
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    - 1 responsible organization
    - Low churn
    - Examples:
    - Amazon DynamoDB
    - Client/server
    - “Secure environment”
    - High availability
    - Can be homogeneous / heterogeneous
    - Mechanisms that work well:
    - Master nodes, central coordinator
    - Consistent hashing (DynamoDB, Cassandra)
    - Network is under control or client/server → no NAT issues
    - Consistency
    - Leader election (Zookeeper/Zab, Paxos, Raft)
    - Replication principles
    - More replicas: higher availability, higher
    reliability, higher performance, better
    scalability, but: requires maintaining
    consistency in replicas
    - Transparency principles apply


  ],
  [
    - N responsible organizations
    - High churn
    - Examples:
    - BitTorrent
    - Blockchain
    - “Hostile environment”
    - Unpredictable availability
    - Is heterogeneous
    - Mechanisms that work well:
    - Consistent hashing (DHTs)
    - Flooding/broadcasting - Bitcoin
    - NAT and direct connectivity huge problem
    - Consistency
    - Weak consistency: DHTs
    - Nakamoto consensus (aka proof of work)
    - Proof of stake – Leader election, PBFT protocols, Is Bitcoin eventually consistent? — Some argue no, some argue it has even stronger guarantees
    - Replication principles apply to fully decentralized systems as well
    - Transparency principles apply
  ],
)

== CAP theorem
States that distributed data store cannot simultaneously be consistent, available and partition tolerant. Choose between consistency or availability.
- Consistency: Every node has the same consistent state
- Availability: Every non-failing node always returns a response
- Partition Tolerant: The system is designed to deal with broken communication between the nodes. 

Example: Cassandra (NoSQL) is designed to be AP but can be CP.

== Transparency in distributed systems
Distributed systems should hide its distributed nature:
- *Location transparency:* users should be unaware of the physical Location
- *Access transparency:* users should access resources in a single uniform way
- *Migration, relocation transparency:* users should not be aware that resources have moved
- *Replication transparency:* users should not be aware about replicas, it should appear as a single resource
- *Concurrent transparency:* user should not be aware of other users
- *Failure transparency:* user should not be aware of recovery mechanisms
- *Security transparency:* users should be minimally aware of security mechanisms

== Fallacies of Distributed Computing
“Fallacies of Distributed Computing” means: Things developers often assume about networks, but should not assume.

+ Network is reliable
  - Even submarine cables can fail
+ Latency is zero
    - Ping to AUS is ~300ms
+ Bandwidth is infinite
  - Send a bike courier with an 8TB disk, that arrives 10h later, or send the data with a 1Gibt/s link? 8 * 1000 * 8 / (10 * 60 * 60) = 1.7Gbit/s
+ The network is secure
  - Assume someone is listening
+ Topology doesn't change
  - Ping to AUS request can take different route than reply
+ There is one administrator
  - Sometimes your route goes from one company to another rival company
+ Transport cost is zero
  - Someone builds and maintains the network
+ The network is homogeneous
  - WiFi, cable, desktop, server, mobile
