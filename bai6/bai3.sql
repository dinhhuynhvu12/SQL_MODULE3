CREATE UNIQUE INDEX idx_productCode ON Products(productCode);

CREATE INDEX idx_name_price ON Products(productName, productPrice);