
-- creacion de la base de datos cine

create database CineMarvel2024;
use CineMarvel2024;

--USE master; -- si quieres cambiar alguna cosa, elimina y crea de nuevo la BD
--DROP DATABASE CineMarvel2024;--asi evitamos usar alter table, es moroso ejecutar de nuevo pero es mas legible

create table Sucursal
(-- 1
	Id integer not null primary key,
	Nombre varchar(60) not null,
	Direccion varchar(150) not null,
	Ciudad varchar(15) not null,
	Telefono integer not null,
	Email varchar(60) not null
);

create table Sala
(-- 2
	Id integer not null primary key,
	Capacidad integer not null,
	NroSala integer not null,
	IdSucursal integer not null,
	foreign key (IdSucursal) references Sucursal(Id)
		on update cascade
		on delete cascade
);

create table Formato
(--3 
	Id integer not null primary key,
	Descripcion varchar(60) not null,
	precio integer not null
);

create table Genero
(--4
	Id integer not null primary key,
	Nombre varchar(40) not null
);

create table Lenguaje
(--5
	Id integer not null primary key,
	Idioma varchar(40) not null,
	Subtitulo varchar(15)
);

create table Pelicula
(--6
	Id integer not null primary key,
	Nombre varchar(150) not null,
	Clasificacion varchar(10) not null,
	Duracion time not null,
	Idgenero integer ,
	foreign key (Idgenero) references Genero(Id)
		on update cascade
		on delete cascade
);

create table Pelicula_Lenguaje
(--7
	IdPelicula integer not null, 
	IdLenguaje integer not null,
	foreign key (IdPelicula) references  Pelicula(Id)
		on update cascade
		on delete cascade,
	foreign key (IdLenguaje) references  Lenguaje(Id)
		on update cascade
		on delete cascade, 
	primary key (IdPelicula,IdLenguaje)
);

create table Proyeccion
(--8
	Id integer not null primary key,
	Dia varchar(20) not null,
	HoraIni time not null, 
	HoraFin time not null,
	IdSala integer not null,
	IdFormato integer not null,
	IdPeli integer not null,
	IdLeng integer not null,
	foreign key (IdSala) references  Sala(Id)
		on update cascade
		on delete cascade,
	foreign key (IdFormato) references  Formato(Id)
		on update cascade
		on delete cascade,
	foreign key (IdPeli, IdLeng) references  Pelicula_Lenguaje(IdPelicula,IdLenguaje)
		on update cascade
		on delete cascade
);

create table Fila
(--9
	Id char(1) not null primary key
);

create table Columna
(--10
	Id integer not null primary key
);

create table Promocion
(--11
	Id integer not null primary key,
	FechaIni date not null,
	FechaFin date not null, 
	Descuento integer not null,
	Descripcion varchar(150) not null
);

create table Butaca
(--12
	Id integer not null ,
	Estado char(1)not null,
	IdFila char(1) not null,
	IdColumna integer not null,
	IdSala integer not null,
	foreign key (IdFila) references  Fila(Id)
		on update cascade
		on delete cascade,
	foreign key (IdColumna) references  Columna(Id)
		on update cascade
		on delete cascade,
	foreign key (IdSala) references  Sala(Id)
		on update cascade
		on delete cascade,
	primary key (Id, IdSala)
);

create table Persona
(--13
	Id integer not null primary key,
	Nombre varchar(60) not null,
	Apellido varchar(60) not null,
	Correo varchar(60) not null,
	Contraseña varchar(15) not null
);

create table Cliente_Virtual
(--14
	IdPersona integer not null,
	FechaRegistro date not null,
	telefono integer
	foreign key (IdPersona) references Persona(Id)
		on update cascade 
		ON DELETE NO ACTION,
	primary key (IdPersona)
);

create table Cajero_Prod
(--15
	IdPersona integer not null,
	HoraEntrada time not null,
	HoraSalida time not null,
	foreign key (IdPersona) references Persona(Id)
		on update cascade 
		on delete cascade,
	primary key (IdPersona)
);

create table Puesto
(--16
	Id integer not null primary key,
	Nombre varchar(40) not null,
	IdCajero integer not null,
	foreign key (IdCajero) references Cajero_Prod(IdPersona)
		on update cascade 
		on delete cascade
);

create table Cliente_Presencial
(--17
	Id integer not null primary key,
	Ci integer
);

create table Proveedor
(--18
	Id integer not null primary key,
	Nombre varchar(60) not null,
	Fecha_Actualizacion date not null
);

create table Categoria
(--19
	Id integer not null primary key,
	Descripcion varchar(90) not null
);

create table Producto
(--20
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Fecha_Vencimiento date not null,
	Precio_unitario integer not null,
	IdCajero integer not null,
	IdCategoria integer not null,
	foreign key (IdCajero) references Cajero_Prod(IdPersona)
		on update cascade 
		on delete cascade,
	foreign key (IdCategoria) references Categoria(Id)
		on update cascade 
		on delete cascade
);

create table Proveedor_Producto
(--21
	IdProveedor integer not null,
	IdProducto integer not null,
	foreign key (IdProveedor) references Proveedor(Id)
		on update cascade 
		on delete cascade,
	foreign key (IdProducto) references Producto(Id)
		on update cascade 
		on delete cascade,
	Primary key (IdProveedor, IdProducto)
);

create table Combo
(--22
	Id integer not null primary key,
	Nombre varchar(60) not null,
	Descripcion varchar(200) not null,
	PrecioTotal integer not null
);

create table Combo_Categoria
(--23
	IdCombo integer not null,
	IdCategoria integer not null,
	cantidad integer not null,
	foreign key (IdCombo) references Combo(Id)
		on update cascade 
		on delete cascade,
	foreign key (IdCategoria) references Categoria(Id)
		on update cascade 
		on delete cascade,
	Primary key (IdCombo, IdCategoria)
);

create table Tipo_pago
(--24
	Id integer not null primary key,
	Descripcion varchar(60) not null
);

