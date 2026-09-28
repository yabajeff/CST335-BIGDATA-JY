# Week 3 - Relational vs. Document Modeling in MongoDB
Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith
## collections

I used a single collection named `students`. Each student document has two embedded arrays:

- `advisingNotes` - the student's advising notes
- `supportVisits` - the student's tutoring, writing center, and workshop visits

## sample document

```json
{
  "studentId": "S1001",
  "name": "Maria Lopez",
  "email": "mlopez@csp.edu",
  "major": "Sonography",
  "advisingNotes": [
    {
      "date": "2026-08-28",
      "advisor": "Mr. Smith",
      "category": "academic plan",
      "text": "Reviewed fall schedule and course registration."
    }
  ],
  "supportVisits": [
    {
      "date": "2026-09-03",
      "serviceType": "tutoring",
      "description": "Anatomy tutoring session"
    }
  ]
}
```

## why I embedded

The main thing advisors want is a quick picture of one student, so putting all of the notes and visits inside the student document means that one query will return everything. Notes and visits always belong to one student and are not shared, so that embedding them makes sense. The number of notes and visits per student in a single semester is small, so the documents should not get too large. If a student were to build up years of history, I would think about moving visits to their own collection and then referencing to the studentId instead.
