= Week 1 - Scaling
== Key takeaways
=== Why do we need distributed systems?
We need distributed systems mainly for scaling, location, and fault-tolerance. Distributed Systems add complexity, this should be avoided.

==== Scaling (if one machine is not enough)
Scaling means using distributed systems when one machine is not enough. Scaling can be vertical, by using more memory or a faster CPU, or horizontal, by using more machines. Horizontal scaling can offer lower cost at massive scale, higher availability, and easier fault-tolerance, but it also requires software adaptation and makes the system more complex.

==== Location (to move closer to the user)
Location means moving closer to the user. This is one reason distributed systems are needed.

==== Fault-tolerance (HW will fail eventually)
Fault-tolerance means preparing for hardware failure. Hardware will eventually fail, and horizontal scaling makes it easier to add fault-tolerance and achieve higher availability. Vertical scaling has the risk that hardware failure can cause an outage and makes fault-tolerance more difficult.

== Distributed Systems Motivation
*Scaling:*
- Vertical (scale up), more memory, faster CPU
  - Single Core
    - Amdahl's Law: Your total speedup is limited by the part of the work that cannot be parallelized
    - S = 1 / ((1 - P) + P/N)
    - S = Speedup, P = parallelizable fraction (0–1), N = number of parallel units
    - Example: P = 95% -> even with infinite processors, the speedup can never be more than 20x
    - Thus the sequential part is always the bottleneck e.g in real word DB locks limit throughput regardless of server count
- Horizontal (scale out), more machines
\

#grid(
  columns: (auto, auto, auto),
  gutter: 2em,
  [
    *Machine Learning:*
    - Current trend: scale horizontally
    - ML with vertical scaling is not (yet) feasible
  ],
  [
    *Economics:*
    - Initially scaling vertically is cheaper until HW is maxed out
    - Currently: RAM prices increasing, fast servers
  ],
  [
    #align(center, image("img/scaling-economics.png", width: 100%))
  ]
)

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *Horizontal Scaling* \
    `+` Lower cost with massive scale \
    `+` Easier to add fault-tolerance \
    `+` Higher availability \
    `-` Adaption of software required \
    `-` More complex system, more components
    involved \
  ],
  [
    *Vertical Scaling*\
    `+` Lower cost with small scale\
    `+` No adaption of software required\
    `+` Less complexity\
    `-` HW limits for scaling\
    `-` Risk of HW failure causing outage\
    `-` More difficult to add fault-tolerance\
  ]
)

== Vertical Scaling Performance
Notable laws:
-  Moore’s Law: nr. of transistors doubles
every 2 years
- Nielsen’s Law: a high-end user’s
connection speed grows by 50% per year
- Kryder'S Law: Disk density doubles every 13 months
- Best principal for small and simple applications -> Simple website with a few DB calls is not HW intensive
- Bandwidth usually grows slower than computer power (conservative telecom/reluctant users).
- Wirth's law (1995): Hardware gets faster but software complexity and resource demands grow even faster

== Energy: The new scaling constraint
- AI-specific hardware will surpass bitcoin scaling-economics
- ChatGPT query: ~0.3W
  - 100 queries roughly 15min of netflix
  - Efficiency is improving
  - Time savings give indirect energy savings
  - Rebound effect -> users generate more and more queries
