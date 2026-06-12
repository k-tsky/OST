= Week 6
== Key takeaways
=== Explain what MCP is, why it exists, and how tool calling works (tools/list, tools/call, JSON-RPC)
MCP is an open protocol by Anthropic that connects AI agents to external tools, data sources, and services. It exists to avoid every AI app needing custom connectors for every tool.
Tool calling uses JSON-RPC 2.0:
- tools/list: asks what tools are available
- tools/call: runs a selected tool with arguments


=== Describe the MCP message flow between user, client, LLM, and MCP server
The flow is: `user -> assistant (tool_call) -> tool (result) -> assistant (answer)`.

The LLM decides whether to call a tool, sends the tool call, receives the result, and then creates the final answer. Tool results must include the correct `tool_call_id`.

=== Discuss challenges of running MCP in the browser and how WebMCP addresses them
Browsers can block or limit external fetching, causing errors like `"could not fetch"`.

WebMCP solves this by using browser-side tools, for example a Firefox extension that injects a `client_web_search` tool and acts like an MCP server.

=== What authentication mechanisms exists for web applications?
- Passwords / single-factor authentication
- MFA / 2FA
- TOTP software tokens
- Basic Auth
- Digest Auth
- mTLS
- Session-based authentication
- JWT
- Access + refresh tokens
- OAuth


=== How can stateless authentication be achieved?
Stateless authentication can be achieved with JWTs.

After login, the server creates and signs a token. The client sends it on future requests with `Authorization: Bearer <token>`. Because every server instance can verify the token, the server does not need to remember a session.

== Model Context Protocol (MCP)
- By anthropic, november 2024, open-source
    - Claude Opus / Sonnet
- Donated to linux foundation -> no single company controls it
- Connects AI agents to external tools, data sources and services
    - Universal Protocol
    - Implemented once, works everywhere
- Before MCP: every AI app needed a custom connector per tool (NxM problem)
    - Doesn't scale, fragile, duplicated effort
- Born from a single devs frustration copy-pasting between claude desktop and his IDE
    - Not a corporate strategy, solving an annoying workflow problem

=== MCP API
The MCP API uses JSON-RPC 2.0 for communication between an MCP client and an MCP server.

First, the client sends a `tools/list` request. This asks the server which tools are available. The server responds with an array of tools. Each tool contains a name, a description and an input schema that defines which arguments are required.

Afterwards, the client can use `tools/call` to execute one of these tools. The request contains the tool name and the required arguments. The MCP server then runs the tool and returns the result.

In short, `tools/list` is used to ask "what can you do?", while `tools/call` is used to say "run this tool with these arguments".

=== MCP Sequence Diagram
#align(center, image("img/MCP.png", width: 100%))

=== Simple MCP Server
A simple MCP server can expose tools that an LLM is allowed to call. In this example, the server provides one tool called `measure_endpoint`, which measures the response time of a given URL.

The available tools must be included in the LLM request. Each tool has a name, a description and a parameter schema. Based on the user request, the LLM decides whether a tool should be called, which tool to call and which arguments to use.

The usual role flow is:

`user -> assistant (tool_call) -> tool (result) -> assistant (answer)`

This means the user first asks a question, the assistant decides to call a tool, the tool returns the result and the assistant uses that result to generate the final answer.

The OpenAI Chat API is stateless, which means previous tool calls and their results are not remembered automatically. Therefore, after the tool has been executed, a second call to the LLM is required. This second request includes the original user message, the assistant message containing the tool calls and the tool result messages.

Each tool result must reference the correct `tool_call_id`. The LLM generates this ID when it requests a tool call and the application must echo it back in the matching tool response. If multiple tools are called, multiple `role: "tool"` messages must be returned, each with its own matching `tool_call_id`.

Using the wrong role or an incorrect `tool_call_id` can lead to errors or incorrect generated results, because the LLM can no longer reliably match tool outputs to the requested tool calls.

=== MCP in the Browser
- The client sends the available tools together with the user query.
- The LLM returns tool calls with names and arguments.
- The tool result is sent back to the LLM to generate the final answer.

*Problem:* A normal LLM running in the browser cannot reliably access external websites or fetch linked resources by itself. Browser restrictions, missing tool access or rate limits can cause errors such as "could not fetch". Therefore, the model needs a way to use browser-side tools.

- A Firefox extension can intercept API requests and inject a `client_web_search` tool.
- The extension acts like the MCP server, so no separate MCP server is needed.
- This allows the LLM to search or fetch web content through the browser.
- In the future, WebMCP could allow websites to expose tools directly through the browser.

== Authentication
- Single-factor authentication, e.g password
- Multi-factor authentication / 2FA, e.g password and software token, SMS unsecure
- Password rules - don't:
    - Name of a pet, child, family member, or significant other
    - Anniversary dates and birthdays, birthplace
    - Name of a favorite holiday
    - The word "password"
- Don't reuse passwords, use password managers
- Don't enter passwords on unencrypted sites
- Use Argon2id for password storage
- Hashtype: WPA/WPA2
- Software token: TOTP (Time-based One-time Password)
    - Often used as 2nd factor (e.g Google Authenticator)
    - Based on keyed-hash message authentication code
    - ~hash(key + message)
    - K = shared secret
    - T = current unix time / 30s
    - TOTP(K, T) = Truncate(HMAC-SHA-256(K,T))
