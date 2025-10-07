-- SQL script to create the brazilian_payment_methods table
CREATE TABLE brazil_payments_data (
    YearMonth DATE,
    quantityPix DECIMAL(18,2),
    valuePix DECIMAL(18,2),
    quantityTED DECIMAL(18,2),
    valueTED DECIMAL(18,2),
    quantityTEC DECIMAL(18,2),
    valueTEC DECIMAL(18,2),
    quantityBankCheck DECIMAL(18,2),
    valueBankCheck DECIMAL(18,2),
    quantityBrazilianBoletoPayment DECIMAL(18,2),
    valueBrazilianBoletoPayment DECIMAL(18,2),
    quantityDOC DECIMAL(18,2),
    valueDOC DECIMAL(18,2),
    year INT,
    month INT,
    avg_pix DECIMAL(18,8),
    avg_ted DECIMAL(18,8),
    avg_doc DECIMAL(18,8),
    avg_check DECIMAL(18,8),
    avg_boleto DECIMAL(18,8)
);

/* Load data from CSV file into the brazilian_payment_methods table
\copy brazil_payments_data(
    YearMonth, quantityPix, valuePix, quantityTED, valueTED, quantityTEC, valueTEC,
    quantityBankCheck, valueBankCheck, quantityBrazilianBoletoPayment, valueBrazilianBoletoPayment,
    quantityDOC, valueDOC, year, month, avg_pix, avg_ted, avg_doc, avg_check, avg_boleto
)
FROM '/path/pix-and-brazil-payments-trends/data/cleaned/brazilian_payment_methods_clean.csv'
DELIMITER ','
CSV HEADER;*/

-- Check how many rows were inserted
SELECT COUNT(*) FROM brazil_payments_data;

-- Preview the first 5 rows of the table
SELECT * FROM brazil_payments_data LIMIT 5;

