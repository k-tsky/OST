= Week 11 - Consensus
== Key takeways
=== Why does scaling lead to consensus problems?
Scaling means running multiple components or servers. Because components can be unreliable, replicas can end up in inconsistent states, so the system needs consensus to agree on one value, leader, block, data, or version.

=== Fault models: crash faults vs. Byzantine faults
A crash fault means a component fails or becomes unavailable. A Byzantine fault is an arbitrary fault where a node can do more than crash, for example lie to reach an advantage.

=== Consensus algorithms: Paxos, Raft
Paxos guarantees that nodes only ever choose a single value, but it does not guarantee progress if a majority of nodes are unavailable. It uses proposers, acceptors, and learners in a prepare/promise phase and an accept phase.

Raft uses followers, candidates, and one leader. Followers expect heartbeats from the leader; if the leader is unavailable, a new election starts. The system is only available when a leader has been elected and is alive.

=== Consistency in DHTs: vDHT
vDHT uses no locking and no timestamps. Every update creates a new version. `get()` waits until replica peers have the latest version, while `put()` first prepares data with a short TTL and only confirms it if all replica peers are OK.

With heavy churn, `get()` may return forks, so the API user may need to abort or resolve conflicts manually.

=== CRDTs: conflict-free data structures
CRDTs are an alternative to consensus protocols like Paxos or Raft. They do not need a leader or majority and can still work during network partitions, but only for suitable data structures.

Their operations must be commutative, associative, and idempotent, so replicas can eventually reach the same state without conflicts.

=== Tradeoffs between approaches
Paxos and Raft provide consensus but need a majority or leader to make progress. vDHT avoids locking and timestamps, but conflicts or forks may need to be resolved by the application. CRDTs can work without a leader or majority, but are limited to suitable data structures and merge algorithms.

=== Different ways to deploy your service — High-level overview

Modern deployment is based on containers, but still needs a strategy. Deployment approaches include rolling deployment, blue-green deployment, canary releases, feature toggles, and big bang deployment.

Practical options include plain Docker Compose or Podman, Docker Swarm, Kubernetes for larger deployments, Ansible/Chef/Puppet for automation, hosted services like Railway, and Terraform for Infrastructure as Code.

== Consensus
*Definition:* Consensus decision-making is a group decision-making process in which group members develop, and agree to support a decision in the best interest of the whole. Consensus defines leader (creates blocks, adds data, creates version).

*Byzantine Fault:* Arbitrary fault that occurs during the execution of an algorithm by a distributed system (not only crash but lie to reach an advantage)

Find consensus: Paxos, Raft, vDHT, Zookeeper

=== Paxos
Paxos is a consensus algorithm by Leslie Lamport that became important for fault-tolerant distributed systems. It was first rejected, later accepted and helped Lamport win the Turing Award. It is largely considered difficult to understand.

Problem: Due to unreliable components, run multiple components, i.e multiple servers leads to inconsistent state with replica

Paxos guarantees that nodes will only ever choose a single value, but does not guarantee that a value will be chosen if a majority of nodes are unavailable.

Roles: proposer, acceptor and learner
- Proposer proposes a value that it wants agreement upon
- Acceptor gets proposal, makes promises, sends result to learners
- Learners: majority of accepots must choose the same value

2 phases: prepare/promise phase, accept phase

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *Example:*
    Proposer: prepare and accept requests, proposal number and value (n, v)
      - Acceptor: already seen higher proposal number: ignore
      - Acceptor: seen lower proposal number: send back highest accepted n,v

    Proposer A and proposer B
      - Acceptor Z receives B before A

    If acceptor receives prepare request for the first time:
    - Acceptor responds with a prepare response
    - Promises never to accept another proposal with a lower proposal number
    
    - Acceptor Z receives proposer A’s request, and acceptors X and Y receive proposer B’s request.
      - Only accept requests with higher number, Acceptor Z not sending response (or negative response) to B.
    - Proposer B sends an accept request to each acceptor containing the proposal number it previously used (n=4) and the value associated with the highest proposal number among the prepare response messages it received (v=8)
    - Proposer A sends its accept request before proposer B, but acceptor ignores them
    - If an acceptor receives an accept request for a higher or equal proposal number than it has already seen, it accepts and sends a notification to every learner node.
      - A value is chosen by the Paxos algorithm when a learner discovers that a majority of acceptors have accepted a value
      - Once a value is chosen by Paxos, communication with other proposers cannot change value
      - If another proposer, sends a higher proposal number than has previously been seen, with a different value (e.g., n=6, v=7), each acceptor responds with the previous highest proposal (n=4, v=8)
      - This requires the proposer to send an accept request containing [n=6, v=8], which confirms the value that has already been chosen

  ],
  [
    #align(center, image("img/week11/paxos-1.png", width: 100%))
    #align(center, image("img/week11/paxos-2.png", width: 100%))
    #align(center, image("img/week11/paxos-3.png", width: 100%))
  ],
)

