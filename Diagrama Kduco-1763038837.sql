CREATE TABLE IF NOT EXISTS `caducidad` (
	`caducidad_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`alerta_expiracion` varchar(255) NOT NULL,
	`producto_id` int NOT NULL,
	`account_balance` decimal(10,2) NOT NULL,
	`date_created` date NOT NULL,
	PRIMARY KEY (`caducidad_id`)
);

CREATE TABLE IF NOT EXISTS `escaneo_ticket` (
	`scan_id` int NOT NULL,
	`user_id` int NOT NULL,
	`producto_id` int NOT NULL,
	`fecha_escaneo` date NOT NULL,
	`entry_amount` decimal(10,2) NOT NULL,
	PRIMARY KEY (`scan_id`)
);

CREATE TABLE IF NOT EXISTS `productos` (
	`producto_id` int NOT NULL,
	`caducidad_id` date NOT NULL DEFAULT 'null',
	`nombre_producto` varchar(30) NOT NULL,
	`categoria_id` int NOT NULL,
	`marca_id` int NOT NULL,
	`cantidad` int NOT NULL,
	`notas` int NOT NULL,
	PRIMARY KEY (`producto_id`)
);

CREATE TABLE IF NOT EXISTS `usuarios` (
	`user_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nombre` varchar(50) NOT NULL,
	`correo` varchar(250) NOT NULL UNIQUE,
	`contraseña` varchar(64) NOT NULL,
	`fecha_registro` date NOT NULL,
	`estado` boolean NOT NULL,
	PRIMARY KEY (`user_id`)
);

CREATE TABLE IF NOT EXISTS `inventario` (
	`inventario_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`producto_id` int NOT NULL,
	`user_id` int NOT NULL,
	`fecha_entrada` date NOT NULL,
	`fecha_salida` date NOT NULL,
	`cantidad` int NOT NULL,
	`estado` varchar(20) NOT NULL,
	`categoria_id` int NOT NULL,
	PRIMARY KEY (`inventario_id`)
);

CREATE TABLE IF NOT EXISTS `historial` (
	`historial_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`user_id` int NOT NULL,
	`product_id` int NOT NULL,
	`detalles` varchar(255) NOT NULL,
	PRIMARY KEY (`historial_id`)
);

CREATE TABLE IF NOT EXISTS `categoria_productos` (
	`categoria_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`categoria` varchar(255) NOT NULL,
	`product_id` int NOT NULL,
	PRIMARY KEY (`categoria_id`)
);

CREATE TABLE IF NOT EXISTS `entrada_inventario` (
	`entrada_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`scan_id` int NOT NULL,
	`fecha_entrada` date NOT NULL,
	`cantidad` int NOT NULL,
	`producto_id` int NOT NULL,
	PRIMARY KEY (`entrada_id`)
);

CREATE TABLE IF NOT EXISTS `producto_marca` (
	`marca_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`marca` varchar(50) NOT NULL,
	`product_id` int NOT NULL,
	PRIMARY KEY (`marca_id`)
);

CREATE TABLE IF NOT EXISTS `salida_inventario` (
	`salida_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`fecha_salida` date NOT NULL,
	`cantidad` int NOT NULL,
	`producto_id` varchar(30) NOT NULL,
	`caducidad_id` int NOT NULL,
	PRIMARY KEY (`salida_id`)
);

ALTER TABLE `caducidad` ADD CONSTRAINT `caducidad_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`producto_id`);
ALTER TABLE `escaneo_ticket` ADD CONSTRAINT `escaneo_ticket_fk1` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`user_id`);

ALTER TABLE `escaneo_ticket` ADD CONSTRAINT `escaneo_ticket_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`producto_id`);
ALTER TABLE `productos` ADD CONSTRAINT `productos_fk1` FOREIGN KEY (`caducidad_id`) REFERENCES `caducidad`(`caducidad_id`);

ALTER TABLE `productos` ADD CONSTRAINT `productos_fk3` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_productos`(`categoria_id`);

ALTER TABLE `productos` ADD CONSTRAINT `productos_fk4` FOREIGN KEY (`marca_id`) REFERENCES `producto_marca`(`marca_id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk1` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`producto_id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk2` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`user_id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk3` FOREIGN KEY (`fecha_entrada`) REFERENCES `entrada_inventario`(`fecha_entrada`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk4` FOREIGN KEY (`fecha_salida`) REFERENCES `salida_inventario`(`fecha_salida`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk7` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_productos`(`categoria_id`);
ALTER TABLE `historial` ADD CONSTRAINT `historial_fk1` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`user_id`);

ALTER TABLE `historial` ADD CONSTRAINT `historial_fk2` FOREIGN KEY (`product_id`) REFERENCES `productos`(`producto_id`);

ALTER TABLE `entrada_inventario` ADD CONSTRAINT `entrada_inventario_fk1` FOREIGN KEY (`scan_id`) REFERENCES `escaneo_ticket`(`scan_id`);

ALTER TABLE `entrada_inventario` ADD CONSTRAINT `entrada_inventario_fk4` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`producto_id`);

ALTER TABLE `salida_inventario` ADD CONSTRAINT `salida_inventario_fk3` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`producto_id`);

ALTER TABLE `salida_inventario` ADD CONSTRAINT `salida_inventario_fk4` FOREIGN KEY (`caducidad_id`) REFERENCES `caducidad`(`caducidad_id`);