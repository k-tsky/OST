= Week 12
== Key takeaways
=== Understand how Bitcoin works as a peer-to-peer system
Bitcoin has no central bank, transactions are created by peers and broadcast to the whole network.

=== Get familiar with UTXO, mining, and proof-of-work
Coins are spent as whole UTXO pieces, while miners create valid blocks by solving proof-of-work puzzles.

=== Be aware of risks like the 51% attack
An attacker with more than 50% computing power could influence transaction ordering and exclude transactions.

=== Reflect on advantages and disadvantages of Bitcoin
Bitcoin is decentralized and can have low fees and strong anonymity, but has high power use, volatility and scalability limits.

== Introduction
- Bitcoin is an experimental digital currency.
- It is fully peer-2-peer, with no central entity like a central bank.
- It was first issued on Jan 3, 2009.
- The smallest unit is 0.00000001 BTC, called 1 satoshi.
- The initiator is unknown.
- Bitcoin can be exchanged for real currencies.
- There is a maximum of `~21` million BTC.
- Every transaction is broadcast to all peers, so they all know every transaction (`~736 GByte`).
- Transactions are validated by proof-of-work, a partial hash collision that is difficult to fake.
- Bitcoin does not rely on trust, but on strong cryptography.
- Bitcoin has weak anonymity.
  - Anonymity can be weakened through clustering. For example, if a transaction has multiple input addresses, those addresses are assumed to belong to the same wallet.
- BIP: Bitcoin Improvement Proposals

== Mechanism
A wallet has public-private keys (wallet.dat)
- Public key, ECDSA 256 bit → Bitcoin address (can receive bitcoins)
- Simple address ~ base58(RIPEM160(Sha256(ecdsa public key)))
  - E.g. 1GCeaKuhDYnNLNR6LGmBtKhPqEJD4KeEtF
- Private key used for signing transactions

=== Transaction
- Peer A wants to send BTC to peer B → creates transaction message
- Transaction contains input / output
  - where the BTC came from and where it goes
- Peer A broadcasts the transaction to all the peers in the network
- Transaction stored in blocks → block is created / verified ~10min

#align(center, image("img/week12/transaction.png", width: 100%))

== Key Bitcoin Operation
Private key authorizes the transation:
- Stolen keys can be used by thieves
- Key lost = coins lost
- In UTXO (unspent transaction output) systems, coins are stored as unspent pieces from earlier transactions
- When one piece is used, the whole piece is spent, the rest comes back as new change

#align(center, image("img/week12/bitcoin-operation.png", width: 100%))

== Blockchain
#grid(
  columns: (1fr, 45%),
  gutter: 1em,
  [
    - Transactions are collected in blocks
      - New block created approximately every 10 min
    - Blocks contain solved crypto puzzles
      - In the form of partial hash collisions (SHA256)
      - Miners search for a block hash with a required pattern, e.g. many leading zeroes
      - More required zeroes = higher difficulty
    - A block has a pointer to previous block →
      - This creates the blockchain
      - Changing an old block changes its hash, so all following blocks would need to be recalculated
    - Creation of blocks is called mining (reward)
      - Mining / creating blocks → Miner get currently 3.125 BTC per creation
        - adjustable difficulty 6 blocks / h
        - Sometime in 2028 reward will be 1.5625
  ],
  image("img/week12/blockchain.png", width: 100%),
)

== Mining mechanism
There are a couple of big miners (e.g the 1 million bitcoins of satoshi whose whereabouts are unknown).

- Mining = creating valid blocks
- Blocks are linked to previous blocks
  - Longest block survive (most difficult)
- Different level of confirmations
  - 3-6 block conf. is considered secure
- Dangerous if someone has more than 50% computing power
  - Can exclude and modify the ordering of transactions

Mining evolution:
+ CPU
+ GPU
+ FPGA (field programmable
 gate array)
+ ASIC Farms
  + Application-Specific Integrated Circuit
  + Whole datacenter

*ASIC scenario:*
- Old miner with 70 GHash/s
- Generates `~0.004 CHF` per day in 2026
- Uses 700W
  - 16.8kWh
  - Cost per day 3.69 CHF -> (Hochtarif, 0.2CHF per kWh)
  - Cost per day 2.18 CHF -> (Niedertarif, 0.15CHF per kWh)

== Discussion
#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Advantages:*
    - Low tx fees
    - Scalable (hardware/storage gets faster)
    - Anonymity (preserving privacy)
    - No major crashes
    - Decentralized
    - Other blockchain use cases
  ],
  [
    *Disadvantages:*
    - High power consumption
    - Not scalable (less transactions per sec than visa)
    - Anonymity (illegal activities)
    - Volatile exchange rates
    - Central elements (devs)
  ],
)