==== Raft (multi paxos)
*RAFT:* Reliable, Replicated, Redundant, And
Fault-Tolerant

- Follower, Candidate, leader
  - Raft implements leadership election
  - Once a leader has been elected, all decision-making within the protocol will then be driven only by the leader
  - Only one leader can exist at a single time
- Each follower has a timeout (typically between 150 and 300ms) in which it expects the heartbeat from the leader
  - The system is only available when a leader has been elected and is alive
  - Otherwise, a new leader will be elected, and the system will remain unavailable for the duration of the vote
  - Starts election by increasing term counter, voting for itself, and sending a message to all other servers requesting their vote
  - If higher term is received become follower, if not, leader

== Consistency
vDHT Basics:
- No locking, no timestamps
- Every update - new version
  + Get() latest version, check if all replica peers have the latest version, if not wait and try again
    - May add delay
    - Wait until update is completed
  + put() prepared with data and short TTL, if status is OK on all replica peers, go ahead, otherwise, remove the data and go to step 1
    - Data can be either send now or with the confirm, if sent now we are optimistic
    - Peer marks the value as prepared, other put() fail on that key. If nothing happens, TTL
    - Value linked to previous version(s) (hash)
  + put() confirmed, don't send the data, just remove the prepared flag and reset TTL
- In case of heavy churn (constant joining and leavig), API user needs to resolve
  - Get latest version may return fork
  - Abort or resolve (join) manually

== CRDT
CRDTs are an alternative to consensus protocols like Paxos or Raft. They do not need a leader or a majority, so they can still work during network partitions. However, they are limited to suitable data structures.

A vDHT is similar to an operation-based CRDT, but conflict resolution is delegated to the application. This means forks or conflicting versions may need to be resolved manually.

CRDT stands for Conflict-free Replicated Data Type. It can be imagined like Git, but without merge conflicts.

For CRDTs to work correctly, their operations must be:

- Commutative: $x bullet y = y bullet x$
- Associative: $(x bullet y) bullet z = x bullet (y bullet z)$
- Idempotent: $x bullet x = x$

=== Example: G-Counter

A G-Counter stores one counter value per machine.

#raw(
"A:6 B:0 C:0
A:0 B:3 C:0
A:0 B:0 C:9",
block: true
)

When replicas are merged, the maximum value of each counter position is kept:

#raw(
"merge(A:6 B:2 C:9, A:5 B:3 C:2) = A:6 B:3 C:9",
block: true
)

Because this merge is commutative, associative and idempotent, all replicas eventually reach the same state.

=== Collaborative Text Editing

A common CRDT example is collaborative text editing. Google Docs uses operational transformation, which usually requires a central server.

CRDTs can also work without a central server, for example in a peer-to-peer system. For this, suitable merge algorithms are needed.

One idea is to assign each character a position value between 0 and 1:

#raw(
"H    e    l    o
0.2  0.4  0.6  0.8",
block: true
)

Concurrent edits can then insert characters between existing positions:

#raw(
"Insert \"l\" at 0.7
Insert \"!\" at 0.9",
block: true
)

After merging:

#raw(
"H    e    l    l    o    !
0.2  0.4  0.6  0.7  0.8  0.9",
block: true
)

This allows merging without direct conflicts. However, collisions can happen if two edits choose the same position, so the algorithm needs a strategy for this.

Another problem is interleaving: if two users insert multiple characters at the same place, the merged result may mix them in an unwanted order. Existing CRDT algorithms handle such cases.

Examples of CRDTs:

- G-Counter
- PN-Counter
- G-Set
- 2P-Set
- Yjs, a CRDT library


= Week 11 - Deployment
Old deployments were manual: install packages, configure software, run scripts. This caused version problems, dependency conflicts, config drift, crashes, and scaling issues.

