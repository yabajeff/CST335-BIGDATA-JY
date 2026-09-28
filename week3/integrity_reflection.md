# Integrity and Trade-Off Reflection
# Week 3 - Relational vs. Document Modeling in MongoDB
Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith

In the relational design, a lot of the integrity is enforced by the design database itself. The primary keys are to stop duplicate students, notes, or visits, and the foreign keys being on AdvisingNote.StudentID and SupportVisit.StudentID mean that I can't add a note or visit for a student who doesn't exist. Column types and NOT NULL rules also make sure that every row has the same fields in the same format as eachother. This is fitting of the strong consistency idea from Week 3, where every read should see the same correct data.

In MongoDB, the schema is much more flexible than others, so the database doesn't check these things by default. One student document could spell a field "serviceType" and another spelling it "service_type", or a visit could be missing from its date. If I used separate collections on this, a note could point to a studentId that doesn't exist in the database and nothing would stop it from happening. Embedding will help a little because the notes and visits will live inside with the student, but it also means a document could grow too big over a period of time. 

To protect integrity in MongoDB, I think that adding a JSON Schema validator to the students collection so that required fields like studentId, name, and the visit date and serviceType have to be present and are the right type. I would add a unique index for studentId. The application should also check the input before saving itself, for example it would only allow a fixed list of service types. To maintain, I would run a simple cleanup query every now and then to find documents with missing or misspelled fields or other errors that would occur. 
