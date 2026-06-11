= Week 5 - Load Balancing
== Key takeaways
=== What types of LB exists?
Hardware, software, and cloud-based load balancers. Software load balancing can happen at L2/L3, L4, L7, DNS level, or with Anycast.

=== Which one to pick?
It depends on control and use case: hardware load balancers are mainly useful if you control your datacenter; cloud load balancers are pay-per-use with many offerings; software load balancers give options like Traefik, Caddy, Nginx, HAProxy, MetalLB, and DNS/Anycast approaches.

=== What is currently “state-of-the-art”?
Modern software load balancers/reverse proxies such as Traefik, Caddy, Nginx, and HAProxy, plus cloud-based L4/L7 load balancers. Additionally, you should measure performance yourself with realistic, reproducible benchmarks.

=== CORS
CORS means Cross-Origin Resource Sharing. Browsers restrict cross-origin HTTP requests from scripts. A common solution is using a reverse proxy so frontend assets and API appear under the same origin. Another workaround is setting Access-Control-Origin during development.

== Load Balancing
#align(center, image("img/load-balancing.png", width: 90%))

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *What is load balancing?*
    - Distribution of workload across multiple computing resources
      - Workloads (requests)
      - Computing resources (machines)
    - Distributes client requests or network load efficiently across multiple servers
      - E.g service gets popular, high load on service
    -> Horizontal scaling

    *Why load balancing?*
    - Ensures high availability and reliability by sending requests only to servers that are online
    - Provides the flexibility to add or subtract servers as demand dictates
  ],
  [
    #align(center, image("img/load-balancing-2.png", width: 90%))
  ],
)

=== Types of load balancer (Cloud, Hardware, Software)
==== Hardware load balancer
- HW-LB use proprietary software, which often uses specialized processors
  - Less generic, more Performance
  - Some use open-source SW, e.g HA-proxy
- E.g loadbalancer.org, cisco, kemp
- Only if you control your datacenter

==== Software load balancer
- L2/L3: MetalLB (Kubernetes bare-metal, standard solution for type: LoadBalancer on bare-metal/kind clusters without a cloud LB), Seesaw (not widely used)
- L4: HAProxy (desc), Nginx, Gobetween, Traefik
- L7: Enovy (C++), HAProxy (C), Nginx (C), caddy (golang), Gobetween (golang), Eureka (java) - services register at eureka, traefik (golang)

Measure performance yourself with realistic, reproducible benchmarks instead of relying only on opinions or generic benchmark results.

*L4 vs L7 Load Balancing:*
- L7: more resource intensive, can make smarter decisions
- L7: terminates TLS and inspects HTTP (encryption overhead)

*DNS Load Balancing* (L7):
- Round-robin DNS
  - Easy to setup, client-side selection
  - Drawback: negative caching impact
  - Used in Bitcoin Core: dig dnsseed.emzy.de
  - Example:
  ```c
  www A 188.40.119.115
  lb  A 188.40.119.115
  lb  A 152.96.80.48
  ```

- Split horizon DNS
  - Different DNS information, depending on source of DNS request

- Layer 3: Anycast
  - Multiple servers announce the same IP address from different location
  - Requires ownership of an AS and BGP routing

Main idea: software load balancing can happen at HTTP level, DNS level, or IP routing level, each with different complexity, performance, and control.


==== Cloud-based load balancer
- Pay for use, many offerings
- AWS
  - Application Load Balancer ALB (L7)
  - Network Load Balancer (L4)
  - Classic Load Balancer (legacy)
- Google Cloud (L3, L4, L7)
- Cloudflare (L4, L7)
- DigitalOcean (L4)
- Azure (L4, L7)

=== Load Balancing Algorithms
- Easiest: round-robin / random
  - distributing requests evenly by rotating through a list of servers.
  - Make sure your services are stateless
- Stateless: don't store anything in the service
  - If you do, you need a stick session (avoid this) - same user to same service
  - E.g cookie, ip_hash - send to same machine 
- Health checks: tell your load balancer if you are running low on resources
  - Active: send active probes e.g every 3s
  - OOB - out of band (API to check health) e.g necessary with DB, as connection may be OK, but database not
  - Passive: only check with request
  
- Different behaviour:
    - Nginx: passive, caches requests, so if an upstream fails, it uses another
    - Caddy: passive, does not cache, but marks upstream as failed for the next request

Round-robin:
- Loop sequentially
- Simple algorithm, often default
- May drop requests on congested nodes

Weighted round-robin:
- You can put weighted in from everything
- Some servers are more powerful -> more powerful machines get more work
- But high variance in server load may drop requests

Least connections / fewest current connections to clients:
- Load balancer sends the request to the server that currently has the fewest outstanding requests
- Keep track of outstanding requests
- Not best for latency -> does not know if requests in queue are fast or slow

Peak exponentially weighted moving average:
- Measures average on how long a server takes to respond and gives importance to recent measurements
- Considers latency
- Increased complexity

=== Traefik
- Open Source, software-based load balancer
  - L4/L7 load balancer
  - Traefik is written in Go
  - Can support authentication mechanisms, especially for the dashboard
  - HTTP/3 support
- Has a built-in dashboard
- Traefik provides an official docker image

=== Service
- As a start -> is stateful
- Written in Go
- Stickiness with cookies
- Weighted round round-robin
  - Load balances between services and not between servers

