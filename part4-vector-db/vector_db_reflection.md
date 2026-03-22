## Vector DB Use Case

A traditional keyword-based database search (like SQL `LIKE` or Elasticsearch exact match) would likely **fail** to suffice for a legal system where lawyers search 500-page contracts using plain English. 

Keyword searches rely on lexical matching. If a lawyer asks, "What are the termination clauses?", a keyword system looks for the exact word "termination". However, the contract might use phrasing like "If the employee is let go," "Severance of the agreement," or "Ending the partnership." Because the specific keyword "termination" is missing, the traditional DB will return zero results, missing critical legal information.

A Vector Database plays a transformative role here by enabling **semantic search**. Instead of storing raw text, an AI embedding model converts the contract sentences and the lawyer's question into mathematical vectors (arrays of numbers) representing their *meaning*. Sentences with similar meanings are plotted close together in a multi-dimensional space. 

When the lawyer asks about "termination clauses," the vector database calculates the geometric distance (like Cosine Similarity) between the question's vector and the document vectors. It successfully identifies that "severance of agreement" is semantically clustered right next to "termination," returning highly accurate, context-aware results regardless of the exact vocabulary used.