CREATE TABLE Factura
(--25
    Id integer NOT NULL PRIMARY KEY,
    CodigoQR varchar(20) NOT NULL,
    Fecha date NOT NULL,
    Monto_total integer NOT NULL,
    IdTipoPago INT NOT NULL,
    IdCli_Virtual integer,
    IdCli_Presencial integer,
    IdCajero integer,
    FOREIGN KEY (IdCli_Virtual) REFERENCES Cliente_Virtual(IdPersona)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (IdCli_Presencial) REFERENCES Cliente_Presencial(Id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (IdCajero) REFERENCES Cajero_Prod(IdPersona)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (IdTipoPago) REFERENCES Tipo_pago(Id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

create table Detalle_Producto
(--26
	IdFactura integer not null,
	IdProducto integer not null,
	cantidad integer not null
	foreign key (IdFactura) references Factura(Id)
		on update cascade 
		on delete cascade,
	foreign key (IdProducto) references Producto(Id)
		on update cascade 
		on delete cascade,
	Primary key (IdProducto, IdFactura)
);

create table Combo_Factura
(--27
	IdCombo integer not null,
	IdFactura integer not null,
	cantidad integer not null
	foreign key (IdFactura) references Factura(Id)
		on update cascade 
		on delete cascade,
	foreign key (IdCombo) references Combo(Id)
		on update cascade 
		on delete cascade,
	Primary key (IdCombo, IdFactura)
);

create table Boleto
(--28
	Id integer not null primary key,
	Precio integer not null,
	IdFactura integer not null,
	IdPromocion integer not null,
	IdButaca integer not null,
	IdSala INTEGER NOT NULL,
	foreign key (IdFactura) references Factura(Id)
		on update cascade 
		on delete cascade,
	foreign key (IdPromocion) references Promocion(Id)
		on update cascade 
		on delete cascade,
	FOREIGN KEY (IdButaca, IdSala) REFERENCES Butaca(Id, IdSala)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

SELECT * FROM Sucursal;-- 1. 
INSERT INTO Sucursal (Id, Nombre, Direccion, Ciudad, Telefono, Email)
VALUES
(1, 'Cine Marvel SC', 'Av. Cristo Redentor 3200', 'Santa Cruz', 33650000, 'sc@cinemarvel.com'),
(2, 'Cine Marvel LP', 'Av. 6 de Agosto 1234', 'La Paz', 22040000, 'lp@cinemarvel.com'),
(3, 'Cine Marvel CBBA', 'Av. América 987', 'Cochabamba', 44550000, 'cbba@cinemarvel.com'),
(4, 'Cine Marvel TRJ', 'Av. Circunvalación 456', 'Tarija', 46630000, 'trj@cinemarvel.com'),
(5, 'Cine Marvel PT', 'Calle Sucre 321', 'Potosi', 26780000, 'pt@cinemarvel.com'),
(6, 'Cine Marvel OR', 'Av. España 789', 'Oruro', 52890000, 'or@cinemarvel.com'),
(7, 'Cine Marvel BEN', 'Av. Beni 120', 'Beni', 35670000, 'ben@cinemarvel.com'),
(8, 'Cine Marvel PND', 'Calle Comercio 456', 'Pando', 32980000, 'pnd@cinemarvel.com'),
(9, 'Cine Marvel CHQ', 'Calle Junín 789', 'Chuquisaca', 46490000, 'chq@cinemarvel.com'),
(10, 'Cine Marvel CBBA 2', 'Calle Blanco Galindo 1234', 'Cochabamba', 44551000, 'cbba2@cinemarvel.com'),
(11, 'Cine Marvel SC 2', 'Calle Doble Vía La Guardia', 'Santa Cruz', 33651000, 'sc2@cinemarvel.com'),
(12, 'Cine Marvel LP 2', 'Av. Ballivián 234', 'La Paz', 22041000, 'lp2@cinemarvel.com'),
(13, 'Cine Marvel TRJ 2', 'Calle Bolívar 567', 'Tarija', 46631000, 'trj2@cinemarvel.com'),
(14, 'Cine Marvel PT 2', 'Av. Murillo 890', 'Potosi', 26781000, 'pt2@cinemarvel.com'),
(15, 'Cine Marvel CHQ 2', 'Av. Del Estadio 123', 'Chuquisaca', 46491000, 'chq2@cinemarvel.com');

SELECT * FROM Sala;-- 2. 

-- Insertar salas para la sucursal 1 (Cine Marvel SC) - 15 salas
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(1, 20, 1, 1),
(2, 30, 2, 1),
(3, 20, 3, 1),
(4, 30, 4, 1),
(5, 20, 5, 1),
(6, 30, 6, 1),
(7, 20, 7, 1),
(8, 30, 8, 1),
(9, 20, 9, 1),
(10, 30, 10, 1),
(11, 20, 11, 1),
(12, 30, 12, 1),
(13, 20, 13, 1),
(14, 30, 14, 1),
(15, 20, 15, 1);

-- Insertar salas para la sucursal 2 (Cine Marvel LP) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(16, 20, 1, 2),
(17, 30, 2, 2),
(18, 20, 3, 2),
(19, 30, 4, 2),
(20, 20, 5, 2),
(21, 30, 6, 2),
(22, 20, 7, 2),
(23, 30, 8, 2),
(24, 20, 9, 2),
(25, 30, 10, 2),
(26, 20, 11, 2),
(27, 30, 12, 2),
(28, 20, 13, 2),
(29, 30, 14, 2),
(30, 20, 15, 2);

-- Insertar salas para la sucursal 3 (Cine Marvel CBBA) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(31, 20, 1, 3),
(32, 30, 2, 3),
(33, 20, 3, 3),
(34, 30, 4, 3),
(35, 20, 5, 3),
(36, 30, 6, 3),
(37, 20, 7, 3),
(38, 30, 8, 3),
(39, 20, 9, 3),
(40, 30, 10, 3),
(41, 20, 11, 3),
(42, 30, 12, 3),
(43, 20, 13, 3),
(44, 30, 14, 3),
(45, 20, 15, 3);

-- Insertar salas para la sucursal 4 (Cine Marvel TRJ) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(46, 20, 1, 4),
(47, 30, 2, 4),
(48, 20, 3, 4),
(49, 30, 4, 4),
(50, 20, 5, 4),
(51, 30, 6, 4),
(52, 20, 7, 4),
(53, 30, 8, 4),
(54, 20, 9, 4),
(55, 30, 10, 4),
(56, 20, 11, 4),
(57, 30, 12, 4),
(58, 20, 13, 4),
(59, 30, 14, 4),
(60, 20, 15, 4);

-- Insertar salas para la sucursal 5 (Cine Marvel PT) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(61, 20, 1, 5),
(62, 30, 2, 5),
(63, 20, 3, 5),
(64, 30, 4, 5),
(65, 20, 5, 5),
(66, 30, 6, 5),
(67, 20, 7, 5),
(68, 30, 8, 5),
(69, 20, 9, 5),
(70, 30, 10, 5),
(71, 20, 11, 5),
(72, 30, 12, 5),
(73, 20, 13, 5),
(74, 30, 14, 5),
(75, 20, 15, 5);

-- Insertar salas para la sucursal 6 (Cine Marvel OR) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(76, 20, 1, 6),
(77, 30, 2, 6),
(78, 20, 3, 6),
(79, 30, 4, 6),
(80, 20, 5, 6),
(81, 30, 6, 6),
(82, 20, 7, 6),
(83, 30, 8, 6),
(84, 20, 9, 6),
(85, 30, 10, 6),
(86, 20, 11, 6),
(87, 30, 12, 6),
(88, 20, 13, 6),
(89, 30, 14, 6),
(90, 20, 15, 6);

-- Insertar salas para la sucursal 7 (Cine Marvel BEN) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(91, 20, 1, 7),
(92, 30, 2, 7),
(93, 20, 3, 7),
(94, 30, 4, 7),
(95, 20, 5, 7),
(96, 30, 6, 7),
(97, 20, 7, 7),
(98, 30, 8, 7),
(99, 20, 9, 7),
(100, 30, 10, 7),
(101, 20, 11, 7),
(102, 30, 12, 7),
(103, 20, 13, 7),
(104, 30, 14, 7),
(105, 20, 15, 7);

-- Insertar salas para la sucursal 8 (Cine Marvel PND) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(106, 20, 1, 8),
(107, 30, 2, 8),
(108, 20, 3, 8),
(109, 30, 4, 8),
(110, 20, 5, 8),
(111, 30, 6, 8),
(112, 20, 7, 8),
(113, 30, 8, 8),
(114, 20, 9, 8),
(115, 30, 10, 8),
(116, 20, 11, 8),
(117, 30, 12, 8),
(118, 20, 13, 8),
(119, 30, 14, 8),
(120, 20, 15, 8);

-- Insertar salas para la sucursal 9 (Cine Marvel CHQ) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(121, 20, 1, 9),
(122, 30, 2, 9),
(123, 20, 3, 9),
(124, 30, 4, 9),
(125, 20, 5, 9),
(126, 30, 6, 9),
(127, 20, 7, 9),
(128, 30, 8, 9),
(129, 20, 9, 9),
(130, 30, 10, 9),
(131, 20, 11, 9),
(132, 30, 12, 9),
(133, 20, 13, 9),
(134, 30, 14, 9),
(135, 20, 15, 9);

-- Insertar salas para la sucursal 10 (Cine Marvel CBBA 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(136, 20, 1, 10),
(137, 30, 2, 10),
(138, 20, 3, 10),
(139, 30, 4, 10),
(140, 20, 5, 10),
(141, 30, 6, 10),
(142, 20, 7, 10),
(143, 30, 8, 10),
(144, 20, 9, 10),
(145, 30, 10, 10),
(146, 20, 11, 10),
(147, 30, 12, 10),
(148, 20, 13, 10),
(149, 30, 14, 10),
(150, 20, 15, 10);

-- Insertar salas para la sucursal 11 (Cine Marvel SC 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(151, 20, 1, 11),
(152, 30, 2, 11),
(153, 20, 3, 11),
(154, 30, 4, 11),
(155, 20, 5, 11),
(156, 30, 6, 11),
(157, 20, 7, 11),
(158, 30, 8, 11),
(159, 20, 9, 11),
(160, 30, 10, 11),
(161, 20, 11, 11),
(162, 30, 12, 11),
(163, 20, 13, 11),
(164, 30, 14, 11),
(165, 20, 15, 11);

-- Insertar salas para la sucursal 12 (Cine Marvel LP 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(166, 20, 1, 12),
(167, 30, 2, 12),
(168, 20, 3, 12),
(169, 30, 4, 12),
(170, 20, 5, 12),
(171, 30, 6, 12),
(172, 20, 7, 12),
(173, 30, 8, 12),
(174, 20, 9, 12),
(175, 30, 10, 12),
(176, 20, 11, 12),
(177, 30, 12, 12),
(178, 20, 13, 12),
(179, 30, 14, 12),
(180, 20, 15, 12);

-- Insertar salas para la sucursal 13 (Cine Marvel TRJ 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(181, 20, 1, 13),
(182, 30, 2, 13),
(183, 20, 3, 13),
(184, 30, 4, 13),
(185, 20, 5, 13),
(186, 30, 6, 13),
(187, 20, 7, 13),
(188, 30, 8, 13),
(189, 20, 9, 13),
(190, 30, 10, 13),
(191, 20, 11, 13),
(192, 30, 12, 13),
(193, 20, 13, 13),
(194, 30, 14, 13),
(195, 20, 15, 13);

-- Insertar salas para la sucursal 14 (Cine Marvel PT 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(196, 20, 1, 14),
(197, 30, 2, 14),
(198, 20, 3, 14),
(199, 30, 4, 14),
(200, 20, 5, 14),
(201, 30, 6, 14),
(202, 20, 7, 14),
(203, 30, 8, 14),
(204, 20, 9, 14),
(205, 30, 10, 14),
(206, 20, 11, 14),
(207, 30, 12, 14),
(208, 20, 13, 14),
(209, 30, 14, 14),
(210, 20, 15, 14);

-- Insertar salas para la sucursal 15 (Cine Marvel CHQ 2) -15 salas en esta sucursal
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(211, 20, 1, 15),
(212, 30, 2, 15),
(213, 20, 3, 15),
(214, 30, 4, 15),
(215, 20, 5, 15),
(216, 30, 6, 15),
(217, 20, 7, 15),
(218, 30, 8, 15),
(219, 20, 9, 15),
(220, 30, 10, 15),
(221, 20, 11, 15),
(222, 30, 12, 15),
(223, 20, 13, 15),
(224, 30, 14, 15),
(225, 20, 15, 15);



SELECT * FROM Formato;-- 3. 
INSERT INTO Formato (Id, Descripcion, Precio)
VALUES
(1, '2D', 30.00),
(2, '4D E-Motion 2D', 70.00),
(3, '2D Atmos', 40.00),
(4, '2D CXC Atmos', 50.00),
(5, '3D', 60.00),
(6, '4D E-Motion 3D', 80.00);

SELECT * FROM Genero;-- 4. 
--géneros de películas
INSERT INTO Genero (Id, Nombre)
VALUES
(1, 'Acción'),
(2, 'Aventura'),
(3, 'Comedia'),
(4, 'Drama'),
(5, 'Ciencia Ficción'),
(6, 'Fantasía'),
(7, 'Terror'),
(8, 'Romance'),
(9, 'Misterio'),
(10, 'Thriller'),
(11, 'Musical'),
(12, 'Documental'),
(13, 'Animación'),
(14, 'Biografía');

SELECT * FROM Lenguaje;-- 5. 
INSERT INTO Lenguaje (Id, Idioma, Subtitulo)
VALUES
(1, 'Español', 'Ninguno'),
(2, 'Inglés', 'Español'),
(3, 'Portugués', 'Español');

SELECT * FROM Pelicula;-- 6. 
-- Insertar películas
INSERT INTO Pelicula (Id, Nombre, Clasificacion, Duracion, Idgenero)
VALUES
(1, 'Deadpool & Wolverine', 'R', '01:48:00', 1),
(2, 'Coraline y la puerta secreta', 'PG', '01:40:00', 6),
(3, 'Star Wars III - La venganza de los Sith', 'PG-13', '02:20:00', 5),
(4, 'Solo Leveling - Arise from the Shadow', 'PG-13', '01:30:00', 2),
(5, 'El Señor de los Anillos: el retorno del Rey', 'PG-13', '02:21:00', 6),
(6, 'Spider-Man: A través del Spider-Verso', 'PG', '01:56:00', 13),
(7, 'Son como niños 2', 'PG-13', '01:41:00', 3),
(8, 'Interestelar', 'PG-13', '02:49:00', 5),
(9, 'Un lugar en silencio', 'PG-13', '01:30:00', 7),
(10, 'Hasta el último hombre', 'R', '02:19:00', 4),
(11, 'Siempre a tu lado', 'PG', '01:37:00', 4);


SELECT * FROM Pelicula_Lenguaje;-- 7.
-- Insertar asociaciones entre películas y lenguajes
INSERT INTO Pelicula_Lenguaje (IdPelicula, IdLenguaje)
VALUES
(1, 1), -- Deadpool & Wolverine en Español
(1, 2), -- Deadpool & Wolverine en Inglés
(2, 1), -- Coraline y la puerta secreta en Español
(3, 1), -- Star Wars: Episodio III - La venganza de los Sith en Español
(3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés
(4, 1), -- Solo Leveling - Arise from the Shadow en Español
(5, 1), -- El Señor de los Anillos: el retorno del Rey en Español
(5, 2), -- El Señor de los Anillos: el retorno del Rey en Inglés
(6, 1), -- Spider-Man: A través del Spider-Verso en Español
(6, 2), -- Spider-Man: A través del Spider-Verso en Inglés
(6, 3), -- Spider-Man: A través del Spider-Verso en Portugues
(7, 1), -- Son como niños 2 en Español
(8, 1), -- Interestelar en Español
(8, 2), -- Interestelar en Inglés
(9, 1), -- Un lugar en silencio en Español
(10, 1), -- Hasta el último hombre en Español
(10, 2), -- Hasta el último hombre en Inglés
(11, 1); -- Siempre a tu lado en Español

SELECT * FROM Proyeccion;-- 8. 
SELECT * FROM Sala;
SELECT * FROM Formato;
--la sala 15 sera para Formato 4D E-Motion 2D
--la sala 14 sera para Formato 4D E-Motion 3D
--la sala 13 sera para Formato 3D
--la sala 12 sera para Formato 2D CXC Atmos
--la sala 11 sera para Formato 2D Atmos
--y las demas salas del 1 al 10 son Formato 2D 
--Proyeccion solo para las salas de la sucursal 1 (Cine Marvel SC)
-- Proyecciones de "Deadpool & Wolverine" TODO en español en salas id15, id13, id11, y id10 -- Proyecciones para Lunes
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(1, 'Lunes', '10:00:00', '12:00:00', 15, 2, 1, 1),
(2, 'Lunes', '12:30:00', '14:30:00', 15, 2, 1, 1),
(3, 'Lunes', '15:00:00', '17:00:00', 15, 2, 1, 1),
(4, 'Lunes', '17:30:00', '19:30:00', 15, 2, 1, 1),

-- Sala id13: Formato 3D
(5, 'Lunes', '10:00:00', '12:00:00', 13, 5, 1, 1),
(6, 'Lunes', '12:30:00', '14:30:00', 13, 5, 1, 1),
(7, 'Lunes', '15:00:00', '17:00:00', 13, 5, 1, 1),
(8, 'Lunes', '17:30:00', '19:30:00', 13, 5, 1, 1),

-- Sala id11: Formato 2D Atmos
(9, 'Lunes', '10:00:00', '12:00:00', 11, 3, 1, 1),
(10, 'Lunes', '12:30:00', '14:30:00', 11, 3, 1, 1),
(11, 'Lunes', '15:00:00', '17:00:00', 11, 3, 1, 1),
(12, 'Lunes', '17:30:00', '19:30:00', 11, 3, 1, 1),

-- Sala id10: Formato 2D
(13, 'Lunes', '10:00:00', '12:00:00', 10, 1, 1, 1),
(14, 'Lunes', '12:30:00', '14:30:00', 10, 1, 1, 1),
(15, 'Lunes', '15:00:00', '17:00:00', 10, 1, 1, 1),
(16, 'Lunes', '17:30:00', '19:30:00', 10, 1, 1, 1),

-- Sala id12: Formato 2D CXC Atmos
(17, 'Lunes', '10:00:00', '11:40:00', 12, 4, 2, 1),
(18, 'Lunes', '12:00:00', '13:40:00', 12, 4, 2, 1),
(19, 'Lunes', '14:00:00', '15:40:00', 12, 4, 2, 1),
(20, 'Lunes', '16:00:00', '17:40:00', 12, 4, 2, 1),

-- Sala id7: Formato 2D
(21, 'Lunes', '10:00:00', '12:20:00', 7, 1, 3, 1),
(22, 'Lunes', '12:30:00', '14:50:00', 7, 1, 3, 1),
(23, 'Lunes', '15:00:00', '17:20:00', 7, 1, 3, 1),
(24, 'Lunes', '17:30:00', '19:50:00', 7, 1, 3, 1),

-- Sala id1: Formato 2D
(25, 'Lunes', '10:00:00', '11:30:00', 1, 1, 4, 1),
(26, 'Lunes', '12:00:00', '13:30:00', 1, 1, 4, 1),
(27, 'Lunes', '14:00:00', '15:30:00', 1, 1, 4, 1),
(28, 'Lunes', '16:00:00', '17:30:00', 1, 1, 4, 1),

-- Sala id2: Formato 2D
(29, 'Lunes', '10:00:00', '11:56:00', 2, 1, 5, 1),
(30, 'Lunes', '12:00:00', '13:56:00', 2, 1, 5, 1),
(31, 'Lunes', '14:00:00', '15:56:00', 2, 1, 5, 1),
(32, 'Lunes', '16:00:00', '17:56:00', 2, 1, 5, 1),

-- Sala id3: Formato 2D
(33, 'Lunes', '10:00:00', '11:41:00', 3, 1, 6, 1),
(34, 'Lunes', '12:00:00', '13:56:00', 3, 1, 6, 1),
(35, 'Lunes', '14:00:00', '15:56:00', 3, 1, 6, 1),
(36, 'Lunes', '16:00:00', '17:56:00', 3, 1, 6, 1),

-- Sala id4: Formato 2D
(37, 'Lunes', '10:00:00', '11:41:00', 4, 1, 7, 1),
(38, 'Lunes', '12:00:00', '13:41:00', 4, 1, 7, 1),
(39, 'Lunes', '14:00:00', '15:41:00', 4, 1, 7, 1),
(40, 'Lunes', '16:00:00', '17:41:00', 4, 1, 7, 1),

-- Sala id14: Formato 4D E-Motion 3D
(41, 'Lunes', '10:00:00', '11:30:00', 14, 6, 8, 1),
(42, 'Lunes', '12:00:00', '13:30:00', 14, 6, 8, 1),
(43, 'Lunes', '14:00:00', '15:30:00', 14, 6, 8, 1),
(44, 'Lunes', '16:00:00', '17:30:00', 14, 6, 8, 1),

-- Sala id6: Formato 2D
(45, 'Lunes', '10:00:00', '11:30:00', 6, 1, 9, 1),
(46, 'Lunes', '12:00:00', '13:30:00', 6, 1, 9, 1),
(47, 'Lunes', '14:00:00', '15:30:00', 6, 1, 9, 1),
(48, 'Lunes', '16:00:00', '17:30:00', 6, 1, 9, 1),

-- Sala id7: Formato 2D
(49, 'Lunes', '10:00:00', '11:37:00', 7, 1, 10, 1),
(50, 'Lunes', '12:00:00', '13:37:00', 7, 1, 10, 1),
(51, 'Lunes', '14:00:00', '15:37:00', 7, 1, 10, 1),
(52, 'Lunes', '16:00:00', '17:37:00', 7, 1, 10, 1),

-- Sala id8: Formato 2D
(53, 'Lunes', '10:00:00', '11:37:00', 8, 1, 11, 1),
(54, 'Lunes', '12:00:00', '13:37:00', 8, 1, 11, 1),
(55, 'Lunes', '14:00:00', '15:37:00', 8, 1, 11, 1),
(56, 'Lunes', '16:00:00', '17:37:00', 8, 1, 11, 1),
(57, 'Martes', '10:00:00', '12:00:00', 3, 3, 9, 1), -- Un lugar en silencio en Español, Formato 2D Atmos, Sala 3
(58, 'Martes', '12:00:00', '14:00:00', 4, 4, 10, 1), -- Hasta el último hombre en Español, Formato 2D CXC Atmos, Sala 4
(59, 'Martes', '14:00:00', '16:00:00', 5, 6, 1, 1), -- Deadpool & Wolverine en Español, Formato 4D E-Motion 3D, Sala 5
(60, 'Martes', '16:00:00', '18:00:00', 6, 5, 2, 1), -- Coraline y la puerta secreta en Español, Formato 3D, Sala 6
(61, 'Martes', '18:00:00', '20:00:00', 1, 1, 3, 1), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D, Sala 1
(62, 'Martes', '20:00:00', '22:00:00', 2, 2, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 4D E-Motion 2D, Sala 2
(63, 'Martes', '22:00:00', '00:00:00', 3, 3, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D Atmos, Sala 3
(64, 'Martes', '00:00:00', '02:00:00', 4, 4, 6, 1), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 2D CXC Atmos, Sala 4
(65, 'Miércoles', '10:00:00', '12:00:00', 5, 6, 7, 1), -- Son como niños 2 en Español, Formato 4D E-Motion 3D, Sala 5
(66, 'Miércoles', '12:00:00', '14:00:00', 6, 5, 8, 1), -- Interestelar en Inglés, Formato 3D, Sala 6
(67, 'Miércoles', '14:00:00', '16:00:00', 1, 1, 9, 1), -- Un lugar en silencio en Español, Formato 2D, Sala 1
(68, 'Miércoles', '16:00:00', '18:00:00', 2, 2, 10, 1), -- Hasta el último hombre en Inglés, Formato 4D E-Motion 2D, Sala 2
(69, 'Miércoles', '18:00:00', '20:00:00', 3, 3, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D Atmos, Sala 3
(70, 'Miércoles', '20:00:00', '22:00:00', 4, 4, 2, 1), -- Coraline y la puerta secreta en Español, Formato 2D CXC Atmos, Sala 4
(71, 'Miércoles', '22:00:00', '00:00:00', 5, 6, 3, 1), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 4D E-Motion 3D, Sala 5
(72, 'Miércoles', '00:00:00', '02:00:00', 6, 5, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 3D, Sala 6
(73, 'Jueves', '10:00:00', '12:00:00', 1, 1, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D, Sala 1
(74, 'Jueves', '12:00:00', '14:00:00', 2, 6, 6, 1), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 4D E-Motion 2D, Sala 2
(75, 'Jueves', '14:00:00', '16:00:00', 3, 3, 7, 1), -- Son como niños 2 en Español, Formato 2D Atmos, Sala 3
(76, 'Jueves', '16:00:00', '18:00:00', 4, 4, 8, 1), -- Interestelar en Español, Formato 2D CXC Atmos, Sala 4
(77, 'Jueves', '18:00:00', '20:00:00', 5, 6, 9, 1), -- Un lugar en silencio en Español, Formato 4D E-Motion 3D, Sala 5
(78, 'Jueves', '20:00:00', '22:00:00', 6, 5, 10, 1), -- Hasta el último hombre en Inglés, Formato 3D, Sala 6
(79, 'Jueves', '22:00:00', '00:00:00', 1, 1, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D, Sala 1
(80, 'Jueves', '00:00:00', '02:00:00', 2, 2, 2, 1), -- Coraline y la puerta secreta en Español, Formato 4D E-Motion 2D, Sala 2
(81, 'Viernes', '10:00:00', '12:00:00', 3, 3, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D Atmos, Sala 3
(82, 'Viernes', '12:00:00', '14:00:00', 4, 4, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 2D CXC Atmos, Sala 4
(83, 'Viernes', '14:00:00', '16:00:00', 5, 6, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 4D E-Motion 3D, Sala 5
(84, 'Viernes', '16:00:00', '18:00:00', 6, 5, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 3D, Sala 6
(85, 'Viernes', '18:00:00', '20:00:00', 1, 1, 7, 1), -- Son como niños 2 en Español, Formato 2D, Sala 1
(86, 'Viernes', '20:00:00', '22:00:00', 2, 2, 8, 1), -- Interestelar en Español, Formato 4D E-Motion 2D, Sala 2
(87, 'Viernes', '22:00:00', '00:00:00', 3, 3, 9, 1), -- Un lugar en silencio en Español, Formato 2D Atmos, Sala 3
(88, 'Viernes', '00:00:00', '02:00:00', 4, 4, 10, 2), -- Hasta el último hombre en Inglés, Formato 2D CXC Atmos, Sala 4
(89, 'Sábado', '10:00:00', '12:00:00', 5, 5, 1, 1), -- Deadpool & Wolverine en Español, Formato 4D E-Motion 3D, Sala 5
(90, 'Sábado', '12:00:00', '14:00:00', 6, 6, 2, 1), -- Coraline y la puerta secreta en Español, Formato 3D, Sala 6
(91, 'Sábado', '14:00:00', '16:00:00', 1, 1, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D, Sala 1
(92, 'Sábado', '16:00:00', '18:00:00', 2, 2, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 4D E-Motion 2D, Sala 2
(93, 'Sábado', '18:00:00', '20:00:00', 3, 3, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D Atmos, Sala 3
(94, 'Sábado', '20:00:00', '22:00:00', 4, 4, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 2D CXC Atmos, Sala 4
(95, 'Sábado', '22:00:00', '00:00:00', 5, 5, 7, 1), -- Son como niños 2 en Español, Formato 4D E-Motion 3D, Sala 5
(96, 'Sábado', '00:00:00', '02:00:00', 6, 6, 8, 1), -- Interestelar en Español, Formato 3D, Sala 6
(97, 'Domingo', '10:00:00', '12:00:00', 1, 1, 9, 1), -- Un lugar en silencio en Español, Formato 2D, Sala 1
(98, 'Domingo', '12:00:00', '14:00:00', 2, 2, 10, 2), -- Hasta el último hombre en Inglés, Formato 4D E-Motion 2D, Sala 2
(99, 'Domingo', '14:00:00', '16:00:00', 3, 3, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D Atmos, Sala 3
(100, 'Domingo', '16:00:00', '18:00:00', 4, 4, 2, 1), -- Coraline y la puerta secreta en Español, Formato 2D CXC Atmos, Sala 4
(101, 'Domingo', '18:00:00', '20:00:00', 5, 5, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 4D E-Motion 3D, Sala 5
(102, 'Domingo', '20:00:00', '22:00:00', 6, 6, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 3D, Sala 6
(103, 'Domingo', '22:00:00', '00:00:00', 1, 1, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D, Sala 1
(104, 'Domingo', '00:00:00', '02:00:00', 2, 2, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 4D E-Motion 2D, Sala 2

(105, 'Lunes', '10:00:00', '11:40:00', 30, 6, 2, 1), -- Cine Marvel LP (Sucursal 2) en lunes--------------------------------------------------
(106, 'Lunes', '12:00:00', '13:40:00', 30, 6, 2, 1),
(107, 'Lunes', '14:00:00', '15:40:00', 30, 6, 2, 1),
(108, 'Lunes', '16:00:00', '17:40:00', 30, 6, 2, 1),
(109, 'Lunes', '10:00:00', '12:20:00', 29, 5, 3, 1),
(110, 'Lunes', '12:30:00', '14:50:00', 29, 5, 3, 1),
(111, 'Lunes', '15:00:00', '17:20:00', 29, 5, 3, 1),
(112, 'Lunes', '17:30:00', '19:50:00', 29, 5, 3, 1),
(113, 'Lunes', '10:00:00', '11:30:00', 27, 4, 4, 1),
(114, 'Lunes', '12:00:00', '13:30:00', 27, 4, 4, 1),
(115, 'Lunes', '14:00:00', '15:30:00', 27, 4, 4, 1),
(116, 'Lunes', '16:00:00', '17:30:00', 27, 4, 4, 1),
(117, 'Lunes', '10:00:00', '12:21:00', 26, 3, 5, 1),
(118, 'Lunes', '12:30:00', '14:51:00', 26, 3, 5, 1),
(119, 'Lunes', '15:00:00', '17:21:00', 26, 3, 5, 1),
(120, 'Lunes', '17:30:00', '19:51:00', 26, 3, 5, 1),
(121, 'Lunes', '10:00:00', '11:56:00', 16, 1, 6, 1),
(122, 'Lunes', '12:00:00', '13:56:00', 16, 1, 6, 1),
(123, 'Lunes', '14:00:00', '15:56:00', 16, 1, 6, 1),
(124, 'Lunes', '16:00:00', '17:56:00', 16, 1, 6, 1),
(125, 'Lunes', '10:00:00', '11:41:00', 17, 1, 7, 1),
(126, 'Lunes', '12:00:00', '13:41:00', 17, 1, 7, 1),
(127, 'Lunes', '14:00:00', '15:41:00', 17, 1, 7, 1),
(128, 'Lunes', '16:00:00', '17:41:00', 17, 1, 7, 1),
(129, 'Lunes', '10:00:00', '12:49:00', 18, 1, 8, 1),
(130, 'Lunes', '12:30:00', '14:49:00', 18, 1, 8, 1),
(131, 'Lunes', '15:00:00', '17:49:00', 18,1, 8, 1),
(132, 'Lunes', '17:30:00', '19:49:00', 18, 1, 8, 1),
(133, 'Lunes', '10:00:00', '11:30:00', 19, 1, 9, 1),
(134, 'Lunes', '12:00:00', '13:30:00', 19, 1, 9, 1),
(135, 'Lunes', '14:00:00', '15:30:00', 19, 1, 9, 1),
(136, 'Lunes', '16:00:00', '17:30:00', 19, 1, 9, 1),
(137, 'Lunes', '10:00:00', '12:19:00', 20, 1, 10, 1),
(138, 'Lunes', '12:30:00', '14:19:00', 20, 1, 10, 1),
(139, 'Lunes', '15:00:00', '17:19:00', 20, 1, 10, 1),
(140, 'Lunes', '17:30:00', '19:19:00', 20, 1, 10, 1),
(141, 'Lunes', '10:00:00', '11:37:00', 21, 1, 11, 1),
(142, 'Lunes', '12:00:00', '13:37:00', 21, 1, 11, 1),
(143, 'Lunes', '14:00:00', '15:37:00', 21, 1, 11, 1),
(144, 'Lunes', '16:00:00', '17:37:00', 21, 1, 11, 1),
(145, 'Martes', '10:00:00', '12:00:00', 18, 3, 9, 1),
(146, 'Martes', '12:00:00', '14:00:00', 19, 4, 10, 1),
(147, 'Martes', '14:00:00', '16:00:00', 20, 5, 1, 1),
(148, 'Martes', '16:00:00', '18:00:00', 21, 6, 2, 1),
(149, 'Martes', '18:00:00', '20:00:00', 16, 1, 3, 2),
(150, 'Martes', '20:00:00', '22:00:00', 17, 2, 4, 1),
(151, 'Martes', '22:00:00', '00:00:00', 18, 3, 5, 1),
(152, 'Martes', '00:00:00', '02:00:00', 19, 4, 6, 2),
(153, 'Miércoles', '10:00:00', '12:00:00', 20, 5, 7, 1),
(154, 'Miércoles', '12:00:00', '14:00:00', 21, 6, 8, 2),
(155, 'Miércoles', '14:00:00', '16:00:00', 16, 1, 9, 1),
(156, 'Miércoles', '16:00:00', '18:00:00', 17, 2, 10, 2),
(157, 'Miércoles', '18:00:00', '20:00:00', 18, 3, 1, 1),
(158, 'Miércoles', '20:00:00', '22:00:00', 19, 4, 2, 1),
(159, 'Miércoles', '22:00:00', '00:00:00', 20, 5, 3, 2),
(160, 'Miércoles', '00:00:00', '02:00:00', 21, 6, 4, 1),
(161, 'Jueves', '10:00:00', '12:00:00', 16, 1, 5, 1),
(162, 'Jueves', '12:00:00', '14:00:00', 17, 2, 6, 2),
(163, 'Jueves', '14:00:00', '16:00:00', 18, 3, 7, 1),
(164, 'Jueves', '16:00:00', '18:00:00', 19, 4, 8, 1),
(165, 'Jueves', '18:00:00', '20:00:00', 20, 5, 9, 1),
(166, 'Jueves', '20:00:00', '22:00:00', 21, 6, 10, 2),
(167, 'Jueves', '22:00:00', '00:00:00', 16, 1, 1, 1),
(168, 'Jueves', '00:00:00', '02:00:00', 17, 2, 2, 1),
(169, 'Viernes', '10:00:00', '12:00:00', 18, 3, 3, 2),
(170, 'Viernes', '12:00:00', '14:00:00', 19, 4, 4, 1),
(171, 'Viernes', '14:00:00', '16:00:00', 20, 5, 5, 1),
(172, 'Viernes', '16:00:00', '18:00:00', 21, 6, 6, 2),
(173, 'Viernes', '18:00:00', '20:00:00', 16, 1, 7, 1),
(174, 'Viernes', '20:00:00', '22:00:00', 17, 2, 8, 1),
(175, 'Viernes', '22:00:00', '00:00:00', 18, 3, 9, 1),
(176, 'Viernes', '00:00:00', '02:00:00', 19, 4, 10, 2),
(177, 'Sábado', '10:00:00', '12:00:00', 20, 5, 1, 1),
(178, 'Sábado', '12:00:00', '14:00:00', 21, 6, 2, 1),
(179, 'Sábado', '14:00:00', '16:00:00', 16, 1, 3, 2),
(180, 'Sábado', '16:00:00', '18:00:00', 17, 2, 4, 1),
(181, 'Sábado', '18:00:00', '20:00:00', 18, 3, 5, 1),
(182, 'Sábado', '20:00:00', '22:00:00', 19, 4, 6, 2),
(183, 'Sábado', '22:00:00', '00:00:00', 20, 5, 7, 1),
(184, 'Sábado', '00:00:00', '02:00:00', 21, 6, 8, 1), 
(185, 'Domingo', '10:00:00', '12:00:00', 16, 1, 9, 1), 
(186, 'Domingo', '12:00:00', '14:00:00', 17, 2, 10, 2), 
(187, 'Domingo', '14:00:00', '16:00:00', 18, 3, 1, 1), 
(188, 'Domingo', '16:00:00', '18:00:00', 19, 4, 2, 1), 
(189, 'Domingo', '18:00:00', '20:00:00', 20, 5, 3, 2), 
(190, 'Domingo', '20:00:00', '22:00:00', 21, 6, 4, 1), 
(191, 'Domingo', '22:00:00', '00:00:00', 16, 1, 5, 1), 
(192, 'Domingo', '00:00:00', '02:00:00', 17, 2, 6, 2); 


SELECT * FROM Fila;-- 9. 
-- Insertar datos en la tabla Fila
INSERT INTO Fila (Id) VALUES 
('A'), 
('B'), 
('C'), 
('D'), 
('E');

SELECT * FROM Columna;-- 10. 
-- Insertar datos en la tabla Columna
INSERT INTO Columna (Id) VALUES 
(1), 
(2), 
(3), 
(4), 
(5), 
(6);----hasta aqui es la maxima de columnas para la capacidad de la sala 5f x 6c= 30 asientos 


SELECT * FROM Promocion;-- 11. 
INSERT INTO Promocion (Id, FechaIni, FechaFin, Descuento, Descripcion) VALUES 
(1, '2024-09-01', '2024-09-30', 15, 'Descuento del 15% para compras online'),
(2, '2024-09-04', '2024-12-04', 50, 'Entradas a mitad de precio para los cumpleañeros'),
(3, '2024-09-01', '2024-10-31', 50, 'Compra dos entradas al precio de uno solo miercoles'),
(4, '2024-09-10', '2024-12-31', 20, 'Descuento del 20% en entradas para estrenos de películas');

SELECT * FROM Sucursal;
SELECT * FROM Butaca;-- 12. 
--solo estan las salas para la sucursal 1 (Cine Marvel SC)
-- Insertar datos en la tabla Butaca para la Sucursal 1
INSERT INTO Butaca (Id, Estado, IdFila, IdColumna, IdSala) VALUES
(1, 'D', 'A', 1, 1),-- Sala 1 (20 asientos: A-D por 1-5)
(2, 'D', 'A', 2, 1),
(3, 'D', 'A', 3, 1),
(4, 'D', 'A', 4, 1),
(5, 'D', 'A', 5, 1),
(6, 'D', 'B', 1, 1),
(7, 'D', 'B', 2, 1),
(8, 'D', 'B', 3, 1),
(9, 'D', 'B', 4, 1),
(10, 'D', 'B', 5, 1),
(11, 'D', 'C', 1, 1),
(12, 'D', 'C', 2, 1),
(13, 'D', 'C', 3, 1),
(14, 'D', 'C', 4, 1),
(15, 'D', 'C', 5, 1),
(16, 'D', 'D', 1, 1),
(17, 'D', 'D', 2, 1),
(18, 'D', 'D', 3, 1),
(19, 'D', 'D', 4, 1),
(20, 'D', 'D', 5, 1),
(21, 'D', 'A', 1, 2),-- Sala 2 (30 asientos: A-E por 1-6)
(22, 'D', 'A', 2, 2),
(23, 'D', 'A', 3, 2),
(24, 'D', 'A', 4, 2),
(25, 'D', 'A', 5, 2),
(26, 'D', 'A', 6, 2),
(27, 'D', 'B', 1, 2),
(28, 'D', 'B', 2, 2),
(29, 'D', 'B', 3, 2),
(30, 'D', 'B', 4, 2),
(31, 'D', 'B', 5, 2),
(32, 'D', 'B', 6, 2),
(33, 'D', 'C', 1, 2),
(34, 'D', 'C', 2, 2),
(35, 'D', 'C', 3, 2),
(36, 'D', 'C', 4, 2),
(37, 'D', 'C', 5, 2),
(38, 'D', 'C', 6, 2),
(39, 'D', 'D', 1, 2),
(40, 'D', 'D', 2, 2),
(41, 'D', 'D', 3, 2),
(42, 'D', 'D', 4, 2),
(43, 'D', 'D', 5, 2),
(44, 'D', 'D', 6, 2),
(45, 'D', 'E', 1, 2),
(46, 'D', 'E', 2, 2),
(47, 'D', 'E', 3, 2),
(48, 'D', 'E', 4, 2),
(49, 'D', 'E', 5, 2),
(50, 'D', 'E', 6, 2),
(51, 'D', 'A', 1, 3),-- Sala 3 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 1
(52, 'D', 'A', 2, 3),
(53, 'D', 'A', 3, 3),
(54, 'D', 'A', 4, 3),
(55, 'D', 'A', 5, 3),
(56, 'D', 'B', 1, 3),
(57, 'D', 'B', 2, 3),
(58, 'D', 'B', 3, 3),
(59, 'D', 'B', 4, 3),
(60, 'D', 'B', 5, 3),
(61, 'D', 'C', 1, 3),
(62, 'D', 'C', 2, 3),
(63, 'D', 'C', 3, 3),
(64, 'D', 'C', 4, 3),
(65, 'D', 'C', 5, 3),
(66, 'D', 'D', 1, 3),
(67, 'D', 'D', 2, 3),
(68, 'D', 'D', 3, 3),
(69, 'D', 'D', 4, 3),
(70, 'D', 'D', 5, 3),
(71, 'D', 'A', 1, 4),-- Sala 4 (30 asientos: A-E por 1-6) - Repetir el patrón de la Sala 2
(72, 'D', 'A', 2, 4),
(73, 'D', 'A', 3, 4),
(74, 'D', 'A', 4, 4),
(75, 'D', 'A', 5, 4),
(76, 'D', 'A', 6, 4),
(77, 'D', 'B', 1, 4),
(78, 'D', 'B', 2, 4),
(79, 'D', 'B', 3, 4),
(80, 'D', 'B', 4, 4),
(81, 'D', 'B', 5, 4),
(82, 'D', 'B', 6, 4),
(83, 'D', 'C', 1, 4),
(84, 'D', 'C', 2, 4),
(85, 'D', 'C', 3, 4),
(86, 'D', 'C', 4, 4),
(87, 'D', 'C', 5, 4),
(88, 'D', 'C', 6, 4),
(89, 'D', 'D', 1, 4),
(90, 'D', 'D', 2, 4),
(91, 'D', 'D', 3, 4),
(92, 'D', 'D', 4, 4),
(93, 'D', 'D', 5, 4),
(94, 'D', 'D', 6, 4),
(95, 'D', 'E', 1, 4),
(96, 'D', 'E', 2, 4),
(97, 'D', 'E', 3, 4),
(98, 'D', 'E', 4, 4),
(99, 'D', 'E', 5, 4),
(100, 'D', 'E', 6, 4),
(101, 'D', 'A', 1, 5),-- Sala 5 (20 asientos: A-D por 1-5)
(102, 'D', 'A', 2, 5),
(103, 'D', 'A', 3, 5),
(104, 'D', 'A', 4, 5),
(105, 'D', 'A', 5, 5),
(106, 'D', 'B', 1, 5),
(107, 'D', 'B', 2, 5),
(108, 'D', 'B', 3, 5),
(109, 'D', 'B', 4, 5),
(110, 'D', 'B', 5, 5),
(111, 'D', 'C', 1, 5),
(112, 'D', 'C', 2, 5),
(113, 'D', 'C', 3, 5),
(114, 'D', 'C', 4, 5),
(115, 'D', 'C', 5, 5),
(116, 'D', 'D', 1, 5),
(117, 'D', 'D', 2, 5),
(118, 'D', 'D', 3, 5),
(119, 'D', 'D', 4, 5),
(120, 'D', 'D', 5, 5),
(121, 'D', 'A', 1, 6),-- Sala 6 (30 asientos: A-E por 1-6)
(122, 'D', 'A', 2, 6),
(123, 'D', 'A', 3, 6),
(124, 'D', 'A', 4, 6),
(125, 'D', 'A', 5, 6),
(126, 'D', 'A', 6, 6),
(127, 'D', 'B', 1, 6),
(128, 'D', 'B', 2, 6),
(129, 'D', 'B', 3, 6),
(130, 'D', 'B', 4, 6),
(131, 'D', 'B', 5, 6),
(132, 'D', 'B', 6, 6),
(133, 'D', 'C', 1, 6),
(134, 'D', 'C', 2, 6),
(135, 'D', 'C', 3, 6),
(136, 'D', 'C', 4, 6),
(137, 'D', 'C', 5, 6),
(138, 'D', 'C', 6, 6),
(139, 'D', 'D', 1, 6),
(140, 'D', 'D', 2, 6),
(141, 'D', 'D', 3, 6),
(142, 'D', 'D', 4, 6),
(143, 'D', 'D', 5, 6),
(144, 'D', 'D', 6, 6),
(145, 'D', 'E', 1, 6),
(146, 'D', 'E', 2, 6),
(147, 'D', 'E', 3, 6),
(148, 'D', 'E', 4, 6),
(149, 'D', 'E', 5, 6),
(150, 'D', 'E', 6, 6),
(151, 'D', 'A', 1, 7),-- Sala 7 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 5
(152, 'D', 'A', 2, 7),
(153, 'D', 'A', 3, 7),
(154, 'D', 'A', 4, 7),
(155, 'D', 'A', 5, 7),
(156, 'D', 'B', 1, 7),
(157, 'D', 'B', 2, 7),
(158, 'D', 'B', 3, 7),
(159, 'D', 'B', 4, 7),
(160, 'D', 'B', 5, 7),
(161, 'D', 'C', 1, 7),
(162, 'D', 'C', 2, 7),
(163, 'D', 'C', 3, 7),
(164, 'D', 'C', 4, 7),
(165, 'D', 'C', 5, 7),
(166, 'D', 'D', 1, 7),
(167, 'D', 'D', 2, 7),
(168, 'D', 'D', 3, 7),
(169, 'D', 'D', 4, 7),
(170, 'D', 'D', 5, 7),
(171, 'D', 'A', 1, 8),-- Sala 8 (30 asientos: A-E por 1-6) - Repetir el patrón de la Sala 6
(172, 'D', 'A', 2, 8),
(173, 'D', 'A', 3, 8),
(174, 'D', 'A', 4, 8),
(175, 'D', 'A', 5, 8),
(176, 'D', 'A', 6, 8),
(177, 'D', 'B', 1, 8),
(178, 'D', 'B', 2, 8),
(179, 'D', 'B', 3, 8),
(180, 'D', 'B', 4, 8),
(181, 'D', 'B', 5, 8),
(182, 'D', 'B', 6, 8),
(183, 'D', 'C', 1, 8),
(184, 'D', 'C', 2, 8),
(185, 'D', 'C', 3, 8),
(186, 'D', 'C', 4, 8),
(187, 'D', 'C', 5, 8),
(188, 'D', 'C', 6, 8),
(189, 'D', 'D', 1, 8),
(190, 'D', 'D', 2, 8),
(191, 'D', 'D', 3, 8),
(192, 'D', 'D', 4, 8),
(193, 'D', 'D', 5, 8),
(194, 'D', 'D', 6, 8),
(195, 'D', 'E', 1, 8),
(196, 'D', 'E', 2, 8),
(197, 'D', 'E', 3, 8),
(198, 'D', 'E', 4, 8),
(199, 'D', 'E', 5, 8),
(200, 'D', 'E', 6, 8),
(201, 'D', 'A', 1, 9),-- Sala 9 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 5
(202, 'D', 'A', 2, 9),
(203, 'D', 'A', 3, 9),
(204, 'D', 'A', 4, 9),
(205, 'D', 'A', 5, 9),
(206, 'D', 'B', 1, 9),
(207, 'D', 'B', 2, 9),
(208, 'D', 'B', 3, 9),
(209, 'D', 'B', 4, 9),
(210, 'D', 'B', 5, 9),
(211, 'D', 'C', 1, 9),
(212, 'D', 'C', 2, 9),
(213, 'D', 'C', 3, 9),
(214, 'D', 'C', 4, 9),
(215, 'D', 'C', 5, 9),
(216, 'D', 'D', 1, 9),
(217, 'D', 'D', 2, 9),
(218, 'D', 'D', 3, 9),
(219, 'D', 'D', 4, 9),
(220, 'D', 'D', 5, 9),
(221, 'D', 'A', 1, 10),-- Sala 10 (30 asientos: A-E por 1-6) - Repetir el patrón de la Sala 6
(222, 'D', 'A', 2, 10),
(223, 'D', 'A', 3, 10),
(224, 'D', 'A', 4, 10),
(225, 'D', 'A', 5, 10),
(226, 'D', 'A', 6, 10),
(227, 'D', 'B', 1, 10),
(228, 'D', 'B', 2, 10),
(229, 'D', 'B', 3, 10),
(230, 'D', 'B', 4, 10),
(231, 'D', 'B', 5, 10),
(232, 'D', 'B', 6, 10),
(233, 'D', 'C', 1, 10),
(234, 'D', 'C', 2, 10),
(235, 'D', 'C', 3, 10),
(236, 'D', 'C', 4, 10),
(237, 'D', 'C', 5, 10),
(238, 'D', 'C', 6, 10),
(239, 'D', 'D', 1, 10),
(240, 'D', 'D', 2, 10),
(241, 'D', 'D', 3, 10),
(242, 'D', 'D', 4, 10),
(243, 'D', 'D', 5, 10),
(244, 'D', 'D', 6, 10),
(245, 'D', 'E', 1, 10),
(246, 'D', 'E', 2, 10),
(247, 'D', 'E', 3, 10),
(248, 'D', 'E', 4, 10),
(249, 'D', 'E', 5, 10),
(250, 'D', 'E', 6, 10),
(251, 'D', 'A', 1, 11),-- Sala 11 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 5
(252, 'D', 'A', 2, 11),
(253, 'D', 'A', 3, 11),
(254, 'D', 'A', 4, 11),
(255, 'D', 'A', 5, 11),
(256, 'D', 'B', 1, 11),
(257, 'D', 'B', 2, 11),
(258, 'D', 'B', 3, 11),
(259, 'D', 'B', 4, 11),
(260, 'D', 'B', 5, 11),
(261, 'D', 'C', 1, 11),
(262, 'D', 'C', 2, 11),
(263, 'D', 'C', 3, 11),
(264, 'D', 'C', 4, 11),
(265, 'D', 'C', 5, 11),
(266, 'D', 'D', 1, 11),
(267, 'D', 'D', 2, 11),
(268, 'D', 'D', 3, 11),
(269, 'D', 'D', 4, 11),
(270, 'D', 'D', 5, 11),
(271, 'D', 'A', 1, 12),-- Sala 12 (30 asientos: A-E por 1-6) - Repetir el patrón de la Sala 6
(272, 'D', 'A', 2, 12),
(273, 'D', 'A', 3, 12),
(274, 'D', 'A', 4, 12),
(275, 'D', 'A', 5, 12),
(276, 'D', 'A', 6, 12),
(277, 'D', 'B', 1, 12),
(278, 'D', 'B', 2, 12),
(279, 'D', 'B', 3, 12),
(280, 'D', 'B', 4, 12),
(281, 'D', 'B', 5, 12),
(282, 'D', 'B', 6, 12),
(283, 'D', 'C', 1, 12),
(284, 'D', 'C', 2, 12),
(285, 'D', 'C', 3, 12),
(286, 'D', 'C', 4, 12),
(287, 'D', 'C', 5, 12),
(288, 'D', 'C', 6, 12),
(289, 'D', 'D', 1, 12),
(290, 'D', 'D', 2, 12),
(291, 'D', 'D', 3, 12),
(292, 'D', 'D', 4, 12),
(293, 'D', 'D', 5, 12),
(294, 'D', 'D', 6, 12),
(295, 'D', 'E', 1, 12),
(296, 'D', 'E', 2, 12),
(297, 'D', 'E', 3, 12),
(298, 'D', 'E', 4, 12),
(299, 'D', 'E', 5, 12),
(300, 'D', 'E', 6, 12),
(301, 'D', 'A', 1, 13),-- Sala 13 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 5
(302, 'D', 'A', 2, 13),
(303, 'D', 'A', 3, 13),
(304, 'D', 'A', 4, 13),
(305, 'D', 'A', 5, 13),
(306, 'D', 'B', 1, 13),
(307, 'D', 'B', 2, 13),
(308, 'D', 'B', 3, 13),
(309, 'D', 'B', 4, 13),
(310, 'D', 'B', 5, 13),
(311, 'D', 'C', 1, 13),
(312, 'D', 'C', 2, 13),
(313, 'D', 'C', 3, 13),
(314, 'D', 'C', 4, 13),
(315, 'D', 'C', 5, 13),
(316, 'D', 'D', 1, 13),
(317, 'D', 'D', 2, 13),
(318, 'D', 'D', 3, 13),
(319, 'D', 'D', 4, 13),
(320, 'D', 'D', 5, 13),
(321, 'D', 'A', 1, 14),-- Sala 14 (30 asientos: A-E por 1-6) - Repetir el patrón de la Sala 6
(322, 'D', 'A', 2, 14),
(323, 'D', 'A', 3, 14),
(324, 'D', 'A', 4, 14),
(325, 'D', 'A', 5, 14),
(326, 'D', 'A', 6, 14),
(327, 'D', 'B', 1, 14),
(328, 'D', 'B', 2, 14),
(329, 'D', 'B', 3, 14),
(330, 'D', 'B', 4, 14),
(331, 'D', 'B', 5, 14),
(332, 'D', 'B', 6, 14),
(333, 'D', 'C', 1, 14),
(334, 'D', 'C', 2, 14),
(335, 'D', 'C', 3, 14),
(336, 'D', 'C', 4, 14),
(337, 'D', 'C', 5, 14),
(338, 'D', 'C', 6, 14),
(339, 'D', 'D', 1, 14),
(340, 'D', 'D', 2, 14),
(341, 'D', 'D', 3, 14),
(342, 'D', 'D', 4, 14),
(343, 'D', 'D', 5, 14),
(344, 'D', 'D', 6, 14),
(345, 'D', 'E', 1, 14),
(346, 'D', 'E', 2, 14),
(347, 'D', 'E', 3, 14),
(348, 'D', 'E', 4, 14),
(349, 'D', 'E', 5, 14),
(350, 'D', 'E', 6, 14),
(351, 'D', 'A', 1, 15),-- Sala 15 (20 asientos: A-D por 1-5) - Repetir el patrón de la Sala 5
(352, 'D', 'A', 2, 15),
(353, 'D', 'A', 3, 15),
(354, 'D', 'A', 4, 15),
(355, 'D', 'A', 5, 15),
(356, 'D', 'B', 1, 15),
(357, 'D', 'B', 2, 15),
(358, 'D', 'B', 3, 15),
(359, 'D', 'B', 4, 15),
(360, 'D', 'B', 5, 15),
(361, 'D', 'C', 1, 15),
(362, 'D', 'C', 2, 15),
(363, 'D', 'C', 3, 15),
(364, 'D', 'C', 4, 15),
(365, 'D', 'C', 5, 15),
(366, 'D', 'D', 1, 15),
(367, 'D', 'D', 2, 15),
(368, 'D', 'D', 3, 15),
(369, 'D', 'D', 4, 15),
(370, 'D', 'D', 5, 15);

--para la sucursal 2 (Cine Marvel LP)
-- Insertar datos en la tabla Butaca para la Sucursal 2
INSERT INTO Butaca (Id, Estado, IdFila, IdColumna, IdSala) VALUES
(371, 'D', 'A', 1, 16),-- Sala 16 (20 asientos: A-D por 1-5) 
(372, 'D', 'A', 2, 16),
(373, 'D', 'A', 3, 16),
(374, 'D', 'A', 4, 16),
(375, 'D', 'A', 5, 16),
(376, 'D', 'B', 1, 16),
(377, 'D', 'B', 2, 16),
(378, 'D', 'B', 3, 16),
(379, 'D', 'B', 4, 16),
(380, 'D', 'B', 5, 16),
(381, 'D', 'C', 1, 16),
(382, 'D', 'C', 2, 16),
(383, 'D', 'C', 3, 16),
(384, 'D', 'C', 4, 16),
(385, 'D', 'C', 5, 16),
(386, 'D', 'D', 1, 16),
(387, 'D', 'D', 2, 16),
(388, 'D', 'D', 3, 16),
(389, 'D', 'D', 4, 16),
(390, 'D', 'D', 5, 16),
(391, 'D', 'A', 1, 17),-- Sala 17 (30 asientos: A-E por 1-6) - Similar a la Sala 6
(392, 'D', 'A', 2, 17),
(393, 'D', 'A', 3, 17),
(394, 'D', 'A', 4, 17),
(395, 'D', 'A', 5, 17),
(396, 'D', 'A', 6, 17),
(397, 'D', 'B', 1, 17),
(398, 'D', 'B', 2, 17),
(399, 'D', 'B', 3, 17),
(400, 'D', 'B', 4, 17),
(401, 'D', 'B', 5, 17),
(402, 'D', 'B', 6, 17),
(403, 'D', 'C', 1, 17),
(404, 'D', 'C', 2, 17),
(405, 'D', 'C', 3, 17),
(406, 'D', 'C', 4, 17),
(407, 'D', 'C', 5, 17),
(408, 'D', 'C', 6, 17),
(409, 'D', 'D', 1, 17),
(410, 'D', 'D', 2, 17),
(411, 'D', 'D', 3, 17),
(412, 'D', 'D', 4, 17),
(413, 'D', 'D', 5, 17),
(414, 'D', 'D', 6, 17),
(415, 'D', 'E', 1, 17),
(416, 'D', 'E', 2, 17),
(417, 'D', 'E', 3, 17),
(418, 'D', 'E', 4, 17),
(419, 'D', 'E', 5, 17),
(420, 'D', 'E', 6, 17),
(421, 'D', 'A', 1, 18),-- Sala 18 (20 asientos: A-D por 1-5) - Similar a la Sala 5
(422, 'D', 'A', 2, 18),
(423, 'D', 'A', 3, 18),
(424, 'D', 'A', 4, 18),
(425, 'D', 'A', 5, 18),
(426, 'D', 'B', 1, 18),
(427, 'D', 'B', 2, 18),
(428, 'D', 'B', 3, 18),
(429, 'D', 'B', 4, 18),
(430, 'D', 'B', 5, 18),
(431, 'D', 'C', 1, 18),
(432, 'D', 'C', 2, 18),
(433, 'D', 'C', 3, 18),
(434, 'D', 'C', 4, 18),
(435, 'D', 'C', 5, 18),
(436, 'D', 'D', 1, 18),
(437, 'D', 'D', 2, 18),
(438, 'D', 'D', 3, 18),
(439, 'D', 'D', 4, 18),
(440, 'D', 'D', 5, 18),
(441, 'D', 'A', 1, 19),-- Sala 19 (30 asientos: A-E por 1-6) - Similar a la Sala 6
(442, 'D', 'A', 2, 19),
(443, 'D', 'A', 3, 19),
(444, 'D', 'A', 4, 19),
(445, 'D', 'A', 5, 19),
(446, 'D', 'A', 6, 19),
(447, 'D', 'B', 1, 19),
(448, 'D', 'B', 2, 19),
(449, 'D', 'B', 3, 19),
(450, 'D', 'B', 4, 19),
(451, 'D', 'B', 5, 19),
(452, 'D', 'B', 6, 19),
(453, 'D', 'C', 1, 19),
(454, 'D', 'C', 2, 19),
(455, 'D', 'C', 3, 19),
(456, 'D', 'C', 4, 19),
(457, 'D', 'C', 5, 19),
(458, 'D', 'C', 6, 19),
(459, 'D', 'D', 1, 19),
(460, 'D', 'D', 2, 19),
(461, 'D', 'D', 3, 19),
(462, 'D', 'D', 4, 19),
(463, 'D', 'D', 5, 19),
(464, 'D', 'D', 6, 19),
(465, 'D', 'E', 1, 19),
(466, 'D', 'E', 2, 19),
(467, 'D', 'E', 3, 19),
(468, 'D', 'E', 4, 19),
(469, 'D', 'E', 5, 19),
(470, 'D', 'E', 6, 19),
(471, 'D', 'A', 1, 20),-- Sala 20 (20 asientos: A-D por 1-5)
(472, 'D', 'A', 2, 20),
(473, 'D', 'A', 3, 20),
(474, 'D', 'A', 4, 20),
(475, 'D', 'A', 5, 20),
(476, 'D', 'B', 1, 20),
(477, 'D', 'B', 2, 20),
(478, 'D', 'B', 3, 20),
(479, 'D', 'B', 4, 20),
(480, 'D', 'B', 5, 20),
(481, 'D', 'C', 1, 20),
(482, 'D', 'C', 2, 20),
(483, 'D', 'C', 3, 20),
(484, 'D', 'C', 4, 20),
(485, 'D', 'C', 5, 20),
(486, 'D', 'D', 1, 20),
(487, 'D', 'D', 2, 20),
(488, 'D', 'D', 3, 20),
(489, 'D', 'D', 4, 20),
(490, 'D', 'D', 5, 20),
(491, 'D', 'A', 1, 21),-- Sala 21 (30 asientos: A-E por 1-6)
(492, 'D', 'A', 2, 21),
(493, 'D', 'A', 3, 21),
(494, 'D', 'A', 4, 21),
(495, 'D', 'A', 5, 21),
(496, 'D', 'A', 6, 21),
(497, 'D', 'B', 1, 21),
(498, 'D', 'B', 2, 21),
(499, 'D', 'B', 3, 21),
(500, 'D', 'B', 4, 21),
(501, 'D', 'B', 5, 21),
(502, 'D', 'B', 6, 21),
(503, 'D', 'C', 1, 21),
(504, 'D', 'C', 2, 21),
(505, 'D', 'C', 3, 21),
(506, 'D', 'C', 4, 21),
(507, 'D', 'C', 5, 21),
(508, 'D', 'C', 6, 21),
(509, 'D', 'D', 1, 21),
(510, 'D', 'D', 2, 21),
(511, 'D', 'D', 3, 21),
(512, 'D', 'D', 4, 21),
(513, 'D', 'D', 5, 21),
(514, 'D', 'D', 6, 21),
(515, 'D', 'E', 1, 21),
(516, 'D', 'E', 2, 21),
(517, 'D', 'E', 3, 21),
(518, 'D', 'E', 4, 21),
(519, 'D', 'E', 5, 21),
(520, 'D', 'E', 6, 21),
(521, 'D', 'A', 1, 22),-- Sala 22 (20 asientos: A-D por 1-5)
(522, 'D', 'A', 2, 22),
(523, 'D', 'A', 3, 22),
(524, 'D', 'A', 4, 22),
(525, 'D', 'A', 5, 22),
(526, 'D', 'B', 1, 22),
(527, 'D', 'B', 2, 22),
(528, 'D', 'B', 3, 22),
(529, 'D', 'B', 4, 22),
(530, 'D', 'B', 5, 22),
(531, 'D', 'C', 1, 22),
(532, 'D', 'C', 2, 22),
(533, 'D', 'C', 3, 22),
(534, 'D', 'C', 4, 22),
(535, 'D', 'C', 5, 22),
(536, 'D', 'D', 1, 22),
(537, 'D', 'D', 2, 22),
(538, 'D', 'D', 3, 22),
(539, 'D', 'D', 4, 22),
(540, 'D', 'D', 5, 22),
(541, 'D', 'A', 1, 23),-- Sala 23 (30 asientos: A-E por 1-6)
(542, 'D', 'A', 2, 23),
(543, 'D', 'A', 3, 23),
(544, 'D', 'A', 4, 23),
(545, 'D', 'A', 5, 23),
(546, 'D', 'A', 6, 23),
(547, 'D', 'B', 1, 23),
(548, 'D', 'B', 2, 23),
(549, 'D', 'B', 3, 23),
(550, 'D', 'B', 4, 23),
(551, 'D', 'B', 5, 23),
(552, 'D', 'B', 6, 23),
(553, 'D', 'C', 1, 23),
(554, 'D', 'C', 2, 23),
(555, 'D', 'C', 3, 23),
(556, 'D', 'C', 4, 23),
(557, 'D', 'C', 5, 23),
(558, 'D', 'C', 6, 23),
(559, 'D', 'D', 1, 23),
(560, 'D', 'D', 2, 23),
(561, 'D', 'D', 3, 23),
(562, 'D', 'D', 4, 23),
(563, 'D', 'D', 5, 23),
(564, 'D', 'D', 6, 23),
(565, 'D', 'E', 1, 23),
(566, 'D', 'E', 2, 23),
(567, 'D', 'E', 3, 23),
(568, 'D', 'E', 4, 23),
(569, 'D', 'E', 5, 23),
(570, 'D', 'E', 6, 23),
(571, 'D', 'A', 1, 24),-- Sala 24 (20 asientos: A-D por 1-5)
(572, 'D', 'A', 2, 24),
(573, 'D', 'A', 3, 24),
(574, 'D', 'A', 4, 24),
(575, 'D', 'A', 5, 24),
(576, 'D', 'B', 1, 24),
(577, 'D', 'B', 2, 24),
(578, 'D', 'B', 3, 24),
(579, 'D', 'B', 4, 24),
(580, 'D', 'B', 5, 24),
(581, 'D', 'C', 1, 24),
(582, 'D', 'C', 2, 24),
(583, 'D', 'C', 3, 24),
(584, 'D', 'C', 4, 24),
(585, 'D', 'C', 5, 24),
(586, 'D', 'D', 1, 24),
(587, 'D', 'D', 2, 24),
(588, 'D', 'D', 3, 24),
(589, 'D', 'D', 4, 24),
(590, 'D', 'D', 5, 24),
(591, 'D', 'A', 1, 25),-- Sala 25 (30 asientos: A-E por 1-6)
(592, 'D', 'A', 2, 25),
(593, 'D', 'A', 3, 25),
(594, 'D', 'A', 4, 25),
(595, 'D', 'A', 5, 25),
(596, 'D', 'A', 6, 25),
(597, 'D', 'B', 1, 25),
(598, 'D', 'B', 2, 25),
(599, 'D', 'B', 3, 25),
(600, 'D', 'B', 4, 25),
(601, 'D', 'B', 5, 25),
(602, 'D', 'B', 6, 25),
(603, 'D', 'C', 1, 25),
(604, 'D', 'C', 2, 25),
(605, 'D', 'C', 3, 25),
(606, 'D', 'C', 4, 25),
(607, 'D', 'C', 5, 25),
(608, 'D', 'C', 6, 25),
(609, 'D', 'D', 1, 25),
(610, 'D', 'D', 2, 25),
(611, 'D', 'D', 3, 25),
(612, 'D', 'D', 4, 25),
(613, 'D', 'D', 5, 25),
(614, 'D', 'D', 6, 25),
(615, 'D', 'E', 1, 25),
(616, 'D', 'E', 2, 25),
(617, 'D', 'E', 3, 25),
(618, 'D', 'E', 4, 25),
(619, 'D', 'E', 5, 25),
(620, 'D', 'E', 6, 25),
(621, 'D', 'A', 1, 26),-- Sala 26 (20 asientos: A-D por 1-5)
(622, 'D', 'A', 2, 26),
(623, 'D', 'A', 3, 26),
(624, 'D', 'A', 4, 26),
(625, 'D', 'A', 5, 26),
(626, 'D', 'B', 1, 26),
(627, 'D', 'B', 2, 26),
(628, 'D', 'B', 3, 26),
(629, 'D', 'B', 4, 26),
(630, 'D', 'B', 5, 26),
(631, 'D', 'C', 1, 26),
(632, 'D', 'C', 2, 26),
(633, 'D', 'C', 3, 26),
(634, 'D', 'C', 4, 26),
(635, 'D', 'C', 5, 26),
(636, 'D', 'D', 1, 26),
(637, 'D', 'D', 2, 26),
(638, 'D', 'D', 3, 26),
(639, 'D', 'D', 4, 26),
(640, 'D', 'D', 5, 26),
(641, 'D', 'A', 1, 27),-- Sala 27 (30 asientos: A-E por 1-6)
(642, 'D', 'A', 2, 27),
(643, 'D', 'A', 3, 27),
(644, 'D', 'A', 4, 27),
(645, 'D', 'A', 5, 27),
(646, 'D', 'A', 6, 27),
(647, 'D', 'B', 1, 27),
(648, 'D', 'B', 2, 27),
(649, 'D', 'B', 3, 27),
(650, 'D', 'B', 4, 27),
(651, 'D', 'B', 5, 27),
(652, 'D', 'B', 6, 27),
(653, 'D', 'C', 1, 27),
(654, 'D', 'C', 2, 27),
(655, 'D', 'C', 3, 27),
(656, 'D', 'C', 4, 27),
(657, 'D', 'C', 5, 27),
(658, 'D', 'C', 6, 27),
(659, 'D', 'D', 1, 27),
(660, 'D', 'D', 2, 27),
(661, 'D', 'D', 3, 27),
(662, 'D', 'D', 4, 27),
(663, 'D', 'D', 5, 27),
(664, 'D', 'D', 6, 27),
(665, 'D', 'E', 1, 27),
(666, 'D', 'E', 2, 27),
(667, 'D', 'E', 3, 27),
(668, 'D', 'E', 4, 27),
(669, 'D', 'E', 5, 27),
(670, 'D', 'E', 6, 27),
(671, 'D', 'A', 1, 28),-- Sala 28 (20 asientos: A-D por 1-5)
(672, 'D', 'A', 2, 28),
(673, 'D', 'A', 3, 28),
(674, 'D', 'A', 4, 28),
(675, 'D', 'A', 5, 28),
(676, 'D', 'B', 1, 28),
(677, 'D', 'B', 2, 28),
(678, 'D', 'B', 3, 28),
(679, 'D', 'B', 4, 28),
(680, 'D', 'B', 5, 28),
(681, 'D', 'C', 1, 28),
(682, 'D', 'C', 2, 28),
(683, 'D', 'C', 3, 28),
(684, 'D', 'C', 4, 28),
(685, 'D', 'C', 5, 28),
(686, 'D', 'D', 1, 28),
(687, 'D', 'D', 2, 28),
(688, 'D', 'D', 3, 28),
(689, 'D', 'D', 4, 28),
(690, 'D', 'D', 5, 28),
(691, 'D', 'A', 1, 29),-- Sala 29 (30 asientos: A-E por 1-6)
(692, 'D', 'A', 2, 29),
(693, 'D', 'A', 3, 29),
(694, 'D', 'A', 4, 29),
(695, 'D', 'A', 5, 29),
(696, 'D', 'A', 6, 29),
(697, 'D', 'B', 1, 29),
(698, 'D', 'B', 2, 29),
(699, 'D', 'B', 3, 29),
(700, 'D', 'B', 4, 29),
(701, 'D', 'B', 5, 29),
(702, 'D', 'B', 6, 29),
(703, 'D', 'C', 1, 29),
(704, 'D', 'C', 2, 29),
(705, 'D', 'C', 3, 29),
(706, 'D', 'C', 4, 29),
(707, 'D', 'C', 5, 29),
(708, 'D', 'C', 6, 29),
(709, 'D', 'D', 1, 29),
(710, 'D', 'D', 2, 29),
(711, 'D', 'D', 3, 29),
(712, 'D', 'D', 4, 29),
(713, 'D', 'D', 5, 29),
(714, 'D', 'D', 6, 29),
(715, 'D', 'E', 1, 29),
(716, 'D', 'E', 2, 29),
(717, 'D', 'E', 3, 29),
(718, 'D', 'E', 4, 29),
(719, 'D', 'E', 5, 29),
(720, 'D', 'E', 6, 29),
(721, 'D', 'A', 1, 30),-- Sala 30 (20 asientos: A-D por 1-5)
(722, 'D', 'A', 2, 30),
(723, 'D', 'A', 3, 30),
(724, 'D', 'A', 4, 30),
(725, 'D', 'A', 5, 30),
(726, 'D', 'B', 1, 30),
(727, 'D', 'B', 2, 30),
(728, 'D', 'B', 3, 30),
(729, 'D', 'B', 4, 30),
(730, 'D', 'B', 5, 30),
(731, 'D', 'C', 1, 30),
(732, 'D', 'C', 2, 30),
(733, 'D', 'C', 3, 30),
(734, 'D', 'C', 4, 30),
(735, 'D', 'C', 5, 30),
(736, 'D', 'D', 1, 30),
(737, 'D', 'D', 2, 30),
(738, 'D', 'D', 3, 30),
(739, 'D', 'D', 4, 30),
(740, 'D', 'D', 5, 30);


SELECT * FROM Persona;-- 13. 
-- Insertar datos en la tabla Persona--hay que mejorar esto con respecto de que una persona pueda ser tanto cliente como cajero(empleado o trabajador del cine)
INSERT INTO Persona (Id, Nombre, Apellido, Correo, Contraseña) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '123456'), -- Cliente
(2, 'Ana', 'García', 'ana.garcia@example.com', 'abcdef'), -- Cliente
(3, 'Luis', 'Cruz', 'luis.cruz@example.com', 'password'), -- Cliente
(4, 'Maria', 'Flores', 'maria.flores@example.com', 'qwerty'), -- Cliente
(5, 'Carlos', 'Martínez', 'carlos.martinez@example.com', '123abc'), -- Cliente
(6, 'Sofia', 'Rivas', 'sofia.rivas@example.com', '789xyz'), -- Cliente
(7, 'Jorge', 'Morales', 'jorge.morales@example.com', 'admin01'), -- Cliente
(8, 'Laura', 'Torres', 'laura.torres@example.com', 'secure'), -- Cliente
(9, 'Ricardo', 'Vargas', 'ricardo.vargas@example.com', 'myPass'), -- Cliente
(10, 'Verónica', 'Salazar', 'veronica.salazar@example.com', 'letmein'), -- Cliente
(11, 'Fernando', 'Hernández', 'fernando.hernandez@example.com', 'iloveyou'), -- Cliente
(12, 'Gabriela', 'Paredes', 'gabriela.paredes@example.com', '1234567'), -- Cliente
(13, 'Julio', 'Benítez', 'julio.benitez@example.com', 'pass123'), -- Cliente
(14, 'Natalia', 'Sánchez', 'natalia.sanchez@example.com', 'qweasd'), -- Cliente
(15, 'Eduardo', 'Jiménez', 'eduardo.jimenez@example.com', 'admin123'); -- Cliente

SELECT * FROM Cliente_Virtual;-- 14. 
-- Insertar datos en la tabla Cliente_Virtual
INSERT INTO Cliente_Virtual (IdPersona, FechaRegistro, telefono) VALUES
(1, '2024-01-15', 12345678), -- Cliente con ID 1
(2, '2024-02-20', 23456789), -- Cliente con ID 2
(3, '2024-03-10', 34567890), -- Cliente con ID 3
(4, '2024-04-05', 45678901), -- Cliente con ID 4
(5, '2024-05-25', 56789012), -- Cliente con ID 5
(6, '2024-06-30', 67890123), -- Cliente con ID 6
(7, '2024-07-15', 78901234), -- Cliente con ID 7
(8, '2024-08-20', 89012345), -- Cliente con ID 8
(9, '2024-09-10', 90123456), -- Cliente con ID 9
(10, '2024-10-25', 12309876), -- Cliente con ID 10
(11, '2024-11-05', 23456701), -- Cliente con ID 11
(12, '2024-12-15', 34567812), -- Cliente con ID 12
(13, '2024-01-10', 45678923), -- Cliente con ID 13
(14, '2024-02-25', 56789034), -- Cliente con ID 14
(15, '2024-03-20', 67890145); -- Cliente con ID 15

SELECT * FROM Cajero_Prod;-- 15. 
-- Insertar datos en la tabla Cajero_Prod
INSERT INTO Cajero_Prod (IdPersona, HoraEntrada, HoraSalida) VALUES
(1, '09:00:00', '17:00:00'), -- Cajero con ID 1
(5, '12:00:00', '20:00:00'), -- Cajero con ID 5
(8, '07:45:00', '15:45:00'), -- Cajero con ID 8
(10, '11:15:00', '19:15:00'); -- Cajero con ID 10

SELECT * FROM Puesto;-- 16. 
-- Insertar datos en la tabla Puesto
INSERT INTO Puesto (Id, Nombre, IdCajero) VALUES
(1, 'Cajero Principal', 1), -- Puesto 1 asociado con Cajero con ID 1
(2, 'Caja 1', 5), -- Puesto 5 asociado con Cajero con ID 5
(3, 'Caja 2', 8), -- Puesto 8 asociado con Cajero con ID 8
(4, 'snak 1', 10); -- Puesto 10 asociado con Cajero con ID 10

SELECT * FROM Cliente_Presencial;-- 17. 
-- Insertar datos en la tabla Cliente_Presencial
INSERT INTO Cliente_Presencial (Id, Ci) VALUES
(1, 123456), -- Cliente 1
(2, 234567), -- Cliente 2
(3, 345678), -- Cliente 3
(4, 456789), -- Cliente 4
(5, 567890), -- Cliente 5
(6, 678901), -- Cliente 6
(7, 789014); -- Cliente 7

SELECT * FROM Proveedor;-- 18. 
--proveedores
INSERT INTO Proveedor (Id, Nombre, Fecha_Actualizacion) VALUES
(1, 'Proveedor A', '2024-09-01'), -- Proveedor 1
(2, 'Proveedor B', '2024-09-05'), -- Proveedor 2
(3, 'Proveedor C', '2024-09-10'), -- Proveedor 3
(4, 'Proveedor D', '2024-09-15'), -- Proveedor 4
(5, 'Proveedor E', '2024-09-20'), -- Proveedor 5
(6, 'Proveedor F', '2024-09-25'), -- Proveedor 6
(7, 'Proveedor G', '2024-09-30'), -- Proveedor 7
(8, 'Proveedor H', '2024-10-01'), -- Proveedor 8
(9, 'Proveedor I', '2024-10-05'), -- Proveedor 9
(10, 'Proveedor J', '2024-10-10'); -- Proveedor 10

SELECT * FROM Categoria;-- 19. 
-- Insertar datos en la tabla Categoria
INSERT INTO Categoria (Id, Descripcion) VALUES
(1, 'Bebidas'),         -- Categoría para bebidas (ej. refrescos, agua)
(2, 'Gaseosas'),       -- Categoría para gaseosas (ej. coca cola, sprite, pepsi, fanta)
(3, 'Confitería'),     -- Categoría para productos de confitería (ej. caramelos, chocolates)
(4, 'Snacks');         -- Categoría para snacks (ej. palomitas de maíz, nachos)

SELECT * FROM Producto;-- 20. 
-- Insertar datos en la tabla Producto
INSERT INTO Producto (Id, Nombre, Fecha_Vencimiento,Precio_unitario, IdCajero, IdCategoria) VALUES
(1, 'Coca-Cola pequeño', '2024-12-31', 15, 1, 2),  -- Gaseosa
(2, 'Coca-Cola mediano', '2024-12-31', 20, 1, 2),  -- Gaseosa
(3, 'Coca-Cola grande', '2024-12-31',25 , 1, 2),  -- Gaseosa
(4, 'Pepsi pequeño', '2024-12-31', 15, 1, 2),      -- Gaseosa
(5, 'Pepsi mediano', '2024-12-31', 20, 1, 2),      -- Gaseosa
(6, 'Pepsi grande', '2024-12-31', 25, 1, 2),      -- Gaseosa
(7, 'Pipoca pequeña', '2024-10-31', 30, 10, 4),  -- Snack
(8, 'Pipoca mediana', '2024-10-31', 35, 10, 4),  -- Snack
(9, 'Pipoca grande', '2024-10-31', 40, 10, 4),  -- Snack
(10, 'Nachos con Queso', '2024-10-31', 10, 10, 4),  -- Snack
(11, 'Chocolate Crunch', '2024-11-15', 10, 5, 3), -- Confitería
(12, 'Gominolas', '2024-11-30', 10, 5, 3),       -- Confitería
(13, 'Agua Mineral', '2024-12-31', 10, 8, 1),    -- Bebida
(14, 'Jugo de Naranja', '2024-11-30', 20, 8, 1);  -- Bebida

SELECT * FROM Proveedor_Producto;-- 21. 
-- Insertar datos en la tabla Proveedor_Producto
INSERT INTO Proveedor_Producto (IdProveedor, IdProducto) VALUES
(1, 1),  -- Proveedor 1 suministra Coca-Cola pequeña
(1, 2),  -- Proveedor 1 suministra Coca-Cola mediana
(1, 3),  -- Proveedor 1 suministra Coca-Cola grande
(2, 4),  -- Proveedor 2 suministra Pepsi pequeña
(2, 5),  -- Proveedor 2 suministra Pepsi mediana
(2, 6),  -- Proveedor 2 suministra Pepsi grande
(3, 7),  -- Proveedor 3 suministra Pipoca pequeña
(3, 8),  -- Proveedor 3 suministra Pipoca mediana
(3, 9),  -- Proveedor 3 suministra Pipoca grande
(4, 10),  -- Proveedor 4 suministra Nachos con Queso
(5, 11),  -- Proveedor 5 suministra Chocolate Crunch
(6, 12),  -- Proveedor 6 suministra Gominolas
(7, 13),  -- Proveedor 7 suministra Agua Mineral
(8, 14);  -- Proveedor 8 suministra Jugo de Naranja

SELECT * FROM Combo;-- 22. 
-- Insertar datos en la tabla Combo
INSERT INTO Combo (Id, Nombre, Descripcion, PrecioTotal) VALUES
(1, 'Combo Familiar', '2 gaseosas grandes, 1 pipoca grande.', 65.00),
(2, 'Combo para Parejas', '1 pipoca mediana, 2 bebidas medianas y 1 caja de gominolas.', 40.00),
(3, 'Combo Infantil', '1 pipoca pequeña, 1 bebida pequeña y 1 chocolate crunch.', 32.00),
(4, 'Combo Miercoles', '1 pipoca grande, 1 bebida grande, 1 caja de nachos.', 65.00),
(5, 'Combo Básico', '1 bebida y 1 snack de tu elección.', 40.00);

SELECT * FROM Combo_Categoria;-- 23.
-- Insertar datos en la tabla Combo_Categoria
INSERT INTO Combo_Categoria (IdCombo, IdCategoria, cantidad)
VALUES
(1, 2, 2), -- Combo Familiar incluye 2 gaseosa grandes
(1, 4, 1), -- Combo Familiar incluye 1 pipoca grande
(2, 1, 1), -- Combo para Parejas incluye 1 bebida pequeña
(2, 3, 1), -- Combo para Parejas incluye 1 caja de gominolas
(2, 4, 1), -- Combo para Parejas incluye 1 pipoca mediana
(3, 1, 1), -- Combo Infantil incluye 1 bebida pequeña
(3, 3, 1), -- Combo Infantil incluye 1 chocolate crunch
(3, 4, 1); -- Combo Infantil incluye 1 pipoca pequeña
--solo estan los primero 3 combos

select * from Tipo_pago;
-- Insertar datos en la tabla Tipo_pago
INSERT INTO Tipo_pago (Id, Descripcion) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de Crédito'),
(3, 'Tarjeta de Débito'),
(4, 'Tigo Money'),
(5, 'Transferencia Bancaria');

SELECT * FROM Factura;-- 24. 
-- Insertar datos en la tabla Factura
INSERT INTO Factura (Id, CodigoQR, Fecha,Monto_total, IdTipoPago, IdCli_Virtual, IdCli_Presencial, IdCajero)
VALUES
(1, 'QR001', '2024-09-01', 200, 1, 1, NULL, NULL), -- Factura para cliente virtual con Id 1
(2, 'QR002', '2024-09-02', 300, 2, NULL, 1, 1),    -- Factura para cliente presencial con Id 1, procesada por el cajero con IdPersona 1
(3, 'QR003', '2024-09-03', 200, 3, NULL, 2, 5),    -- Factura para cliente presencial con Id 2, procesada por el cajero con IdPersona 5
(4, 'QR004', '2024-09-04', 300, 4, NULL, 3, 8),    -- Factura para cliente presencial con Id 3, procesada por el cajero con IdPersona 8
(5, 'QR005', '2024-09-05', 200, 5, NULL, 4, 10),    -- Factura para cliente presencial con Id 4, procesada por el cajero con IdPersona 10
(6, 'QR006', '2024-09-06', 100, 1, 2, NULL, NULL),    -- Factura para cliente virtual con Id 2
(7, 'QR007', '2024-09-07', 100, 2, 3, NULL, NULL),    -- Factura para cliente virtual con Id 3 
(8, 'QR008', '2024-09-08', 200, 3, 4, NULL, NULL),    -- Factura para cliente virtual con Id 4
(9, 'QR009', '2024-09-09', 300, 4, NULL, 5, 1),    -- Factura para cliente presencial con Id 5, procesada por el cajero con IdPersona 1
(10, 'QR010', '2024-09-10', 100, 5, 5, NULL, NULL);  -- Factura para cliente virtual con Id 5

SELECT * FROM Detalle_Producto;-- 25. 
-- Insertar datos en la tabla Detalle_Producto
INSERT INTO Detalle_Producto (IdFactura, IdProducto, cantidad, MontoTotal)
VALUES
(1, 3, 1, 60.00), -- Factura 1 incluye 1 unidad del Producto 3, totalizando 60.00
(1, 9, 1, 60.00), -- Factura 1 incluye 1 unidad del Producto 9, totalizando 60.00
(1, 10, 1, 10.00), -- Factura 1 incluye 1 unidad del Producto 10, totalizando 10.00
(2, 1, 1, 20.00), -- Factura 2 incluye 1 unidad del Producto 1, totalizando 20.00
(2, 7, 2, 100.00), -- Factura 2 incluye 2 unidades del Producto 7, totalizando 100.00
(3, 4, 2, 60.00), -- Factura 3 incluye 2 unidades del Producto 4, totalizando 60.00
(3, 7, 2, 100.00), -- Factura 3 incluye 2 unidades del Producto 7, totalizando 100.00
(4, 14, 1, 20.00), -- Factura 4 incluye 1 unidades del Producto 14, totalizando 20.00
(4, 10, 1, 20.00), -- Factura 4 incluye 1 unidades del Producto 10, totalizando 20.00
(4, 7, 2, 100.00), -- Factura 4 incluye 2 unidades del Producto 102, totalizando 100.00
(5, 5, 3, 90.00), -- Factura 5 incluye 3 unidades del Producto 5, totalizando 90.00
(5, 9, 2, 120.00), -- Factura 5 incluye 2 unidades del Producto 9, totalizando 120.00
(6, 3, 2, 120.00), -- Factura 6 incluye 2 unidades del Producto 3, totalizando 120.00
(6, 8, 2, 100.00), -- Factura 6 incluye 2 unidades del Producto 8, totalizando 100.00
(6, 11, 1, 20.00), -- Factura 6 incluye 1 unidad del Producto 11, totalizando 20.00
(7, 13, 1, 8.00), -- Factura 7 incluye 1 unidad del Producto 13, totalizando 8.00
(7, 7, 1, 30.00); -- Factura 7 incluye 1 unidad del Producto 7, totalizando 30.00



SELECT * FROM Combo_Factura;-- 26. 
-- Insertar datos en la tabla Combo_Factura
INSERT INTO Combo_Factura (IdCombo, IdFactura, cantidad)
VALUES
(1, 1, 2),  -- Combo 1 en Factura 1, 2 unidades
(2, 1, 1),  -- Combo 2 en Factura 1, 1 unidad
(3, 2, 3),  -- Combo 3 en Factura 2, 3 unidades
(4, 2, 3),  -- Combo 4 en Factura 2, 3 unidades
(5, 3, 1),  -- Combo 5 en Factura 3, 1 unidades
(1, 4, 3),  -- Combo 1 en Factura 4, 3 unidades
(2, 5, 1),  -- Combo 2 en Factura 5, 1 unidades
(3, 6, 3),  -- Combo 3 en Factura 6, 3 unidades
(4, 7, 3),  -- Combo 4 en Factura 7, 3 unidades
(5, 7, 1);  -- Combo 5 en Factura 7, 1 unidad

SELECT * FROM Boleto;-- 27. 
-- Insertar datos en la tabla Boleto
INSERT INTO Boleto (Id, Precio, IdFactura, IdPromocion, IdButaca, IdSala)
VALUES
(1, 45.00, 1, 1, 1, 1),  -- Boleto 1: Precio 45.00, Factura 1, Promoción 1, Butaca 1, Sala 1
(2, 50.00, 2, 4, 71, 4),  -- Boleto 2: Precio 50.00, Factura 2, Promoción 4, Butaca 71, Sala 4
(3, 40.00, 2, 4, 72, 4),  -- Boleto 3: Precio 40.00, Factura 2, Promoción 4, Butaca 72, Sala 4
(4, 60.00, 3, 4, 38, 2),  -- Boleto 4: Precio 60.00, Factura 3, Promoción 4, Butaca 38, Sala 2
(5, 55.00, 4, 4, 39, 2),  -- Boleto 5: Precio 55.00, Factura 4, Promoción 4, Butaca 39, Sala 2
(6, 55.00, 6, 1, 110, 5),  -- Boleto 5: Precio 55.00, Factura 6, Promoción 1, Butaca 110, Sala 5
(7, 55.00, 7, 1, 111, 5),  -- Boleto 5: Precio 55.00, Factura 7, Promoción 1, Butaca 11, Sala 5
(8, 55.00, 8, 1, 112, 5),  -- Boleto 5: Precio 55.00, Factura 8, Promoción 1, Butaca 112, Sala 5
(9, 55.00, 9, 4, 140, 6),  -- Boleto 5: Precio 55.00, Factura 5, Promoción 4, Butaca 140, Sala 6
(10, 55.00, 10, 1, 113, 5),  -- Boleto 5: Precio 55.00, Factura 10, Promoción 1, Butaca 113, Sala 5
(11, 70.00, 10, 1, 141, 6);  -- Boleto 6: Precio 70.00, Factura 10, Promoción 1, Butaca 141, Sala 6

SELECT Id, IdSala FROM Butaca;

