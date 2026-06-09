= Week 4
== Key takeaway
=== What is a monorepo, what is a polyrepo?
=== When to use which type?
=== How do AI coding agents change the monorepo vs. polyrepo decision?

== Project setup
General Rules:
+ Be consistent
+ Other projects always prefer other structures
+ A perfect structure does not exist
+ Every project has a readme
+ Follow best practices (e.g java in src/main/java)

Split up:
- Backend, frontend in separate repositories
- ~1 technology per split for simple projects
  - Most likely you won't have a frontend mix of frontend technologies e.g, Angular with Vue 
  - Sometimes you have a script directory with different languages (bash, javascript)
- Keep config out of code (secrets, API keys -> .env not committed)
- More complex setups -> multiple backends, multiple packages

== Monorepo (OneRepo / UniRepo)
- One repository for all projects
  - 1 sub-directory with frontend, 1 sub-directory with backend etc.
- Easier setup for AI agents

#align(center, image("img/monorepo.png", width: 90%))

== Polyrepo (Manyrepo / Multirepo)
- Multiple repository for a project
- Frontend in different repo than backend
- Sync via git submodules or via bash script
  - Submodules: can also be used as dependency management
- Sync with repo or via bash script

== Pro/Cons
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
  Monorepo:
    - Tight coupling of projects
      - E.g., generating openapi.yml from backend, generate types for frontend → simply copy, or tRPC
    - Everyone sees all code / commits
    - Encourages code sharing within organization
    - AI agents: full cross-project context (backend + frontend in one PR)
    - Atomic commits for cross-project changes
    - Scaling: large repos, specialized tooling
    - Risk: cross-package dependencies (one change can affect many service    -)

  ],
  [
  Polyrepo:
    - Loose coupling of projects
      - If you want to generate openapi.yml, you need access from the backend repository to the frontend (e.g., curl+token)
    - Fine grained access control
    - Encourages code sharing across organizations
    - AI agents: possible (--add-dir), but extra setup and token cost
    - Synthetic Monorepo (Nx): bridges repo boundaries without moving code
    - Scaling: many projects, special coordination

  ],
)

== Tools
- Monorepos need tools to manage builds, tests, and dependencies across many packages.
- Tools include pnpm workspaces, Turbo, Nx, Gradle, Bazel, Buck2, or simpler scripts like make/just.
- A key feature is caching: if inputs did not change, the command does not need to run again.
- Main goal: speed up builds and reduce repeated work.