-- Create a new table to store yearly payment totals
CREATE TABLE yearly_payment_totals AS
SELECT
    year,
    -- Aggregate total values
    SUM(valuePix) AS yearly_total_pix,
    SUM(valueTED) AS yearly_total_ted,
    SUM(valueDOC) AS yearly_total_doc,
    SUM(valueBankCheck) AS yearly_total_check,
    SUM(valueBrazilianBoletoPayment) AS yearly_total_boleto,

    -- Aggregate total quantities
    SUM(quantityPix) AS yearly_total_pix_quantity,
    SUM(quantityTED) AS yearly_total_ted_quantity,
    SUM(quantityDOC) AS yearly_total_doc_quantity,
    SUM(quantityBankCheck) AS yearly_total_check_quantity,
    SUM(quantityBrazilianBoletoPayment) AS yearly_total_boleto_quantity
FROM brazil_payments_data
GROUP BY year
ORDER BY year;

SELECT * FROM yearly_payment_totals LIMIT 5;

-- Add market share columns to the yearly_payment_totals table
ALTER TABLE yearly_payment_totals
ADD COLUMN market_share_pix DECIMAL(10,4), -- 10,4 means up to 999999.9999 with 4 decimal places for percentage
ADD COLUMN market_share_ted DECIMAL(10,4),
ADD COLUMN market_share_doc DECIMAL(10,4),
ADD COLUMN market_share_check DECIMAL(10,4),
ADD COLUMN market_share_boleto DECIMAL(10,4);

SELECT * FROM yearly_payment_totals LIMIT 5;

-- Update the market share columns with calculated values
UPDATE yearly_payment_totals
SET
    market_share_pix = yearly_total_pix / NULLIF(
        yearly_total_pix + yearly_total_ted + yearly_total_doc + yearly_total_check + yearly_total_boleto, 0), -- NULLIF to avoid division by zero, returns NULL if denominator is 0
    market_share_ted = yearly_total_ted / NULLIF(
        yearly_total_pix + yearly_total_ted + yearly_total_doc + yearly_total_check + yearly_total_boleto, 0),
    market_share_doc = yearly_total_doc / NULLIF(
        yearly_total_pix + yearly_total_ted + yearly_total_doc + yearly_total_check + yearly_total_boleto, 0),
    market_share_check = yearly_total_check / NULLIF(
        yearly_total_pix + yearly_total_ted + yearly_total_doc + yearly_total_check + yearly_total_boleto, 0),
    market_share_boleto = yearly_total_boleto / NULLIF(
        yearly_total_pix + yearly_total_ted + yearly_total_doc + yearly_total_check + yearly_total_boleto, 0);

-- Final preview of the updated table
SEL