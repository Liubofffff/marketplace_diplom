CREATE TABLE IF NOT EXISTS public.sales (
	client_id int4 NOT NULL,
	discount_per_item int4 NULL,
	gender varchar NULL,
	price_per_item int4 NULL,
	product_id int4 NOT NULL,
	purchase_datetime timestamp NOT NULL,
	purchase_time_as_seconds_from_midnight int4 NULL,
	quantity int4 NOT NULL,
	total_price float4 NULL,
	CONSTRAINT sales_unique UNIQUE (client_id, product_id, purchase_datetime, purchase_time_as_seconds_from_midnight)
);