-- *************************************************************************************
-- ************************************* CONSULTAS *************************************
-- *************************************************************************************

-- Muestra los productos que fueron ordenados durante el mes (actual o reemplazar MONTH(NOW()) por número de mes a consultar), ordenados de mayor a menor.
SELECT 
	producto.descripcion,
    SUM(detalle_pedido.cantidad) AS 'Productos pedidos en el mes'
FROM detalle_pedido
INNER JOIN producto ON detalle_pedido.id_producto = producto.id_producto
JOIN ticket ON detalle_pedido.id_pedido = ticket.id_ticket
WHERE 
    YEAR(ticket.fecha) = YEAR(NOW())
    AND 
	MONTH(ticket.fecha) = MONTH(NOW())
GROUP BY producto.id_producto
ORDER BY SUM(detalle_pedido.cantidad) DESC;


-- Dinero a tributar por IVA durante el mes (actual o reemplazar MONTH(NOW()) por número de mes a consultar)
SELECT 
    ROUND(SUM(ticket.precio_final * impuesto.tasa), 2) AS 'Tributo IVA del mes'
FROM ticket JOIN impuesto_ticket ON ticket.id_ticket = impuesto_ticket.id_ticket
JOIN impuesto ON impuesto_ticket.id_impuesto = impuesto.id_impuesto
WHERE 
    YEAR(ticket.fecha) = YEAR(NOW())
    AND 
	MONTH(ticket.fecha) = MONTH(NOW());

-- Total de recaudación de las mesas por mes (actual o reemplazar MONTH(NOW()) por número de mes a consultar)
SELECT 
	SUM(ticket.precio_final) AS 'Recaudación de pedidos de mesas en el mes'
FROM ticket
INNER JOIN pedido_mesa ON ticket.id_pedido = pedido_mesa.id_pedido
WHERE 
    YEAR(ticket.fecha) = YEAR(NOW())
    AND 
	MONTH(ticket.fecha) = MONTH(NOW());
    
    
-- Total de recaudación de pedidos a domicilio por mes (actual o reemplazar MONTH(NOW()) por número de mes a consultar)
SELECT 
	SUM(ticket.precio_final) AS 'Recaudación de pedidos a domicilio en el mes'
FROM ticket
INNER JOIN pedido_domicilio ON ticket.id_pedido = pedido_domicilio.id_pedido
WHERE 
    YEAR(ticket.fecha) = YEAR(NOW())
    AND 
	MONTH(ticket.fecha) = MONTH(NOW());
    
-- Total recaudado en el año (actual o reemplazar YEAR(NOW()) por número de año a consultar), agrupado por recaudación mensual.
SELECT
	MONTH(ticket.fecha) AS mes,
	SUM(ticket.precio_final) AS 'Recaudación anual'
FROM ticket
WHERE YEAR(ticket.fecha) = YEAR(NOW())
GROUP BY MONTH(ticket.fecha);
