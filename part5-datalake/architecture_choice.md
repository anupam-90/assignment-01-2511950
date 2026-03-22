## Architecture Recommendation

For a fast-growing food delivery startup dealing with varied data (GPS logs, text reviews, financial transactions, and images), I recommend a **Data Lakehouse** architecture. 

Here are three specific reasons for this choice:

1. **Unified Storage for Multi-structured Data:** A traditional Data Warehouse requires highly structured tabular data and cannot store unstructured restaurant menu images or raw GPS JSON logs. A Lakehouse sits on top of cheap object storage (like a Data Lake), allowing the startup to dump unstructured images, semi-structured JSON, and structured transaction data into one centralized location without strict upfront schema enforcement.
2. **ACID Transactions on Data Lake:** A pure Data Lake is great for dumping files but terrible for operational updates. Because the startup processes payment transactions, they need ACID guarantees (if a payment is cancelled, the update must securely execute). A Lakehouse uses open table formats (like Apache Iceberg or Delta Lake) that provide Warehouse-level ACID transactions directly on top of the Lake.
3. **Simultaneous BI and ML Workloads:** The startup will need business intelligence (BI) to analyze revenue (traditionally a Warehouse task) and Machine Learning (ML) to analyze unstructured text reviews and GPS data for delivery optimization (traditionally a Lake task). The Lakehouse eliminates data siloes, providing a single architecture where data analysts can run SQL queries while data scientists directly access the same files for AI modeling.
