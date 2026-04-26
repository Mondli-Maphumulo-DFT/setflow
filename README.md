# SetFlow

> The operating system for touring artists. Built in Johannesburg, made for the world.

**Live:** [setflows.netlify.app](https://setflows.netlify.app)

SetFlow is a tour management platform for elite touring DJs and the teams that move them. It replaces the spreadsheets, WhatsApp threads, and inbox chaos that headliners currently rely on with one beautifully designed, mobile-first product.

---

## Repository structure

```
.
├── index.html          # Public marketing site (setflows.netlify.app/)
├── app/
│   └── index.html      # Authenticated dashboard app (setflows.netlify.app/app/)
├── netlify.toml        # Netlify routing + security headers
└── README.md
```

Two separate HTML files, intentionally. The marketing site is public — anyone can browse, read pricing, sign up. The dashboard at `/app/` is auth-gated — visiting without an active Supabase session bounces you back to `/`.

---

## Stack

- **Frontend:** Vanilla HTML / CSS / JS (no build step, no framework)
- **Auth + DB:** [Supabase](https://supabase.com) — Postgres with Row Level Security
- **Hosting:** [Netlify](https://netlify.com) — auto-deploy from `main`
- **Forms:** Netlify Forms (contact form on landing page)
- **Maps:** Leaflet + OpenStreetMap tiles (free, no API key)
- **Fonts:** Google Sans, Roboto, Roboto Mono

Total monthly hosting cost in Phase 1: **R0** (free tiers).
Phase 2 (paid Supabase + Netlify Pro): **~R800/mo**.

---

## Local development

No build step. Open the files directly in a browser, or serve them with any static file server:

```bash
# Python 3
python3 -m http.server 8000

# Or Node, if you prefer
npx serve .
```

Then visit `http://localhost:8000` for the marketing page, `http://localhost:8000/app/` for the dashboard.

---

## Deployment

Push to `main` → Netlify auto-deploys in ~10 seconds. That's it.

For preview deploys before merging:

```bash
git checkout -b my-change
# make edits
git push origin my-change
```

Netlify creates a preview URL like `my-change--setflows.netlify.app` automatically.

---

## Supabase setup

The schema lives in `setflow_supabase_setup.sql` (kept separately). To set up a fresh Supabase project:

1. Create a new project at supabase.com
2. SQL Editor → New query → paste the contents of `setflow_supabase_setup.sql` → Run
3. Authentication → Providers → Email → toggle **Confirm email** OFF (for instant signup → login)
4. Update `SUPABASE_URL` and `SUPABASE_ANON` constants in both HTML files

The schema creates three tables: `profiles`, `artists`, `gigs`. RLS policies ensure each user only sees their own data. A trigger auto-provisions a profile + default artist whenever someone signs up.

---

## The auth flow

```
Visitor lands on /
   ├─→ clicks Sign up      → modal → Supabase signUp → /app/
   ├─→ clicks Sign in      → modal → Supabase signInWithPassword → /app/
   └─→ already signed in   → nav shows "Open app →" button

Visitor lands on /app/
   ├─→ has session         → load profile + gigs → dashboard
   └─→ no session          → redirect to /
```

Supabase persists sessions in `localStorage`, so signing in on `/` immediately works on `/app/` without an extra round-trip.

---

## Pricing

| Tier         | Price            | For                                    |
|--------------|------------------|----------------------------------------|
| Starter      | R0 / forever     | Artists exploring · 5 active bookings  |
| **Pro**      | **R5,400 / mo**  | Working artists + their managers       |
| Headliner    | R14,400 / mo     | Agencies & rosters of 5+ artists       |

All prices in ZAR. 14-day trial, no credit card required.

---

## Roadmap

**Shipped**
- Marketing landing page with three role pillars
- Authenticated dashboard with pipeline, calendar, tour map, revenue, contracts, riders, team
- Multi-currency support (ZAR primary)
- Supabase auth + database persistence for gigs
- Mobile-responsive across all views

**Next**
- Reactive dashboard stats (currently still partly hardcoded)
- Demo data seeder for empty accounts
- Drag-to-update gig status in pipeline kanban
- Riders + team migrated to Supabase
- Promoter-specific app view

**Later**
- DocuSeal or DocuSign integration for contract e-sign
- Stripe / Paystack billing
- Spotify + Apple Music API integration (artist profile enrichment)
- Native iOS / Android apps

---

## Built by

[DithaNimba Holdings](mailto:hello@dithanimba.com) · Johannesburg, South Africa 🇿🇦

---

## License

Proprietary. © 2025 DithaNimba Holdings. All rights reserved.
