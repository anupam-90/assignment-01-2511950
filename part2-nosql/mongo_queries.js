// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  /* (Imagine the 3 JSON objects from the previous file are passed here) */
  { "product_id": "PROD-E-001", "name": "Noise Cancelling Headphones", "category": "Electronics", "price": 24999, "specs": { "warranty_months": 24, "voltage": "5V", "battery_life_hours": 30 }, "tags": ["audio", "wireless", "bluetooth"] },
  { "product_id": "PROD-C-001", "name": "Men's Cotton T-Shirt", "category": "Clothing", "price": 899, "variants": [ {"size": "M", "color": "Blue", "stock": 50}, {"size": "L", "color": "Blue", "stock": 20} ], "care_instructions": "Machine wash cold" },
  { "product_id": "PROD-G-001", "name": "Organic Almond Milk 1L", "category": "Groceries", "price": 350, "expiry_date": "2024-11-15", "nutritional_info": { "calories_per_100ml": 40, "sugar_g": 0, "vegan": true } }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "PROD-C-001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
// Explanation for Index: 
// Our application likely queries products by category frequently (e.g., users clicking on the "Electronics" tab). 
// By creating an index on 'category', MongoDB builds a sorted map of categories. 
// Instead of scanning every single document in the database to find matching products (Collection Scan), 
// MongoDB can jump directly to the relevant category in the index, drastically improving query speed.
