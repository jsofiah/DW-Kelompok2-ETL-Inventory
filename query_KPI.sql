-- 1.	Total Penjualan per Bulan
SELECT
    d.year,
    d.month,
    SUM(f.totalsales) AS total_sales
FROM factorderdetails f
JOIN dimdate d
    ON f.orderdatekey = d.datekey
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 2.	Average Order Value
SELECT
    ROUND(
        SUM(totalsales)
        /
        COUNT(DISTINCT orderid)
    ,2) AS average_order_value
FROM factorderdetails;

-- 3.	Yearly Sales Growth Rate
WITH yearly_sales AS (
    SELECT
        d.year,
        SUM(f.totalsales) AS total_sales
    FROM factorderdetails f
    JOIN dimdate d
        ON f.orderdatekey = d.datekey
    GROUP BY d.year
)
SELECT
    year,
    total_sales,
    ROUND(
        (
            (total_sales -
            LAG(total_sales) OVER (ORDER BY year))
            /
            LAG(total_sales) OVER (ORDER BY year)
        ) * 100
    ,2) AS growth_percent
FROM yearly_sales
ORDER BY year;

-- 4.	Profit per Product Category
SELECT
    dp.category_name,
    SUM(f.profit) AS total_profit
FROM factorderdetails f
JOIN dimproduct dp
    ON f.productid = dp.id_dimproduct
GROUP BY dp.category_name
ORDER BY total_profit DESC;