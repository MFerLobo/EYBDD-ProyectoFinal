-- *************************************************************************************
-- ******************************** INSERCIÓN DE DATOS *********************************
-- *************************************************************************************

INSERT INTO producto (nombre, precio, stock) VALUES
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
