USE pizzeria;

SELECT
e.empleados_id,
concat (e.empleados_nombre, ' ', e.empleados_apellido1) AS 'Nombre Empleado',
count(p.pedidos_id)*2 AS 'Nº Pedidos Cocinados',
count(p.pedidos_id) AS 'Nº Pedidos Entregados en Tienda'

FROM empleados e
LEFT JOIN pedidos p
ON e.empleados_id=p.empleados_empleados_id
WHERE e.empleados_funcion=0
AND concat (e.empleados_nombre, ' ', e.empleados_apellido1)
LIKE ('%Cris re%')
GROUP BY e.empleados_id

UNION SELECT
e.empleados_id,
concat (e.empleados_nombre, ' ', e.empleados_apellido1) AS 'Nombre Empleado',
count(null) AS 'Nº Pedidos Cocinados',
count(p.pedidos_id) AS 'Nº Pedidos Repartidos'

FROM empleados e
LEFT JOIN pedidos p
ON e.empleados_id=p.empleados_empleados_id
WHERE e.empleados_funcion=1
AND concat (e.empleados_nombre, ' ', e.empleados_apellido1)
LIKE ('%Gael fan%')
GROUP BY e.empleados_id