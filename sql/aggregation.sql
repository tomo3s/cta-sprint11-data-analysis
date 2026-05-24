SELECT
  category,
  SUM(total_amount) AS total_sales,
  SUM(quantity) AS total_quantity
FROM sales_analytics_db.sales
GROUP BY category
ORDER BY total_sales DESC;