USE pizzeria;

SELECT
t.tienda_nombre AS 'Tienda',
p.pedidos_id AS 'NºPedido',
p.pedidos_fechaHora AS 'Hora Solicitud',
'En Tienda' AS 'Entrega',
e.empleados_nombre AS 'Empleado',
cl.cliente_nombre AS 'Nombre',
cl.cliente_apellido1 AS 'Apellido',
cl.cliente_direccion AS 'Dirección',
cl.cliente_telefono AS 'Teléfono',
sum(COALESCE((ppz.pedidos_has_pizzas_cantidad),0)) AS 'Nº Pizzas',
sum(COALESCE((ph.pedidos_has_hamburguesas_cantidad),0)) AS 'Nº Hamburguesas',
sum(COALESCE((pb.pedidos_has_bebidas_cantidad),0)) AS 'Nº Bebidas',
sum(COALESCE((pz.pizzas_precio)*(ppz.pedidos_has_pizzas_cantidad),0))
+sum(COALESCE((h.hamburguesas_precio)*(ph.pedidos_has_hamburguesas_cantidad),0))
+sum(COALESCE((b.bebidas_precio)*(pb.pedidos_has_bebidas_cantidad),0)) AS 'Precio Total'

FROM  pedidos p
LEFT JOIN cliente cl
ON cl.cliente_id=p.cliente_cliente_id
LEFT JOIN pedidos_has_pizzas ppz
ON ppz.pedidos_pedidos_id=p.pedidos_id
LEFT JOIN pedidos_has_hamburguesas ph
ON p.pedidos_id=ph.pedidos_pedidos_id
LEFT JOIN pedidos_has_bebidas pb
ON p.pedidos_id=pb.pedidos_pedidos_id
LEFT JOIN pizzas pz
ON pz.pizzas_id=ppz.pizzas_pizzas_id
LEFT JOIN hamburguesas h
ON h.hamburguesas_id=ph.hamburguesas_hamburguesas_id
LEFT JOIN bebidas b
ON b.bebidas_id=pb.bebidas_bebidas_id
LEFT JOIN tienda t
ON t.tienda_id=p.tienda_tienda_id
LEFT JOIN empleados e
ON e.empleados_id=p.empleados_empleados_id
WHERE p.pedidos_recogida=0
AND e.empleados_funcion=p.pedidos_recogida
GROUP BY p.pedidos_id

UNION SELECT
t.tienda_nombre AS 'Tienda',
p.pedidos_id AS 'NºPedido',
p.pedidos_fechaHora AS 'Hora Solicitud',
'A Domicilio' AS 'Entrega',
e.empleados_nombre AS 'Empleado',
cl.cliente_nombre AS 'Nombre',
cl.cliente_apellido1 AS 'Apellido',
cl.cliente_direccion AS 'Dirección',
cl.cliente_telefono AS 'Teléfono',
sum(COALESCE((ppz.pedidos_has_pizzas_cantidad),0)) AS 'Nº Pizzas',
sum(COALESCE((ph.pedidos_has_hamburguesas_cantidad),0)) AS 'Nº Hamburguesas',
sum(COALESCE((pb.pedidos_has_bebidas_cantidad),0)) AS 'Nº Bebidas',
sum(COALESCE((pz.pizzas_precio)*(ppz.pedidos_has_pizzas_cantidad),0))
+sum(COALESCE((h.hamburguesas_precio)*(ph.pedidos_has_hamburguesas_cantidad),0))
+sum(COALESCE((b.bebidas_precio)*(pb.pedidos_has_bebidas_cantidad),0)) AS 'Precio Total'

FROM  pedidos p
LEFT JOIN cliente cl
ON cl.cliente_id=p.cliente_cliente_id
LEFT JOIN pedidos_has_pizzas ppz
ON p.pedidos_id=ppz.pedidos_pedidos_id
LEFT JOIN pedidos_has_hamburguesas ph
ON p.pedidos_id=ph.pedidos_pedidos_id
LEFT JOIN pedidos_has_bebidas pb
ON p.pedidos_id=pb.pedidos_pedidos_id
LEFT JOIN pizzas pz
ON pz.pizzas_id=ppz.pizzas_pizzas_id
LEFT JOIN hamburguesas h
ON h.hamburguesas_id=ph.hamburguesas_hamburguesas_id
LEFT JOIN bebidas b
ON b.bebidas_id=pb.bebidas_bebidas_id
LEFT JOIN tienda t
ON t.tienda_id=p.tienda_tienda_id
LEFT JOIN empleados e
ON e.empleados_id=p.empleados_empleados_id
WHERE p.pedidos_recogida=1
AND e.empleados_funcion=p.pedidos_recogida
GROUP BY p.pedidos_id
ORDER BY NºPedido