=== Caddy
- Configuration: dynamic
  - Static: Caddyfile
- One liners:
  - Quick local file server: caddy file-server
  - Reverse proxy: caddy reverse-proxy --from example.com --to localhost:9000
- Open source, software-based load balancer
- L7 load balancer
- Reverse proxy
- Static file server
- HTTP/1.1, HTTP/2, HTTP/3
- Caddy is on docker hub
- Automatic HTTPS (Let's Encrypt)

=== Nginx
- Free and commercial version
- Fast webserver, 35% market share
- HTTP proxy, mail proxy, reverse proxy, load balancer
- No active health checks, no sticky sessions

=== HAProxy
- L4 and L7 load balancer and reverse proxy
  - Open source option: commercial support
- Fast performance
- Configure and run: /etc/init.d/haproxy start
  - Algorithms: roundrobin, leastconn, source
  - Sticky session: cookie
  - check -> health checks (passive / active)
- Primary/secondary: backup server only receives traffic when all primary servers fail
- Dynamic backend discovery via server-template + DNS resolvers
- Built-in dashboard
- Rate limiting and connection throttling built-in

== Web Architecture
=== Server-Side rendering
- Classic approach: SSR
- Server generates HTML/JS/CSS (dynamically)
  - User request: browser sends a request to the web server (server-side routing)
  - Server processing: server processes request by running server-side code (`C#`, Java, ...)
    - May require data from database or other sources
    - Server-side code can use template engines or a framework to render the HTML
  - Response: Generate the appropriate HTML, CSS and JavaScript for the requested page
  - Browser rendering: browser receives response and renders page
- Advantage: SEO, immediate display
- Disadvantage: server rendering for every request (caching), UI logic on the server
- Static site generation (SSG): pre-render HTML/CSS/JS: only once, regenerate if content changes

#align(center, image("img/SSR.png", width: 90%))

== Single Page Application SPA / CSR
- Interactions occur within a single web page
- App-like experience: client page dynamically updates as user interacts
- Relies on JavaScript to update UI, typically:
  - Initial response: server returns a single HTML file with references to CSS/JavaScript
  - Browser rendering: shows initial empty HTML file with a spinner, then executes JavaScript, then shows UI
- User interactions: JavaScript manages the UI updates. Application does not require full page reloads. When you click a link in an SPA, instead of making a traditional HTTP request:
  - JavaScript intercepts the click events
  - Prevent default browser navigation
  - Update the URL using the History API
  - Render new content without requesting new HTML document, but may involve fetching data
- Fetching data: When the SPA needs to fetch or send data, communicates through APIs
- Use a framework: React, Angular, Vue
- Backend serves API requests only
- SEO only works if JavaScript is executed
  - Crawler gets JavaScript code, needs to execute, then it knows the content
- Good separation: UI in HTML/CSS/JS, backend in /api
- Client-side routing: SPAs for navigation
  - Server side routing -> default to index.html
- Typical setup
  - `/ -> index.html`
  - `/user -> user.html`

#align(center, image("img/SPA.png", width: 90%))

=== CORS
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    - CORS = Cross-Origin Resource Sharing
    - For security reasons, browsers restrict cross-origin HTTP requests initiated from scripts
    - Mechanism to instruct browsers that run a resource from origin A to run resources from origin B
    - Solution: reverse proxy with webserver
      - Many solutions, caddy, vite/webpack dev server, nginx, mix -> the client only sees the same origin for the API and the frontend assets
    - "Workaround": Access-Control-Origin: https://...
      - For dev: Access-Control-Origin: `*`
      - Pre-flight requests
      - Golang: w.Header().Set("Access-Control-Origin", "`*`")
  ],
  [
    #align(center, image("img/CORS.png", width: 100%))
  ],
)

=== SSR vs CSR
Performance Metrics:
- TTFB (Time to First Byte): Server response time
- FCP (First Contentful Paint): When content first appears
- TTI (Time to Interactive): When page becomes fully interactive
- Trade-off: SSR good at FCP/TTI, CSR requires full JS execution first

SSR vs CSR Initial Load:
- SSR: visible and interactive immediately (no JS needed)
- CSR: Must download, parse, execute JS before interactive
- Post-load: CSR good: no page reloads for navigation, feels like desktop appears

CSR Advantages:
- Lower server rendering load
- API only serves JSON

CSR Disadvantage:
- Bundle Size Problem: Large JS files, slow parse/execution, mobile may struggle
- Slow initial load: white screen until JS executes
- SEO problem: crawlers see empty html, need JS executing to read content

Why CSR? Clean architecture (frontend/backend separation)

=== CSR Improvements
- Code splitting, lazy loading, hybrid approach with hydration (when a page is first sent as HTML but still has to load JavaScript to make HTML interactive)
  - Hydration problems:
    - Duplicated work / complexity 
    - Pre-rendering only: PrevelteKit
- Server Components (React)
  - Components render only on server, no JS sent to client
  - Reduces bundle size
- Server HTML fragments
  htmx: server replies with HTML fragments
- Island architecture
  - Static HTML with interactive islands
  - Only islands ship JS - minimal JS by default (Astro)
- Streaming SSR
  - Send HTML in chunks as ready
  - Browser renders earlier - improves perceived performance
- Edge rendering
  - Render closer to user geographically at CDN edge locations (Cloudflare Workers, Vercel Functions)