Containers help by packaging the app with its libraries, making it easier to move, scale, and run consistently. But deploying containers still needs a strategy.

== Deployment Strategies
*Rolling Deployment:*
- New version is gradually deployed to replace the old version (doesn't take the entire system down at once)
  - Minimal downtime, low risk
  - Complexer, longer deployment times

*Blue-Green Deployment:*
- 2 environments
  - Blue: Current prod
  - Green: Current prod with new release
- Test, then switch
- Instant rollback, 0 downtime
- Issue: 2 prod environments, keep data in sync

*Canary Releases:*
- New version to a small group of users or server first, if all goes well, more users
- Reduces risks, gives user feedback
- Complex, leads to inconsistencies

*Feature toggle:*
- Fine grained canary, set feature for specific users
- More risk reduction, specific user feedback
- Increases complexity of codebase and config management

*Big bang:*
- Deploy everything at once
  - Simple
  - High risk, limited rollback

== Practical Deployment
- Containerization is the basis for modern deployment.
- Ansible, Chef and Puppet are used for deployment automation.
  - Ansible uses playbooks and an SSH host list.
  - The target hosts should usually run the same OS/package manager, for example apt or yum.
- Docker Swarm works with docker-compose.yml.
  - It lets you package and deploy the application in the same way across platforms.
  - It is simpler than Kubernetes.
- Kubernetes is widely used, especially for larger deployments.
- Plain Docker Compose or Podman is the simplest option.
  - Example: run docker compose up -d --build over SSH.
- Ansible:
  - Does not require agents on the servers.
  - Is push-based, so commands are pushed from your machine/control node.
  - Uses SSH to connect to hosts.
  - Runs with commands like ansible-playbook playbook.yml.
- A more basic alternative is pssh/ssh, but it is less structured than Ansible.

=== Podman / Docker Swarm
*Podman:*
- Daemonless
- Simpler but deployment needs more works
- Quadlet:
  - Run container under systemd in a declarative way
  - Tools to convert podman/compose
  - Auto-update from registry
- Many variations, tools, helpers: podman-compose

*Docker Swarm:*
- Deploy with docker-compose.yml
- Built into docker
  - docker swarm - manage swarm
  - docker stack - manage deployments
  - docker node - manage nodes
- Scheduler is responsible for placement of containers to nodes

=== Kubernetes (K8s)
- Container orchestration: deployment, scaling, management
- Industry standard for complex applications

*Why:*
- High availability, fault tolerance (containers/nodes can crash)
- Auto-scaling based on demand
- Rolling updates and rollbacks built-in
- Ecosystem: Helm (package manager), operators

*Design principles:*
- Declarative config (YAML / JSON) - describe desired state
- Immutable containers - don't store state, restart on health check fail
- Rollbacks possible but tricky with schema changes

*Architecture: Master + Worker nodes*
- Master: API server, etcd, controller manager, Scheduler
- Worker: kubelet, kube-proxy, container runtime (containerd, CRI-O)

*Key concepts:*
- Pod: smallest deployable unit, one or more containers
- Service: stable network endpoint for a set of pods
- Deployment: manages desired state, scale, HW limits
- ConfigMap: non-sensitive configuration data
- Secret: sensitive data (passwords, API keys), encrypted in etcd
- Volume: persistent storage, decoupled from prod lifecycle
- Namespace: segment cluster, multiple projects/teams isolated

*Getting started:*
- Local development: minikube, k3s
- kubectl: command-line tool
- GUI: kubernetes dashboard, lens

#align(center, image("img/week11/kubernetes.png", width: 100%))

=== Services, Terraform
*Services:*
- AWS, App Runner
- Digital Ocean, App Platform
- Railway
  - Git based deployment
  - Zero config and HTTPS support
  - Integrated Dbs
  - Pull request -> preview
  - Logs / monitoring

*Terraform:*
Terraform is used for Infrastructure as Code.

That means you describe your infrastructure in configuration files instead of creating everything manually in a web dashboard.

For example, you can describe:
- servers
- databases
- networks
- load balancers
- DNS records
- permissions

*Deployment Best Practices:*
- Automate the deployment as much as possible
- Infrastructure as Code
- Immutable Infrastructure
  - Instead of SSH-ing into a server to update manually, you build new image and deploy that
- Health Checks / Monitoring
- Centralized Logging
- Rollback

