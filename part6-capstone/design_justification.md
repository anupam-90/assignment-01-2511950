## Storage Systems

To address the four distinct goals of the hospital network, I chose a polyglot persistence architecture, using specific storage systems tailored to each data workload:

1. **Real-time Vitals (ICU Devices):** I chose a **Time-Series Database (e.g., InfluxDB)**. ICU monitors generate massive, high-frequency streams of data indexed purely by time. Time-series databases are optimized for high-throughput sequential writes and downsampling, which RDBMS cannot handle efficiently without locking issues.
2. **Doctor Plain English Querying:** I chose a **Vector Database (e.g., Pinecone/Milvus)** integrated with an LLM. Patient histories, doctor notes, and clinical discharge summaries are unstructured text. By converting these into vector embeddings, doctors can perform semantic search (asking conceptual questions) rather than relying on strict keyword matches.
3. **Monthly Management Reports:** I chose a **Data Warehouse (e.g., Snowflake/BigQuery)**. Generating reports on department-wise costs and bed occupancy requires aggregating large historical datasets. The Warehouse provides a columnar storage structure optimized for fast read-heavy analytical queries (OLAP).
4. **Predict Patient Readmission:** The AI model will draw training data primarily from the **Data Warehouse**, which acts as the unified historical repository of treatments, vitals, and demographics.

## OLTP vs OLAP Boundary

The boundary in this design separates the operational systems from the analytical systems to prevent resource contention. 
The **OLTP (Online Transaction Processing) boundary** includes the core Hospital Management System (running on an RDBMS like PostgreSQL) handling day-to-day patient admissions, and the Time-Series database ingesting live ICU vitals. These systems are optimized for rapid, continuous single-row inserts and updates. 

The **OLAP (Online Analytical Processing) boundary** begins at the ETL (Extract, Transform, Load) pipelines. Every night, data is securely replicated and transformed from the operational RDBMS and Time-Series DB into the Data Warehouse. Management dashboards and ML training algorithms sit strictly on the OLAP side. This ensures that running a massive, complex analytical query calculating yearly hospital costs does not slow down the operational database used by nurses admitting emergency patients.

## Trade-offs

One significant trade-off in this design is **Architectural Complexity vs. Optimization**. By choosing a polyglot approach (RDBMS, Time-Series, Vector DB, and Data Warehouse), the system is perfectly optimized for its individual tasks. However, this introduces high maintenance complexity, requiring engineers to manage multiple database types, complex ETL data pipelines, and distributed data synchronization.

**Mitigation:** To mitigate this, I would implement robust managed cloud services (Platform-as-a-Service) instead of self-hosting the databases, offloading infrastructure maintenance. Furthermore, I would establish strict data governance policies and automated data quality checks within the ETL pipelines to ensure that data does not drift or become inconsistent as it moves from the source OLTP systems to the analytical OLAP and Vector systems.
