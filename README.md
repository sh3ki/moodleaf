# MoodLeaf

> A daily mood and journal app that finds the patterns behind how you feel.

---

## Overview

MoodLeaf is a mood tracking and journaling app that helps users log their daily emotional state, attach notes, and discover patterns over time. It surfaces mood trends by time of day, day of week, and tagged life areas — giving users authentic insight into what drives their emotional states.

---

## Problem

Mental well-being starts with self-awareness, but most people have no systematic record of how they feel and what factors correlate with their mood. Without data, it's hard to act on patterns or communicate them to a therapist or coach.

---

## Solution

MoodLeaf combines a simple daily check-in (emoji + intensity + tags + note) with an analytics layer that visualizes mood history, detects trends, and highlights recurring correlations. Entries are private, end-to-end in the user's account, and always accessible.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Auth | Appwrite Auth (email + anonymous) |
| Database | Appwrite Database |
| Real-time | Appwrite Realtime |
| Storage | Appwrite Storage (optional media attachments) |
| State | flutter_bloc |
| Charts | fl_chart |
| Calendar | table_calendar |
| Notifications | flutter_local_notifications |
| Encryption | encrypt (AES-256 for journal text) |

---

## Features

**Core**
- Daily mood check-in: pick an emoji (10 options), set intensity (1–10), add free-text note
- Life area tags: Work, Health, Social, Sleep, Exercise, Family, Finance — multi-select per entry
- Monthly calendar view with color-coded mood dots per day
- Mood history list: scrollable log of all past entries with search
- Streak tracker for consecutive days logged

**Backend & Infrastructure**
- Appwrite Auth supports email/password signup and anonymous sessions (data migrates on account creation)
- Appwrite Database collections: `moods`, `tags`, `users` — document permissions restrict all reads/writes to the owning user ID
- Appwrite Realtime subscription on `moods` collection — syncs new entries across user devices instantly
- Appwrite Storage for optional photo or audio attachments per journal entry, with per-user bucket permissions
- Journal note text encrypted client-side with AES-256 (encrypt package) before writing to Appwrite; decrypted locally on read
- Appwrite Function `weekly-report`: runs on schedule Sunday night, aggregates mood scores for the week, writes a summary document used by the insights screen

**Analytics & Insights**
- Weekly and monthly average mood score with trend direction indicator
- Heatmap grid: 12-week mood intensity by day (fl_chart)
- Tag correlation: which life area tags appear most in high vs low mood entries
- Peak mood time analysis: morning / afternoon / evening average breakdown
- Lowest mood triggers: tags that co-occur with moods below user's personal average

**Notifications & Privacy**
- Daily check-in reminder at user-configured time via flutter_local_notifications
- Gentle nudge if no entry logged by 9 PM
- Journal text never stored in plaintext — all note content AES-256 encrypted before leaving the device
- Anonymous mode lets users explore the app without account creation

---

## Challenges

- AES key management: deriving a stable encryption key from the user's credentials without storing the key server-side
- Building meaningful tag correlation analytics on limited data (30–90 entries) without false pattern noise
- Appwrite Realtime reconnect behavior when the app returns from background on slow connections

---

## Screenshots

_Home · Log Entry · Calendar · Insights_
