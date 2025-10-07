-- This SQL script aggregates payment data by month and year,
-- calculating total values and quantities for each payment method.
-- It creates a new table called monthly_payment_totals to store the results.

-- DROP VIEW IF EXISTS monthly_payment_totals; -- Drop previous view

CREATE TABLE monthly_payment_totals AS
SELECT
    year,
    -- Aggregate total values
    SUM(valuePix) AS total_pix,
    SUM(valueTED) AS total_ted,
    SUM(valueDOC) AS total_doc,
    SUM(valueBankCheck) AS total_check,
    SUM(valueBrazilianBoletoPayment) AS total_boleto,
    -- Aggregate total quantities
    SUM(quantityPix) AS total_pix_quantity,
    SUM(quantityTED) AS total_ted_quantity,
    SUM(quantityDOC) AS total_doc_quantity,
    SUM(quantityBankCheck) AS total_check_quantity,
    SUM(quantityBrazilianBoletoPayment) AS total_boleto_quantity
FROM brazil_payments_data
GROUP BY year, month
ORDER BY year, month;

SELECT * FROM monthly_payment_totals LIMIT 5;

-- Add market share columns to the monthly_payment_totals table
ALTER TABLE monthly_payment_totals
ADD COLUMN market_share_pix DECIMAL(10,4), -- 10,4 means up to 999999.9999 with 4 decimal places for percentage
ADD COLUMN market_share_ted DECIMAL(10,4),
ADD COLUMN market_share_doc DECIMAL(10,4),
ADD COLUMN market_share_check DECIMAL(10,4),
ADD COLUMN market_share_boleto DECIMAL(10,4);

SELECT * FROM monthly_payment_totals LIMIT 5;

-- Update the market share columns with calculated values
UPDATE monthly_payment_totals
SET
    market_share_pix = total_pix / NULLIF(
        total_pix + total_ted + total_doc + total_check + total_boleto, 0), -- NULLIF to avoid division by zero, returns NULL if denominator is 0
    market_share_ted = total_ted / NULLIF(
        total_pix + total_ted + total_doc + total_check + total_boleto, 0),
    market_share_doc = total_doc / NULLIF(
        total_pix + total_ted + total_doc + total_check + total_boleto, 0),
    market_share_check = total_check / NULLIF(
        total_pix + total_ted + total_doc + total_check + total_boleto, 0),
    market_share_boleto = total_boleto / NULLIF(
        total_pix + total_ted + total_doc + total_check + total_boleto, 0);

-- Final preview of the updated table
SELECT * FROM monthly_payment_totals;
