# Funding Match programme: monthly runbook

Owner: Flavia Richardson, Acclivity Ventures. Plan: https://claude.ai/artifact/UpWwoFXjZEUG45ttVio5Ea
Files in this folder: template.html and template.txt (the approved email, Instantly merge fields), match-shortlist.sql (call shortlist and audience queries), example-variable-robotics.html (the approved test, 14 Nov 2026).

## Standing rules (never break)
- One email per company per month, and only when a call genuinely fits. No match, no send. Never send the same call to the same company twice.
- Send only from the Flavia Richardson Instantly inboxes, never from flavia@acclivityventures.co.uk. Maximum 30 emails per inbox per day. Single step, no automatic follow-ups.
- Verified addresses only (contact_register.reoon_status safe or valid). Exclude suppressed contacts, suppressed_emails, suppressed_domains, the Instantly blocklist, investors, academic, public and personal addresses, current clients and open CRM deals, and anyone in another live Instantly sequence this month.
- Never reply to negative or do-not-contact replies: blocklist them in Instantly and add them to suppressed_emails.
- UK English. No em dashes or en dashes anywhere. Subject always starts "Acclivity Ventures".
- Every fact in an email (deadline, award, eligibility) must match the official call page. If a deadline cannot be verified, drop that call.
- Claude never presses Start. Claude builds the campaign paused; Flavia approves the match sheet and presses Start herself.
- The design is fixed: logo mark alone on a light header (no wordmark), website colours (paper #FAF6EE, cobalt #1500A0, teal #0D8A6E, ink #1A1D24, footer #1A2236). Do not restyle it.

## Data
- Website database: Lovable project 3e52fbdd-f3b0-414f-96bf-3a7aa5c29214, read with Lovable query_database (SELECT only).
- Audience: contact_register, sectors 'AI/Semiconductors/Robotics', 'Life Sciences', 'Defence & Dual-Use' (about 1,365 sendable companies on 14 Nov 2026). Most rows have no country and no company description, so enrichment is needed before matching.
- Calls: grants table, shortlisted by match-shortlist.sql (deadline 21 to 120 days out, UK or Europe, company-eligible, quality score 80+).
- History: previous "Funding Match" campaigns in Instantly. Each lead carries custom variable call_id; check it before reusing a call for a company.

## Monthly cycle
Day 1 (Crunchbase reset): spend the month's Crunchbase allowance (500,000 data tokens). Order: (1) Track B investor segment expansion, (2) enrich target companies with a short description, country and funding stage, oldest unenriched first. Check cb_metering_get_state before and after.

Week 1 (match sheet):
1. Run the shortlist query. For each shortlisted call, open its weblink and confirm deadline, award and who can apply. Drop any call you cannot verify.
2. Run the audience query. For each company, using its enrichment description, choose the single best verified call or NONE. Rules: the company must be eligible to apply (UK company for UK calls; Horizon/EDF consortium calls only if the email says a partner is needed); the call must fit what the company actually builds. When in doubt, NONE.
3. For each match write: call_short (max 6 words), call_name, funder, sector_label, sector_phrase (for the footer, e.g. "robotics"), award, deadline_label ("Deadline" or "Concept paper (optional)"), deadline_label_lc, deadline ("4 December 2026, 14:00 GMT"), who_can_apply, cofunding, call_url, why_1 to why_3 (one sentence each: why_1 about the company's own work, why_2 about eligibility or award fit, why_3 about the practical next step), month_label ("January 2027"), call_id (grants.id).
4. Build the match sheet (company, contact, sector, call, deadline, the three why lines, or the reason for NONE) and publish it to Flavia. Ask her to approve, edit or drop rows.

Week 2 Monday (after approval):
5. Create the Instantly campaign "Funding Match, <Month YYYY>": Flavia Richardson inboxes only, weekdays 09:00 to 17:00 Europe/London, daily limit within 30 per inbox, stop on reply, open tracking off, one step. Subject: "Acclivity Ventures: {{call_short}} for {{companyName}}". Body: template.html exactly (the merge fields fill from the lead's custom variables).
6. Add only approved leads with all custom variables. Re-check verification and suppression immediately before loading. Leave the campaign paused and send Flavia the resume link. She presses Start on the second Tuesday.

Weeks 2 to 4: the weekday reply sweep handles replies. MATCH replies: draft the eligibility checklist reply for Flavia's approval.

Week 4: report sends, replies, MATCH requests, portal sign-ups (funding_subscribers created this month), bounces and unsubscribes. Recommend rule changes.

## Track B: investor segments
Segments: defence and dual-use funds; life sciences and medtech investors; semiconductors, hardware and robotics funds; AI-first seed and Series A funds; family offices and corporate venture arms in deep tech (start with the 6 Web Summit 2026 investors); engaged investors (Q4 Investor Briefing clickers and repliers). Never mail the bulk investor universe.
Each month: find investors that led or joined rounds in the last 12 months in UK or European companies in the segment, plus co-investors of engaged investors; pull recent portfolio companies. Draft a personal note from Flavia only when at least one open call fits at least one portfolio company: name the call and up to two portfolio companies, two sentences on why, offer a portfolio-wide match list by reply. Flavia approves each segment batch; campaign "Investor Match, <Month YYYY>", sent on the Thursday of week 2.

## Open items (14 Nov 2026)
- Portal sign-up URL: the button points to www.acclivityventures.co.uk/funding-tracker until Flavia confirms the sign-up page.
- Pilot: December 2026, up to 300 companies with the strongest enrichment, built on 30 November.
