## Database Recommendation

For a patient management system (EHR), I strongly recommend **MySQL (RDBMS)**. 

The rationale roots in the ACID properties (Atomicity, Consistency, Isolation, Durability) inherent to RDBMS. Medical records require absolute strictness. If a doctor updates a patient's medication, that update must be strictly consistent and visible to all other hospital staff instantly. NoSQL systems generally favor BASE (Basically Available, Soft state, Eventual consistency), which is unacceptable here—a nurse cannot rely on "eventually consistent" data when administering life-saving drugs. 

According to the CAP Theorem (Consistency, Availability, Partition Tolerance), an EHR must prioritize Consistency and Availability. MySQL ensures structured, highly governed schemas where data types (like blood type, dob) are enforced, ensuring data integrity. 

**If adding a fraud detection module:**
My core recommendation for the Patient Management System would not change; the source of truth *must* remain in an ACID-compliant RDBMS. However, the overall architecture would evolve into a polyglot persistence model. Fraud detection requires analyzing massive volumes of rapidly streaming data (like login attempts, IP locations, access logs) or complex relationships (who accessed what). In this case, I would *add* a NoSQL solution alongside MySQL. For example, a Graph Database (like Neo4j) to map relationships between fraudulent entities, or a fast NoSQL document store (like MongoDB) to capture real-time unstructured audit logs. The core patient data stays in MySQL, while the NoSQL database acts as the analytical engine for the fraud module.
