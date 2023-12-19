USE pizzeria;

SELECT

sum(phb.pedidos_has_bebidas_cantidad) AS 'Nº Bebidas Vendidas',
l.localidad_nombre as 'Localidad'

FROM bebidas b
LEFT JOIN pedidos_has_bebidas phb
ON b.bebidas_id=phb.bebidas_bebidas_id
LEFT JOIN pedidos p
ON p.pedidos_id=phb.pedidos_pedidos_id
LEFT JOIN tienda t
ON t.tienda_id=p.tienda_tienda_id
LEFT JOIN tienda_has_localidad thl
ON thl.tienda_tienda_id=t.tienda_id
LEFT JOIN localidad l
ON l.localidad_id=thl.localidad_localidad_id
WHERE l.localidad_nombre
LIKE '%Hospitalet%'
GROUP BY l.localidad_nombre


