-- *************************************************************************************
-- *********************************** RESTRICCIONES ***********************************
-- *************************************************************************************

ALTER TABLE pedido_mesa
	ADD CONSTRAINT fk_pedido_mesa_pedido 
		FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
	ADD CONSTRAINT fk_pedido_mesa_mesa
		FOREIGN KEY (id_mesa) REFERENCES mesa(id_mesa);


ALTER TABLE pedido_domicilio 
	ADD CONSTRAINT fk_pedido_domicilio_pedido
		FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
	ADD CONSTRAINT fk_pedido_domicilio_domicilio
		FOREIGN KEY (id_domicilio) REFERENCES domicilio(id_domicilio);


ALTER TABLE detalle_pedido
	ADD CONSTRAINT fk_detalle_pedido_pedido
		FOREIGN KEY(id_pedido) REFERENCES pedido(id_pedido),
	ADD CONSTRAINT fk_detalle_pedido_producto
		FOREIGN KEY (id_producto) REFERENCES producto(id_producto);


ALTER TABLE ticket 
	ADD CONSTRAINT fk_ticket_pedido
		FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);


ALTER TABLE desglose_ticket
	ADD CONSTRAINT fk_desglose_ticket_ticket
		FOREIGN KEY (id_ticket) REFERENCES ticket(id_ticket),
	ADD CONSTRAINT fk_desglose_ticket_pedido
		FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
	ADD CONSTRAINT fk_desglose_ticket_producto
		FOREIGN KEY (id_producto) REFERENCES producto(id_producto);


ALTER TABLE impuesto_ticket
	ADD CONSTRAINT fk_impuesto_ticket_ticket
		FOREIGN KEY(id_ticket) REFERENCES ticket(id_ticket),
	ADD CONSTRAINT fk_impuesto_ticket_impuesto
		FOREIGN KEY (id_impuesto) REFERENCES impuesto(id_impuesto);


-- TRIGGER que completa el INSERT de la tabla desglose_ticket 
-- con el precio actual del producto y el total de la línea.
DELIMITER // 
CREATE TRIGGER desglose_ticket_autocompleta_precio_total
BEFORE INSERT ON desglose_ticket
FOR EACH ROW
BEGIN
	DECLARE precio_producto FLOAT;
    SELECT precio INTO precio_producto FROM producto WHERE id_producto = NEW.id_producto;
    SET NEW.precio_linea = precio_producto;
    SET NEW.precio_total = (NEW.cantidad * NEW.precio_linea);
END//
DELIMITER ;
