# WISE² GTA VI Launch Sprint — 2026-11-10

Status: PLANNED / NOT DEPLOYED. Official launch: November 19, 2026.

## Objective
Launch an independent, unofficial GTA VI fan companion called Open World Atlas, connected to WISE² Sweaty AI Clipper and Roleplay District community. Preserve existing services and WISE² internal operating model.

## Phase 0 — Audit and protect
- Inventory code in wise2-core, Wise2-Production-, wise2-dashboard, wise2-ecosystem and other accessible repositories for GTA, atlas, clipper, Sweaty, gaming, Discord and roleplay references.
- Inventory VPS Docker services, DNS, disk space and existing deployments; verify access before modifying anything.
- Backup relevant application code, database and persistent volumes; record rollback.
- Identify actual ownership/availability of candidate domains; do not assume purchased.

## Phase 1 — Public MVP
- Responsive dark/cyan cinematic landing, countdown, console/preload guide, newsletter and Discord entry.
- Interactive map shell with verified locations only, source attribution, spoiler toggle and community submission moderation.
- Original branding; clear 'Unofficial fan project, not affiliated with Rockstar Games or Take-Two' disclaimer.
- Do not copy Rockstar copyrighted assets without permission or claim GTA VI multiplayer/mod support.

## Phase 2 — Creator tools
- Reuse verified Sweaty clipping pipeline, connect opted-in creators, create vertical highlights and moderation.
- No automatic publishing without creator approval.
- Measure signup conversion, clip processing reliability and site performance.

## Phase 3 — Launch readiness
- Test mobile accessibility, load, auth, consent, security, signup, checkout (if enabled), monitoring and rollback.
- No paid ad spending before checkout and conversion tracking are verified.
- Launch November 18–19; verify publicly accessible URLs with independent HTTP and functional tests.

## Owners and gates
Every item must be labeled NOT STARTED / IN PROGRESS / TESTED / VERIFIED. Audit -> fix -> test -> independent verification. No production deployment implied by this document.
