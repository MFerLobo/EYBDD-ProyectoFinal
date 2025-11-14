DROP DATABASE IF EXISTS restaurante;
CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;


-- *************************************************************************************
-- ******************************** CREACIÓN DE TABLAS *********************************
-- *************************************************************************************

CREATE TABLE impuesto (
	id_impuesto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    tasa FLOAT NOT NULL,
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

CREATE TABLE impuesto_ticket (
	id_ticket INT NOT NULL,
    id_impuesto INT NOT NULL
);
