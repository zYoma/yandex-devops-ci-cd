CREATE UNIQUE INDEX CONCURRENTLY idx_order_product_product_id_order_id ON order_product(product_id, order_id);