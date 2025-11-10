DROP DATABASE IF EXISTS restaurante;
CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;


-- *************************************************************************************
-- ******************************** CREACIÓN DE TABLAS *********************************
-- *************************************************************************************

CREATE TABLE impuesto (
	id_impuesto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    valor FLOAT NOT NULL,
    PRIMARY KEY (id_impuesto)
);


CREATE TABLE mesa ( 
	id_mesa INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id_mesa)
);


CREATE TABLE domicilio (
	id_domicilio INT NOT NULL AUTO_INCREMENT,
    calle VARCHAR(30) NOT NULL,
    altura INT NOT NULL,
    PRIMARY KEY(id_domicilio)
);


CREATE TABLE producto (
	id_producto INT NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(40) NOT NULL,
    precio FLOAT NOT NULL CHECK(precio > 0),
    stock INT NOT NULL CHECK(stock >= 0),
    PRIMARY KEY(id_producto)
);


CREATE TABLE pedido (
	id_pedido INT NOT NULL AUTO_INCREMENT,
    entregado BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(id_pedido)
);


CREATE TABLE pedido_mesa ( 
	id_pedido INT NOT NULL,
    id_mesa INT NOT NULL
);


CREATE TABLE pedido_domicilio ( 
	id_pedido INT NOT NULL,
    id_domicilio INT NOT NULL
);


CREATE TABLE detalle_pedido ( 
	id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK(cantidad > 0)
);


CREATE TABLE ticket ( 
	id_ticket INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    precio_final FLOAT NOT NULL CHECK(precio_final > 0),
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY(id_ticket)
);


CREATE TABLE desglose_ticket (
	id_ticket INT NOT NULL,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK(cantidad > 0),
    precio_linea FLOAT CHECK(precio_linea > 0),
    precio_total FLOAT CHECK(precio_total > 0)
);


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



-- *************************************************************************************
-- ******************************** INSERCIÓN DE DATOS *********************************
-- *************************************************************************************

INSERT INTO impuesto (nombre, valor) VALUES 
('IVA', 0.21)
;

INSERT INTO producto (descripcion, precio, stock) VALUES
('Hamburguesa Clásica', 1500, 20),
('Pizza Mozzarella', 1800, 15),
('Empanada de Carne', 500, 50),
('Milanesa con Papas', 2200, 10),
('Ensalada César', 1600, 12),
('Tarta de Verduras', 1400, 8),
('Pollo al Horno', 2000, 10),
('Ravioles con Salsa', 1900, 14),
('Lomito Completo', 2300, 9),
('Sándwich de Jamón y Queso', 1200, 25),
('Choripán', 1000, 30),
('Canelones de Espinaca', 1850, 11),
('Coca-Cola 500ml', 600, 40),
('Agua Mineral', 400, 50),
('Jugo de Naranja', 700, 35)
;


INSERT INTO domicilio (calle, altura) VALUES
('Av. Corrientes', 1234),
('Florida', 567),
('Av. Santa Fe', 890),
('Lavalle', 321),
('Av. Rivadavia', 4567),
('Suipacha', 678),
('Av. Belgrano', 910);

INSERT INTO mesa () VALUES 
(),
(),
(),
();


INSERT INTO pedido VALUES
(),
(),
(),
(),
(),
();


INSERT INTO pedido_mesa (id_pedido, id_mesa) VALUES  
(1, 1),
(2, 2),
(3, 3);


INSERT INTO pedido_domicilio (id_pedido, id_domicilio) VALUES
(4, 1),
(5, 2),
(6, 3);


-- 1er pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(1, 1, 2),
(1, 14, 2);


-- 2do pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(2, 4, 1),
(2, 7, 3),
(2, 13, 4);


-- 3er pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(3, 2, 1),
(3, 5, 1),
(3, 13, 2);


-- 4to pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(4, 4, 2),
(4, 6, 1),
(4, 14, 1);


-- 5to pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(5, 8, 1),
(5, 9, 1),
(5, 12, 2);


-- 6to pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES 
(6, 3, 1),
(6, 7, 2),
(6, 15, 1);


INSERT INTO ticket (id_pedido, fecha, precio_final) VALUES
(1, '2025-06-05', 3800),
(2, '2025-06-18', 10600),
(3, '2025-07-01', 4600),
(4, '2025-07-10', 6200),
(5, '2025-07-22', 7900),
(6, '2025-06-30', 5200);


INSERT INTO desglose_ticket (id_ticket, id_pedido, id_producto, cantidad) VALUES
(1, 1, 1, 2),
(1, 1, 14, 2),
(2, 2, 4, 1),
(2, 2, 7, 3),
(2, 2, 13, 4),
(3, 3, 2, 1),
(3, 3, 5, 1),
(3, 3, 13, 2),
(4, 4, 4, 2),
(4, 4, 6, 1),
(4, 4, 14, 1),
(5, 5, 8, 1),
(5, 5, 9, 1),
(5, 5, 12, 2),
(6, 6, 3, 1),
(6, 6, 7, 2),
(6, 6, 15, 1);



