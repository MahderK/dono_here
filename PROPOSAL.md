# Project proposal

**Due:** Sunday 8 November 2026 · **Submit:** commit it as `PROPOSAL.md` in the root
of your group's repository and tag that commit `proposal`

Replace every *italic* instruction with your own text. Keep the whole
proposal under four pages.

---

## 1. DonoHere

An app that helps blood donation services and donors to coordinate and request donations so that the process is more efficient and accessible.
## 2. Group

*Student IDs, emails and GitHub usernames are in `project.yaml`; do not
repeat them here.*

| Name | Role |
|---|---|
| Liya Belay | Flutter dev, donor side |
| Maedot Berhanu | UI/UX + state management |
| Mahder Kassaw | Tech lead + backend/API |
| Siham Tewekel | QA + docs + notifications |
| Wangari Dereje | Flutter dev, blood service side |

## 3. The problem

*Who has this problem? How do they deal with it today? Why is a mobile
app the right solution? Two or three paragraphs. If you have talked to a
potential user, say what you learned.*

## 4. Users

*Describe two or three types of user (for example, "a first-year student
who does not know the campus" and "a club organiser who posts events").
For each: what they need from the app and how often they would use it.*

## 5. User stories

1. As a donor or requester, I want to register and sign in so that my profile and requests are linked to me. (must)
2. As a donor, I want to create a profile with my blood type, area and availability so that people who need blood can find me. (must)
3. As a requester, I want to post a blood request with blood type, units needed, hospital and urgency so that donors know where help is needed. (must)
4. As a requester, I want to see nearby donors with the matching blood type so that I can reach the right people quickly. (must)
5. As a donor, I want to see open requests near me that match my blood type so that I can choose where to help. (must)
6. As a donor, I want to respond to a request so that the requester knows someone is coming. (should)
7. As a requester, I want the app to suggest the most suitable donors for my request so that I do not have to check every profile. (should)
8. As a requester, I want to mark a request as fulfilled so that it disappears from the active list. (could)


## 6. Screens

*List every screen with one line describing what it shows and which user
stories it serves. Add hand-drawn or simple digital sketches for the four
most important screens (photos of paper sketches are fine).*

| Screen | Purpose | User stories |
|---|---|---|
| Sign in / Register | Create an account or sign in | 1 |
| Home (open requests) | List open requests near me that match my blood type | 5 |
| Donor profile | Create or edit blood type, area and availability | 2 |
| Create request | Form for blood type, units, hospital and urgency | 3 |
| Nearby donors | List or map of matching donors close to a request | 4, 7 |
| Request detail | Full request info, respond button, mark as fulfilled | 6, 8 |
| My requests | Requests I posted and their status | 3, 8 |

## 7. Data model

*The main entities and their fields, and how they relate. A simple
diagram or a list such as:*

```
Event: id, title, start, venue, description, organiserId
User: id, name, email, programme
Registration: userId, eventId, createdAt
```

## 8. Data sources

*Which data is stored locally (and with what: shared_preferences, drift)?
Which comes from a REST web service (one you build or find), and which
from Firebase (Auth, Firestore)? Every project needs local persistence, a
REST source and Firebase.*

## 9. Device feature and AI feature

*Every project needs one device feature (camera, location or a sensor)
**and** one AI feature (for example a summary or a suggestion). For each,
say which user story needs it. For the device feature, say which
permissions it asks for; for the AI feature, what data is sent and to
whom.*

## 10. Risks

*Three to five things that could go wrong (a third-party API might be
unavailable, a feature might need a paid service, a member has exams)
and what you will do about each.*

| Risk | Likelihood | Plan |
|---|---|---|
| | | |

## 11. Milestone plan

*Which user stories will be complete at Milestone 1 (week 6), Milestone 2
(week 10) and the final submission (week 14)? Milestone 1 should contain
all screens with navigation and in-memory state; Milestone 2 should
contain real data.*

## 12. AI-use plan

*Which AI tools, if any, does the group intend to use, and for what
(learning, generating boilerplate, reviewing code, writing tests)? See
`../syllabus/policies.md`.*

---

## How the proposal is marked (10 points)

| Criterion | Points |
|---|---|
| The problem and the users are specific, and one real person who has the problem is named | 2 |
| User stories in the given form, each marked must, should or could | 2 |
| The screens and the data model cover every "must" story | 2 |
| Local, REST and Firebase data named, and a device feature and an AI feature chosen | 2 |
| Risks and the milestone plan are realistic for four people and the course weeks | 2 |

## Approval

The instructor returns each proposal with one of these decisions and a
short written comment:

- **Approved.**
- **Approved with changes** — the changes are listed; make them before
  Milestone 1.
- **Revise and resubmit by the date given in the comment** — the group may not start
  Milestone 1 work on the parts that must be revised.
