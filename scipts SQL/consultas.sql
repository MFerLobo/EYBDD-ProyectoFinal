-- *************************************************************************************
-- ************************************* CONSULTAS *************************************
-- *************************************************************************************

-- Consulta de cantidad de producto pedido, ordenado de mayor a menor.
SELECT 
	producto.nombre,
    SUM(detalle_pedido.cantidad) AS 'Cantidad pedida por producto'
FROM detalle_pedido
INNER JOIN producto ON detalle_pedido.id_producto = producto.id_producto
JOIN ticket ON detalle_pedido.id_pedido = ticket.id_ticket
WHERE MONTH(NOW()) = MONTH(ticket.fecha)
GROUP BY producto.id_producto
ORDER BY SUM(detalle_pedido.cantidad) DESC;


-- La facturación que tuvo la empresa en toda la historia con base imponible, IVA y total facturado. 
SELECT 
    SUM(producto.precio * detalle_pedido.cantidad * impuesto.valor) AS "Tributo IVA del mes"
FROM producto JOIN detalle_pedido ON producto.id_producto = detalle_pedido.id_producto
JOIN impuesto.valor ON impuesto.id_impuesto = 1;

-- Total de recaudación de las mesas
SELECT 
	SUM(ticket.precio_final) AS total_recaudado_mesas
FROM ticket
INNER JOIN pedido_mesa 
	ON ticket.id_pedido = pedido_mesa.id_pedido
WHERE MONTH(NOW()) = MONTH(ticket.fecha);
    
    
-- Total de recaudación de pedidos a domicilio
SELECT 
	SUM(ticket.precio_final) AS total_recaudado_domicilio
FROM ticket
INNER JOIN pedido_domicilio 
	ON ticket.id_pedido = pedido_domicilio.id_pedido
WHERE MONTH(NOW()) = MONTH(ticket.fecha);
    
-- Total recaudado por mes. 
SELECT
	MONTH(ticket.fecha) AS mes,
	SUM(ticket.precio_final) AS total_recaudado_mes
FROM ticket
GROUP BY MONTH(ticket.fecha);