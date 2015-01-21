-- View: v_quotation

-- DROP VIEW v_quotation;

CREATE OR REPLACE VIEW v_quotation AS 
 SELECT 
        CASE
            WHEN quotations.official = true THEN 'checked'::text
            ELSE ''::text
        END AS official2, quotations.*,
        b.full_address, b.phone, b.customer_contact_1 
        ,c.amount as gross_total,
        c.amount+ (coalesce(fee,0)*-1) + (coalesce(discount,0)*-1) as nett_total
   FROM quotations
   join customers b using(customer_id) join
(
select quotation_id, sum(amount) as amount from quotation_products group by quotation_id
) as c using(quotation_id)

   ;
 
