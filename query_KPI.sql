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

-- 2.	Average Order Value per Product Category
SELECT
    p.category_name,
    ROUND(
        SUM(f.totalsales)
        /
        COUNT(DISTINCT f.orderid)
    ,2) AS average_order_value
FROM factorderdetails f
JOIN dimproduct p
    ON f.productid = p.id_dimproduct
GROUP BY p.category_name
ORDER BY average_order_value DESC;

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