- Where should auth happen?
    - In service, e.g your HTTP server
    - In load balance, e.g traefik, jwt

=== Information security - key concepts / access control
- Confidentiality
    - Protects against eavesdroppers
- Integrity
    - Protection against data modification
- Availability
    - Data needs to be available when needed
- Non-repudiation
    - Neither the sender nor the receiver can deny that a communication has taken place
- Identification
    - E.g with a username "alice", claiming to be Alice
- Authentication
    - Verifying a claim of identity, e.g alice shows passport, authentication types:
        - Something you know: things such as a PIN, a password
        - Something you have: a key, a swipe card
        - Something you are: biometrics: fingerprint
- Authorization
    - What resources an authenticated user is permitted to access

=== Basic Auth
Client sends a username and password with a HTTP request.

- Should be used with HTTPS
    - With basic auth the password isn't encrypted
    - Password gets Base64 encoded
        - Base64: encoding format, not security. Can be decoded by anyone
    - Client will provide something like: `Authorization: Basic <base64>`
- Can be encoded in URL
- Server will reply with header
    - WWW-Authenticate: Basic realm="restricted area"
    - The user will see the information "restricted area"

=== Digest Auth
- Hash + nonce, against replay attacks
- Server send
    - `WWW-Authenticate: Digest realm="testrealm@host.com"`
- Client sends in HTTP header
    - `Authorization: Digest username="Alice"realm="testrealm@host.com", nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093", uri="/dir/index.html"`
- Advantages
    - PW not in clear text (MD5), can be "SHA-256", "SHA-256-sess", "SHA-512" and "SHA-512-sess"
        - sess: "session key" for "authentication session"
    - Nonce for replay protection for client and server
- Disadvantages
    - Browser L&F
    - Cannot use scrypt or bcrypt to store PWs

=== mTLS
Basic explanation: With mTLS both sides verify each other. e.g:\
Client checks: Is this really the server?\
Server checks: Is this client allowed?

- Create SSL CA certificates for server with openssl command
- Create CA / server cert
- Create client certificate
- Add caddy security in your local network (tls_client_auth)
    - If the certificate is missing or invalid inside caddy then the request is rejected

=== Lets Encrypt
- Free, automated, open certificate authority
- Provides domain control via challenges 
- HTTP-Challenge verification
    - Server must be publicly reachable
    - Token replaced at /.well-known/acme-challenge/
    - Let's encrypt verifies token via HTTP request
- DNS-Challenge verification
    - Server does not need to be publicly reachable
    - Enables wildcard certificates (valid for all subdomains)
    - Token placed as TXT record in DNS
    - Let's encrypt verifies the DNS entry
- Certificates valid for 90 days (currently)
    - May 2026: opt-in 45-day certificates
    - Feb 2027: default 64-day certificates
    - Feb 2028: default 45-day certificates
    - Optional: 6-day short-lived certificates (since 2026)
- Integrated in modern web servers (e.g caddy)

=== Session-based authentication (stateful)
- The server remembers that a user is logged in.
- This can lead to problems with multiple service instances because the session is only stored in the memory of that instance
- E.g SpringBot (JSESSIONID)

=== JSON Web Token (JWT) (stateless)
- JSON-based access tokens
    - Header: {"alg":"HS256"}
    - Payload: {"sub":"tom", "role":"admin","exp":"1422779638"}
- All server instances know a secret token / public key
- When user logs in, server send back token
- Client sends: Authorization: Bearer <token>
- Token: const_user_token = base64urlEncoding(header) + '.' + base64urlEncoding(payload) + '.' + base64urlEncoding(signature)
- Signature (simple): keyed-hash message ~hash(base64(header)+base64(payload) + secret token)
- Client can store token in `localStorage.setItem("token", accessToken);`

Flow:
1. User logs in with username/password
2. Server checks if login is correct
3. Server creates a JWT
4. Server signs the JWT with the secret key
5. Server sends the finished JWT back to the client
6. Client sends this JWT with future requests

=== Access Token / Refresh Token
#align(center, image("img/access-refresh-token.png", width: 100%))

*Access Token:*
- Short lifetime, e.g 10min
- If public key / secret is known, the content in the token can be trusted
- Can have userId, role etc -> no need to query DB for those Information

*Refresh Token:*
- Longer lifetime, e.g 6 months
- Used to get a new access token
- IAM / Auth server creates access tokens

*Only access token:* If a user credential is revoked, how is every service informed?

*Only refresh token:* For every request to Service, Auth needs to be involved for access

*Access + Refresh token:* If a user credential is revoked, user has max. 10 min more to access service, but auth is only involved if the access token is expired

=== OAuth
- For authorization with 3rd party integration
    - Grant access without giving away passwords
- Authorization code grant 
    - User redirected to authorization server
    - User authenticates and grants permission
    - Authorization code returned to app
- PKCE: variant for clients that cannot store a client secret securely (mobile, SPA)
- Token issued are typically JWTs (access + refresh)
#align(center, image("img/OAuth.png", width: 80%))

