USE pizzeria;

SELECT
cl.cliente_nombre AS 'Nombre',
cl.cliente_apellido1 AS 'Primer Apellido',
cl.cliente_apellido2 AS 'Segundo Apellido',
cl.cliente_direccion AS 'Dirección',
l.localidad_nombre AS 'Localidad', 
p.provincia_nombre AS 'Provincia',
cl.cliente_cp AS 'CP',
cl.cliente_telefono AS 'Teléfono'

FROM cliente cl
JOIN cliente_has_localidad  clh 
ON cl.cliente_id=clh.cliente_cliente_id
JOIN localidad l
ON clh.localidad_localidad_id=l.localidad_id
JOIN provincia p
ON l.provincia_provincia_id=p.provincia_id;