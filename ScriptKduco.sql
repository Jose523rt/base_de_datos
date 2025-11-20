CREATE TABLE IF NOT EXISTS `caducidad` (
	`id` int AUTO_INCREMENT NOT NULL,
	`alerta_expiracion` varchar(255) NOT NULL,
	`producto_id` int NOT NULL,
	`tiempo_de_vida` int NOT NULL,
	`fecha_creacion` date NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `escaneo_ticket` (
	`id` int AUTO_INCREMENT NOT NULL,
	`user_id` int NOT NULL,
	`producto_id` int NOT NULL,
	`fecha_escaneo` date NOT NULL,
	`cantidad_entrada` decimal(10,2) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `productos` (
	`id` int AUTO_INCREMENT NOT NULL,
	`caducidad_id` int NOT NULL,
	`nombre_producto` varchar(30) NOT NULL,
	`categoria_id` int NOT NULL,
	`marca_id` int NOT NULL,
	`cantidad` int NOT NULL,
	`notas` varchar(100) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `usuarios` (
	`id` int AUTO_INCREMENT NOT NULL,
	`nombre` varchar(50) NOT NULL,
	`correo` varchar(250) NOT NULL UNIQUE,
	`contraseña` varchar(64) NOT NULL,
	`fecha_registro` date NOT NULL,
	`estado` boolean NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `inventario` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`producto_id` int NOT NULL,
	`user_id` int NOT NULL,
	`cantidad` decimal(10,2) NOT NULL,
	`estado` boolean NOT NULL,
	`categoria_id` int NOT NULL,
	`fecha_entrada` date NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `historial` (
	`id` int AUTO_INCREMENT NOT NULL,
	`user_id` int NOT NULL,
	`product_id` int NOT NULL,
	`detalles` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `categoria_productos` (
	`id` int AUTO_INCREMENT NOT NULL,
	`categoria` varchar(30) NOT NULL,
	`producto_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `entrada_inventario` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`scan_id` int NOT NULL,
	`fecha_entrada` date NOT NULL,
	`cantidad` int NOT NULL,
	`producto_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `producto_marca` (
	`id` int AUTO_INCREMENT NOT NULL,
	`marca` varchar(50) NOT NULL,
	`producto_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `salida_inventario` (
	`salida_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`cantidad` datetime NOT NULL,
	`producto_id` int NOT NULL,
	`caducidad_id` int NOT NULL,
	PRIMARY KEY (`salida_id`)
);

ALTER TABLE `caducidad` ADD CONSTRAINT `caducidad_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);
ALTER TABLE `escaneo_ticket` ADD CONSTRAINT `escaneo_ticket_fk1` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`id`);

ALTER TABLE `escaneo_ticket` ADD CONSTRAINT `escaneo_ticket_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);
ALTER TABLE `productos` ADD CONSTRAINT `productos_fk1` FOREIGN KEY (`caducidad_id`) REFERENCES `caducidad`(`id`);

ALTER TABLE `productos` ADD CONSTRAINT `productos_fk3` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_productos`(`id`);

ALTER TABLE `productos` ADD CONSTRAINT `productos_fk4` FOREIGN KEY (`marca_id`) REFERENCES `producto_marca`(`id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk1` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk2` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`id`);

ALTER TABLE `inventario` ADD CONSTRAINT `inventario_fk5` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_productos`(`id`);
ALTER TABLE `historial` ADD CONSTRAINT `historial_fk1` FOREIGN KEY (`user_id`) REFERENCES `usuarios`(`id`);

ALTER TABLE `historial` ADD CONSTRAINT `historial_fk2` FOREIGN KEY (`product_id`) REFERENCES `productos`(`id`);
ALTER TABLE `categoria_productos` ADD CONSTRAINT `categoria_productos_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);
ALTER TABLE `entrada_inventario` ADD CONSTRAINT `entrada_inventario_fk1` FOREIGN KEY (`scan_id`) REFERENCES `escaneo_ticket`(`id`);

ALTER TABLE `entrada_inventario` ADD CONSTRAINT `entrada_inventario_fk4` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);
ALTER TABLE `producto_marca` ADD CONSTRAINT `producto_marca_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);
ALTER TABLE `salida_inventario` ADD CONSTRAINT `salida_inventario_fk2` FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`);

ALTER TABLE `salida_inventario` ADD CONSTRAINT `salida_inventario_fk3` FOREIGN KEY (`caducidad_id`) REFERENCES `caducidad`(`id`);
