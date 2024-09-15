
-- creacion de la base de datos cine

create database CineMarvel2024;
use CineMarvel2024;

--USE master; -- si quieres cambiar alguna cosa, elimina y crea de nuevo la BD
--DROP DATABASE CineMarvel2024;--asi evitamos usar alter table, es moroso ejecutar de nuevo pero es mas legible

create table Sucursal
(-- 1
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Direccion varchar(90) not null,
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
	foreign key (IdSucursal) references Sucursal
		on update cascade
		on delete cascade
);

create table Formato
(--3 
	Id integer not null primary key,
	Descripcion varchar(60) not null,
	precio decimal(12,2) not null
);

create table Genero
(--4
	Id integer not null primary key,
	Nombre varchar(40) not null
);

create table Lenguaje
(--5
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Subtitulo varchar(10)
);

create table Pelicula
(--6
	Id integer not null primary key,
	Nombre varchar(90) not null,
	Genero varchar(40) not null,
	Duracion time not null,
	Idgenero integer ,
	foreign key (Idgenero) references Genero
		on update cascade
		on delete cascade
);

create table Pelicula_Lenguaje
(--7
	IdPelicula integer not null, 
	IdLenguaje integer not null,
	foreign key (IdPelicula) references  Pelicula
		on update cascade
		on delete cascade,
	foreign key (IdLenguaje) references  Lenguaje
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
	foreign key (IdSala) references  Sala
		on update cascade
		on delete cascade,
	foreign key (IdFormato) references  Formato
		on update cascade
		on delete cascade,
	foreign key (IdPeli, IdLeng) references  Pelicula_Lenguaje
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
	Descripcion varchar(60) not null
);

create table Butaca
(--12
	Id integer not null ,
	Estado char(10) not null,
	Disponible char(1)not null,
	IdFila char(1) not null,
	IdColumna integer not null,
	IdSala integer not null,
	foreign key (IdFila) references  Fila
		on update cascade
		on delete cascade,
	foreign key (IdColumna) references  Columna
		on update cascade
		on delete cascade,
	foreign key (IdSala) references  Sala
		on update cascade
		on delete cascade,
	primary key (Id, IdSala)
);

create table Persona
(--13
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Apellido varchar(40) not null,
	Correo varchar(40) not null,
	Contraseña varchar(10) not null,
	tipo char (2) not null
);

create table Cliente_Virtual
(--14
	IdPersona integer not null,
	FechaRegistro date not null,
	telefono integer
	foreign key (IdPersona) references Persona
		on update cascade 
		on delete cascade,
	primary key (IdPersona)
);

create table Cajero_Prod
(--15
	IdPersona integer not null,
	HoraEntrada time not null,
	HoraSalida time not null,
	foreign key (IdPersona) references Persona
		on update cascade 
		on delete cascade,
	primary key (IdPersona)
);

create table Puesto
(--16
	Id integer not null primary key,
	Nombre varchar(40) not null,
	IdCajero integer not null,
	foreign key (IdCajero) references Cajero_Prod
		on update cascade 
		on delete cascade
);

create table Cliente_Presencial
(--17
	Id integer not null primary key,
	Ci integer,
	Nit integer
);

create table Proveedor
(--18
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Fecha_Actualizacion date not null
);

create table Categoria
(--19
	Id integer not null primary key,
	Descripcion varchar(60) not null
);

create table Producto
(--20
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Fecha_Vencimiento date not null,
	IdCajero integer not null,
	IdCategoria integer not null,
	foreign key (IdCajero) references Cajero_Prod
		on update cascade 
		on delete cascade,
	foreign key (IdCategoria) references Categoria
		on update cascade 
		on delete cascade
);

create table Proveedor_Producto
(--21
	IdProveedor integer not null,
	IdProducto integer not null,
	foreign key (IdProveedor) references Proveedor
		on update cascade 
		on delete cascade,
	foreign key (IdProducto) references Producto
		on update cascade 
		on delete cascade,
	Primary key (IdProveedor, IdProducto)
);

create table Combo
(--22
	Id integer not null primary key,
	Nombre varchar(40) not null,
	Descripcion varchar(60) not null,
	PrecioTotal decimal(12,2) not null
);

create table Combo_Categoria
(--23
	IdCombo integer not null,
	IdCategoria integer not null,
	cantidad integer not null,
	foreign key (IdCombo) references Combo
		on update cascade 
		on delete cascade,
	foreign key (IdCategoria) references Categoria
		on update cascade 
		on delete cascade,
	Primary key (IdCategoria, IdCombo)
);

create table Factura
(--24
	Id integer not null primary key,
	CodigoQR varchar(20) not null,
	Fecha date not null,
	IdCli_Virtual integer,
	IdCli_Presencial integer,
	IdCajero integer,
	foreign key (IdCli_Virtual) references Cliente_Virtual
		on update no action 
		on delete no action,
	foreign key (IdCli_Presencial) references Cliente_Presencial
		on update no action 
		on delete no action,
	foreign key (IdCajero) references Cajero_Prod
		on update no action 
		on delete no action,
);

create table Detalle_Producto
(--25
	IdFactura integer not null,
	IdProducto integer not null,
	cantidad integer not null,
	MontoTotal decimal(12,2) not null,
	foreign key (IdFactura) references Factura
		on update cascade 
		on delete cascade,
	foreign key (IdProducto) references Producto
		on update cascade 
		on delete cascade,
	Primary key (IdProducto, IdFactura)
);

create table Combo_Factura
(--26
	IdCombo integer not null,
	IdFactura integer not null,
	cantidad integer not null,
	MontoTotal decimal(12,2) not null,
	foreign key (IdFactura) references Factura
		on update cascade 
		on delete cascade,
	foreign key (IdCombo) references Combo
		on update cascade 
		on delete cascade,
	Primary key (IdCombo, IdFactura)
);

create table Boleto
(--27
	Id integer not null primary key,
	Precio decimal (12,2) not null,
	IdFactura integer not null,
	IdPromocion integer not null,
	IdButaca integer not null,
	IdSala INTEGER NOT NULL,
	foreign key (IdFactura) references Factura
		on update cascade 
		on delete cascade,
	foreign key (IdPromocion) references Promocion
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
-- Insertar salas para la sucursal 1 (Cine Marvel SC)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(1, 20, 1, 1),
(2, 30, 2, 1),
(3, 20, 3, 1),
(4, 30, 4, 1),
(5, 20, 5, 1),
(6, 30, 6, 1);
-- Insertar salas para la sucursal 2 (Cine Marvel LP)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(7, 20, 1, 2),
(8, 30, 2, 2),
(9, 20, 3, 2),
(10, 30, 4, 2),
(11, 20, 5, 2),
(12, 30, 6, 2);
-- Insertar salas para la sucursal 3 (Cine Marvel CBBA)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(13, 22, 1, 3),
(14, 30, 2, 3),
(15, 20, 3, 3),
(16, 30, 4, 3),
(17, 20, 5, 3),
(18, 30, 6, 3);
-- Insertar salas para la sucursal 4 (Cine Marvel TRJ)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(19, 20, 1, 4),
(20, 30, 2, 4),
(21, 20, 3, 4),
(22, 30, 4, 4),
(23, 20, 5, 4),
(24, 30, 6, 4);
-- Insertar salas para la sucursal 5 (Cine Marvel PT)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(25, 20, 1, 5),
(26, 30, 2, 5),
(27, 20, 3, 5),
(28, 30, 4, 5),
(29, 20, 5, 5),
(30, 30, 6, 5);
-- Insertar salas para la sucursal 6 (Cine Marvel OR)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(31, 20, 1, 6),
(32, 30, 2, 6),
(33, 20, 3, 6),
(34, 30, 4, 6),
(35, 20, 5, 6),
(36, 30, 6, 6);
-- Insertar salas para la sucursal 7 (Cine Marvel BEN)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(37, 20, 1, 7),
(38, 30, 2, 7),
(39, 20, 3, 7),
(40, 30, 4, 7),
(41, 20, 5, 7),
(42, 30, 6, 7);
-- Insertar salas para la sucursal 8 (Cine Marvel PND)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(43, 20, 1, 8),
(44, 30, 2, 8),
(45, 20, 3, 8),
(46, 30, 4, 8),
(47, 20, 5, 8),
(48, 30, 6, 8);
-- Insertar salas para la sucursal 9 (Cine Marvel CHQ)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(49, 20, 1, 9),
(50, 30, 2, 9),
(51, 20, 3, 9),
(52, 30, 4, 9),
(53, 20, 5, 9),
(54, 30, 6, 9);
-- Insertar salas para la sucursal 10 (Cine Marvel CBBA 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(55, 20, 1, 10),
(56, 30, 2, 10),
(57, 20, 3, 10),
(58, 30, 4, 10),
(59, 20, 5, 10),
(60, 30, 6, 10);
-- Insertar salas para la sucursal 11 (Cine Marvel SC 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(61, 20, 1, 11),
(62, 30, 2, 11),
(63, 20, 3, 11),
(64, 30, 4, 11),
(65, 20, 5, 11),
(66, 30, 6, 11);
-- Insertar salas para la sucursal 12 (Cine Marvel LP 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(67, 20, 1, 12),
(68, 30, 2, 12),
(69, 20, 3, 12),
(70, 30, 4, 12),
(71, 20, 5, 12),
(72, 30, 6, 12);
-- Insertar salas para la sucursal 13 (Cine Marvel TRJ 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(73, 20, 1, 13),
(74, 30, 2, 13),
(75, 20, 3, 13),
(76, 30, 4, 13),
(77, 20, 5, 13),
(78, 30, 6, 13);
-- Insertar salas para la sucursal 14 (Cine Marvel PT 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(79, 20, 1, 14),
(80, 30, 2, 14),
(81, 20, 3, 14),
(82, 30, 4, 14),
(83, 20, 5, 14),
(84, 30, 6, 14);
-- Insertar salas para la sucursal 15 (Cine Marvel CHQ 2)
INSERT INTO Sala (Id, Capacidad, NroSala, IdSucursal)
VALUES
(85, 20, 1, 15),
(86, 30, 2, 15),
(87, 20, 3, 15),
(88, 30, 4, 15),
(89, 20, 5, 15),
(90, 30, 6, 15);

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
INSERT INTO Lenguaje (Id, Nombre, Subtitulo)
VALUES
(1, 'Español', 'Ninguno'),
(2, 'Inglés', 'Español'),
(3, 'Portugués', 'Español');

SELECT * FROM Pelicula;-- 6. 
-- Insertar películas
INSERT INTO Pelicula (Id, Nombre, Genero, Duracion, Idgenero)
VALUES
(1, 'Deadpool & Wolverine', 'Acción', '01:48:00', 1),
(2, 'Coraline y la puerta secreta', 'Fantasía', '01:40:00', 6),
(3, 'Star Wars III - La venganza de los Sith', 'Ciencia Ficción', '02:20:00', 5),
(4, 'Solo Leveling - Arise from the Shadow', 'Aventura', '01:30:00', 2),
(5, 'El Señor de los Anillos: el retorno del Rey', 'Fantasía', '02:21:00', 6),
(6, 'Spider-Man: A través del Spider-Verso', 'Animación', '01:56:00', 13),
(7, 'Son como niños 2', 'Comedia', '01:41:00', 3),
(8, 'Interestelar', 'Ciencia Ficción', '02:49:00', 5),
(9, 'Un lugar en silencio', 'Terror', '01:30:00', 7),
(10, 'Hasta el último hombre', 'Drama', '02:19:00', 4),
(11, 'Siempre a tu lado', 'Drama', '01:37:00', 4);

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
--Proyeccion solo para las salas de la sucursal 1 (Cine Marvel SC), de otras sucursales aun no han sido añadidas

-- Proyecciones para Lunes
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(1, 'Lunes', '10:00:00', '12:00:00', 1, 1, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D, Sala 1
(2, 'Lunes', '12:00:00', '14:00:00', 2, 2, 2, 1), -- Coraline y la puerta secreta en Español, Formato 4D E-Motion 2D, Sala 2
(3, 'Lunes', '14:00:00', '16:00:00', 3, 3, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D Atmos, Sala 3
(4, 'Lunes', '16:00:00', '18:00:00', 4, 4, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 2D CXC Atmos, Sala 4
(5, 'Lunes', '18:00:00', '20:00:00', 5, 5, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 4D E-Motion 3D, Sala 5
(6, 'Lunes', '20:00:00', '22:00:00', 6, 6, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 3D, Sala 6
(7, 'Lunes', '22:00:00', '00:00:00', 1, 1, 7, 1), -- Son como niños 2 en Español, Formato 2D, Sala 1
(8, 'Lunes', '00:00:00', '02:00:00', 2, 2, 8, 1); -- Interestelar en Español, Formato 4D E-Motion 2D, Sala 2

-- Proyecciones para Martes
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(9, 'Martes', '10:00:00', '12:00:00', 3, 3, 9, 1), -- Un lugar en silencio en Español, Formato 2D Atmos, Sala 3
(10, 'Martes', '12:00:00', '14:00:00', 4, 4, 10, 1), -- Hasta el último hombre en Español, Formato 2D CXC Atmos, Sala 4
(11, 'Martes', '14:00:00', '16:00:00', 5, 5, 1, 1), -- Deadpool & Wolverine en Español, Formato 4D E-Motion 3D, Sala 5
(12, 'Martes', '16:00:00', '18:00:00', 6, 6, 2, 1), -- Coraline y la puerta secreta en Español, Formato 3D, Sala 6
(13, 'Martes', '18:00:00', '20:00:00', 1, 1, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D, Sala 1
(14, 'Martes', '20:00:00', '22:00:00', 2, 2, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 4D E-Motion 2D, Sala 2
(15, 'Martes', '22:00:00', '00:00:00', 3, 3, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D Atmos, Sala 3
(16, 'Martes', '00:00:00', '02:00:00', 4, 4, 6, 2); -- Spider-Man: A través del Spider-Verso en Inglés, Formato 2D CXC Atmos, Sala 4

-- Proyecciones para Miércoles
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(17, 'Miércoles', '10:00:00', '12:00:00', 5, 5, 7, 1), -- Son como niños 2 en Español, Formato 4D E-Motion 3D, Sala 5
(18, 'Miércoles', '12:00:00', '14:00:00', 6, 6, 8, 2), -- Interestelar en Inglés, Formato 3D, Sala 6
(19, 'Miércoles', '14:00:00', '16:00:00', 1, 1, 9, 1), -- Un lugar en silencio en Español, Formato 2D, Sala 1
(20, 'Miércoles', '16:00:00', '18:00:00', 2, 2, 10, 2), -- Hasta el último hombre en Inglés, Formato 4D E-Motion 2D, Sala 2
(21, 'Miércoles', '18:00:00', '20:00:00', 3, 3, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D Atmos, Sala 3
(22, 'Miércoles', '20:00:00', '22:00:00', 4, 4, 2, 1), -- Coraline y la puerta secreta en Español, Formato 2D CXC Atmos, Sala 4
(23, 'Miércoles', '22:00:00', '00:00:00', 5, 5, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 4D E-Motion 3D, Sala 5
(24, 'Miércoles', '00:00:00', '02:00:00', 6, 6, 4, 1); -- Solo Leveling - Arise from the Shadow en Español, Formato 3D, Sala 6

-- Proyecciones para Jueves
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(25, 'Jueves', '10:00:00', '12:00:00', 1, 1, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D, Sala 1
(26, 'Jueves', '12:00:00', '14:00:00', 2, 2, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 4D E-Motion 2D, Sala 2
(27, 'Jueves', '14:00:00', '16:00:00', 3, 3, 7, 1), -- Son como niños 2 en Español, Formato 2D Atmos, Sala 3
(28, 'Jueves', '16:00:00', '18:00:00', 4, 4, 8, 1), -- Interestelar en Español, Formato 2D CXC Atmos, Sala 4
(29, 'Jueves', '18:00:00', '20:00:00', 5, 5, 9, 1), -- Un lugar en silencio en Español, Formato 4D E-Motion 3D, Sala 5
(30, 'Jueves', '20:00:00', '22:00:00', 6, 6, 10, 2), -- Hasta el último hombre en Inglés, Formato 3D, Sala 6
(31, 'Jueves', '22:00:00', '00:00:00', 1, 1, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D, Sala 1
(32, 'Jueves', '00:00:00', '02:00:00', 2, 2, 2, 1); -- Coraline y la puerta secreta en Español, Formato 4D E-Motion 2D, Sala 2

-- Proyecciones para Viernes
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(33, 'Viernes', '10:00:00', '12:00:00', 3, 3, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D Atmos, Sala 3
(34, 'Viernes', '12:00:00', '14:00:00', 4, 4, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 2D CXC Atmos, Sala 4
(35, 'Viernes', '14:00:00', '16:00:00', 5, 5, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 4D E-Motion 3D, Sala 5
(36, 'Viernes', '16:00:00', '18:00:00', 6, 6, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 3D, Sala 6
(37, 'Viernes', '18:00:00', '20:00:00', 1, 1, 7, 1), -- Son como niños 2 en Español, Formato 2D, Sala 1
(38, 'Viernes', '20:00:00', '22:00:00', 2, 2, 8, 1), -- Interestelar en Español, Formato 4D E-Motion 2D, Sala 2
(39, 'Viernes', '22:00:00', '00:00:00', 3, 3, 9, 1), -- Un lugar en silencio en Español, Formato 2D Atmos, Sala 3
(40, 'Viernes', '00:00:00', '02:00:00', 4, 4, 10, 2); -- Hasta el último hombre en Inglés, Formato 2D CXC Atmos, Sala 4

-- Proyecciones para Sábado
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(41, 'Sábado', '10:00:00', '12:00:00', 5, 5, 1, 1), -- Deadpool & Wolverine en Español, Formato 4D E-Motion 3D, Sala 5
(42, 'Sábado', '12:00:00', '14:00:00', 6, 6, 2, 1), -- Coraline y la puerta secreta en Español, Formato 3D, Sala 6
(43, 'Sábado', '14:00:00', '16:00:00', 1, 1, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 2D, Sala 1
(44, 'Sábado', '16:00:00', '18:00:00', 2, 2, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 4D E-Motion 2D, Sala 2
(45, 'Sábado', '18:00:00', '20:00:00', 3, 3, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D Atmos, Sala 3
(46, 'Sábado', '20:00:00', '22:00:00', 4, 4, 6, 2), -- Spider-Man: A través del Spider-Verso en Inglés, Formato 2D CXC Atmos, Sala 4
(47, 'Sábado', '22:00:00', '00:00:00', 5, 5, 7, 1), -- Son como niños 2 en Español, Formato 4D E-Motion 3D, Sala 5
(48, 'Sábado', '00:00:00', '02:00:00', 6, 6, 8, 1); -- Interestelar en Español, Formato 3D, Sala 6

-- Proyecciones para Domingo
INSERT INTO Proyeccion (Id, Dia, HoraIni, HoraFin, IdSala, IdFormato, IdPeli, IdLeng)
VALUES
(49, 'Domingo', '10:00:00', '12:00:00', 1, 1, 9, 1), -- Un lugar en silencio en Español, Formato 2D, Sala 1
(50, 'Domingo', '12:00:00', '14:00:00', 2, 2, 10, 2), -- Hasta el último hombre en Inglés, Formato 4D E-Motion 2D, Sala 2
(51, 'Domingo', '14:00:00', '16:00:00', 3, 3, 1, 1), -- Deadpool & Wolverine en Español, Formato 2D Atmos, Sala 3
(52, 'Domingo', '16:00:00', '18:00:00', 4, 4, 2, 1), -- Coraline y la puerta secreta en Español, Formato 2D CXC Atmos, Sala 4
(53, 'Domingo', '18:00:00', '20:00:00', 5, 5, 3, 2), -- Star Wars: Episodio III - La venganza de los Sith en Inglés, Formato 4D E-Motion 3D, Sala 5
(54, 'Domingo', '20:00:00', '22:00:00', 6, 6, 4, 1), -- Solo Leveling - Arise from the Shadow en Español, Formato 3D, Sala 6
(55, 'Domingo', '22:00:00', '00:00:00', 1, 1, 5, 1), -- El Señor de los Anillos: el retorno del Rey en Español, Formato 2D, Sala 1
(56, 'Domingo', '00:00:00', '02:00:00', 2, 2, 6, 2); -- Spider-Man: A través del Spider-Verso en Inglés, Formato 4D E-Motion 2D, Sala 2

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
(6),----hasta aqui es la maxima de columnas para la capacidad de la sala 5f x 6c= 30 asientos 
(7), 
(8), 
(9), 
(10);

SELECT * FROM Promocion;-- 11. 
INSERT INTO Promocion (Id, FechaIni, FechaFin, Descuento, Descripcion) VALUES 
(1, '2024-09-01', '2024-09-30', 15, 'Descuento del 15% para compras online'),
(2, '2024-09-04', '2024-12-04', 50, 'Entradas a mitad de precio para los cumpleañeros'),
(3, '2024-09-01', '2024-10-31', 50, 'Compra dos entradas al precio de uno solo miercoles'),
(4, '2024-09-10', '2024-12-31', 20, 'Descuento del 20% en entradas para estrenos de películas');

SELECT * FROM Butaca;-- 12. 
--Recomiendo cambiar Disponible por Estado y solo se guarde en Estado D de disponible y O de ocupado, en caso de albergar vips, R de reservado----en disponible esta S de "si"

--solo estan las salas para la sucursal 1 (Cine Marvel SC)
-- Sala 1: Capacidad 20 (4 filas x 5 columnas) fila:A-D por columna:1-5
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
(1, 'Disponible', 'S', 'A', 1, 1),
(2, 'Disponible', 'S', 'A', 2, 1),
(3, 'Disponible', 'S', 'A', 3, 1),
(4, 'Disponible', 'S', 'A', 4, 1),
(5, 'Disponible', 'S', 'A', 5, 1),
(6, 'Disponible', 'S', 'B', 1, 1),
(7, 'Disponible', 'S', 'B', 2, 1),
(8, 'Disponible', 'S', 'B', 3, 1),
(9, 'Disponible', 'S', 'B', 4, 1),
(10, 'Disponible', 'S', 'B', 5, 1),
(11, 'Disponible', 'S', 'C', 1, 1),
(12, 'Disponible', 'S', 'C', 2, 1),
(13, 'Disponible', 'S', 'C', 3, 1),
(14, 'Disponible', 'S', 'C', 4, 1),
(15, 'Disponible', 'S', 'C', 5, 1),
(16, 'Disponible', 'S', 'D', 1, 1),
(17, 'Disponible', 'S', 'D', 2, 1),
(18, 'Disponible', 'S', 'D', 3, 1),
(19, 'Disponible', 'S', 'D', 4, 1),
(20, 'Disponible', 'S', 'D', 5, 1);

-- Sala 2: Capacidad 30 (5 filas x 6 columnas) fila:A-E por columna:1-6
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
(21, 'Disponible', 'S', 'A', 1, 2),
(22, 'Disponible', 'S', 'A', 2, 2),
(23, 'Disponible', 'S', 'A', 3, 2),
(24, 'Disponible', 'S', 'A', 4, 2),
(25, 'Disponible', 'S', 'A', 5, 2),
(26, 'Disponible', 'S', 'A', 6, 2),
(27, 'Disponible', 'S', 'B', 1, 2),
(28, 'Disponible', 'S', 'B', 2, 2),
(29, 'Disponible', 'S', 'B', 3, 2),
(30, 'Disponible', 'S', 'B', 4, 2),
(31, 'Disponible', 'S', 'B', 5, 2),
(32, 'Disponible', 'S', 'B', 6, 2),
(33, 'Disponible', 'S', 'C', 1, 2),
(34, 'Disponible', 'S', 'C', 2, 2),
(35, 'Disponible', 'S', 'C', 3, 2),
(36, 'Disponible', 'S', 'C', 4, 2),
(37, 'Disponible', 'S', 'C', 5, 2),
(38, 'Disponible', 'S', 'C', 6, 2),
(39, 'Disponible', 'S', 'D', 1, 2),
(40, 'Disponible', 'S', 'D', 2, 2),
(41, 'Disponible', 'S', 'D', 3, 2),
(42, 'Disponible', 'S', 'D', 4, 2),
(43, 'Disponible', 'S', 'D', 5, 2),
(44, 'Disponible', 'S', 'D', 6, 2),
(45, 'Disponible', 'S', 'E', 1, 2),
(46, 'Disponible', 'S', 'E', 2, 2),
(47, 'Disponible', 'S', 'E', 3, 2),
(48, 'Disponible', 'S', 'E', 4, 2),
(49, 'Disponible', 'S', 'E', 5, 2),
(50, 'Disponible', 'S', 'E', 6, 2);

-- Sala 3: Capacidad 20 (4 filas x 5 columnas)
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
(51, 'Disponible', 'S', 'A', 1, 3),
(52, 'Disponible', 'S', 'A', 2, 3),
(53, 'Disponible', 'S', 'A', 3, 3),
(54, 'Disponible', 'S', 'A', 4, 3),
(55, 'Disponible', 'S', 'A', 5, 3),
(56, 'Disponible', 'S', 'B', 1, 3),
(57, 'Disponible', 'S', 'B', 2, 3),
(58, 'Disponible', 'S', 'B', 3, 3),
(59, 'Disponible', 'S', 'B', 4, 3),
(60, 'Disponible', 'S', 'B', 5, 3),
(61, 'Disponible', 'S', 'C', 1, 3),
(62, 'Disponible', 'S', 'C', 2, 3),
(63, 'Disponible', 'S', 'C', 3, 3),
(64, 'Disponible', 'S', 'C', 4, 3),
(65, 'Disponible', 'S', 'C', 5, 3),
(66, 'Disponible', 'S', 'D', 1, 3),
(67, 'Disponible', 'S', 'D', 2, 3),
(68, 'Disponible', 'S', 'D', 3, 3),
(69, 'Disponible', 'S', 'D', 4, 3),
(70, 'Disponible', 'S', 'D', 5, 3);

-- Sala 4: Capacidad 30 (5 filas x 6 columnas)
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
(71, 'Disponible', 'S', 'A', 1, 4),
(72, 'Disponible', 'S', 'A', 2, 4),
(73, 'Disponible', 'S', 'A', 3, 4),
(74, 'Disponible', 'S', 'A', 4, 4),
(75, 'Disponible', 'S', 'A', 5, 4),
(76, 'Disponible', 'S', 'A', 6, 4),
(77, 'Disponible', 'S', 'B', 1, 4),
(78, 'Disponible', 'S', 'B', 2, 4),
(79, 'Disponible', 'S', 'B', 3, 4),
(80, 'Disponible', 'S', 'B', 4, 4),
(81, 'Disponible', 'S', 'B', 5, 4),
(82, 'Disponible', 'S', 'B', 6, 4),
(83, 'Disponible', 'S', 'C', 1, 4),
(84, 'Disponible', 'S', 'C', 2, 4),
(85, 'Disponible', 'S', 'C', 3, 4),
(86, 'Disponible', 'S', 'C', 4, 4),
(87, 'Disponible', 'S', 'C', 5, 4),
(88, 'Disponible', 'S', 'C', 6, 4),
(89, 'Disponible', 'S', 'D', 1, 4),
(90, 'Disponible', 'S', 'D', 2, 4),
(91, 'Disponible', 'S', 'D', 3, 4),
(92, 'Disponible', 'S', 'D', 4, 4),
(93, 'Disponible', 'S', 'D', 5, 4),
(94, 'Disponible', 'S', 'D', 6, 4),
(95, 'Disponible', 'S', 'E', 1, 4),
(96, 'Disponible', 'S', 'E', 2, 4),
(97, 'Disponible', 'S', 'E', 3, 4),
(98, 'Disponible', 'S', 'E', 4, 4),
(99, 'Disponible', 'S', 'E', 5, 4),
(100, 'Disponible', 'S', 'E', 6, 4);

-- Sala 5: Capacidad 20 (4 filas x 5 columnas)
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
(101, 'Disponible', 'S', 'A', 1, 5),
(102, 'Disponible', 'S', 'A', 2, 5),
(103, 'Disponible', 'S', 'A', 3, 5),
(104, 'Disponible', 'S', 'A', 4, 5),
(105, 'Disponible', 'S', 'A', 5, 5),
(106, 'Disponible', 'S', 'B', 1, 5),
(107, 'Disponible', 'S', 'B', 2, 5),
(108, 'Disponible', 'S', 'B', 3, 5),
(109, 'Disponible', 'S', 'B', 4, 5),
(110, 'Disponible', 'S', 'B', 5, 5),
(111, 'Disponible', 'S', 'C', 1, 5),
(112, 'Disponible', 'S', 'C', 2, 5),
(113, 'Disponible', 'S', 'C', 3, 5),
(114, 'Disponible', 'S', 'C', 4, 5),
(115, 'Disponible', 'S', 'C', 5, 5),
(116, 'Disponible', 'S', 'D', 1, 5),
(117, 'Disponible', 'S', 'D', 2, 5),
(118, 'Disponible', 'S', 'D', 3, 5),
(119, 'Disponible', 'S', 'D', 4, 5),
(120, 'Disponible', 'S', 'D', 5, 5);

-- Sala 6: Capacidad 30 (5 filas x 6 columnas)
INSERT INTO Butaca (Id, Estado, Disponible, IdFila, IdColumna, IdSala) VALUES
-- Fila A
(121, 'Disponible', 'S', 'A', 1, 6),
(122, 'Disponible', 'S', 'A', 2, 6),
(123, 'Disponible', 'S', 'A', 3, 6),
(124, 'Disponible', 'S', 'A', 4, 6),
(125, 'Disponible', 'S', 'A', 5, 6),
(126, 'Disponible', 'S', 'A', 6, 6),
-- Fila B
(127, 'Disponible', 'S', 'B', 1, 6),
(128, 'Disponible', 'S', 'B', 2, 6),
(129, 'Disponible', 'S', 'B', 3, 6),
(130, 'Disponible', 'S', 'B', 4, 6),
(131, 'Disponible', 'S', 'B', 5, 6),
(132, 'Disponible', 'S', 'B', 6, 6),
-- Fila C
(133, 'Disponible', 'S', 'C', 1, 6),
(134, 'Disponible', 'S', 'C', 2, 6),
(135, 'Disponible', 'S', 'C', 3, 6),
(136, 'Disponible', 'S', 'C', 4, 6),
(137, 'Disponible', 'S', 'C', 5, 6),
(138, 'Disponible', 'S', 'C', 6, 6),
-- Fila D
(139, 'Disponible', 'S', 'D', 1, 6),
(140, 'Disponible', 'S', 'D', 2, 6),
(141, 'Disponible', 'S', 'D', 3, 6),
(142, 'Disponible', 'S', 'D', 4, 6),
(143, 'Disponible', 'S', 'D', 5, 6),
(144, 'Disponible', 'S', 'D', 6, 6),
-- Fila E
(145, 'Disponible', 'S', 'E', 1, 6),
(146, 'Disponible', 'S', 'E', 2, 6),
(147, 'Disponible', 'S', 'E', 3, 6),
(148, 'Disponible', 'S', 'E', 4, 6),
(149, 'Disponible', 'S', 'E', 5, 6),
(150, 'Disponible', 'S', 'E', 6, 6);
--OJO estas 6 salas solo pertencen a la sucursal 1 (Cine Marvel SC)

SELECT * FROM Persona;-- 13. 
-- Insertar datos en la tabla Persona--hay que mejorar esto con respecto de que una persona pueda ser tanto cliente como cajero(empleado o trabajador del cine)
INSERT INTO Persona (Id, Nombre, Apellido, Correo, Contraseña, tipo) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '123456', 'CL'), -- Cliente
(2, 'Ana', 'García', 'ana.garcia@example.com', 'abcdef', 'CL'), -- Cliente
(3, 'Luis', 'Cruz', 'luis.cruz@example.com', 'password', 'CL'), -- Cliente
(4, 'Maria', 'Flores', 'maria.flores@example.com', 'qwerty', 'CL'), -- Cliente
(5, 'Carlos', 'Martínez', 'carlos.martinez@example.com', '123abc', 'CL'), -- Cliente
(6, 'Sofia', 'Rivas', 'sofia.rivas@example.com', '789xyz', 'CL'), -- Cliente
(7, 'Jorge', 'Morales', 'jorge.morales@example.com', 'admin01', 'CL'), -- Cliente
(8, 'Laura', 'Torres', 'laura.torres@example.com', 'secure', 'CL'), -- Cliente
(9, 'Ricardo', 'Vargas', 'ricardo.vargas@example.com', 'myPass', 'CL'), -- Cliente
(10, 'Verónica', 'Salazar', 'veronica.salazar@example.com', 'letmein', 'CL'), -- Cliente
(11, 'Fernando', 'Hernández', 'fernando.hernandez@example.com', 'iloveyou', 'CL'), -- Cliente
(12, 'Gabriela', 'Paredes', 'gabriela.paredes@example.com', '1234567', 'CL'), -- Cliente
(13, 'Julio', 'Benítez', 'julio.benitez@example.com', 'pass123', 'CL'), -- Cliente
(14, 'Natalia', 'Sánchez', 'natalia.sanchez@example.com', 'qweasd', 'CL'), -- Cliente
(15, 'Eduardo', 'Jiménez', 'eduardo.jimenez@example.com', 'admin123', 'CL'); -- Cliente

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
INSERT INTO Cliente_Presencial (Id, Ci, Nit) VALUES
(1, 123456, 1234), -- Cliente 1
(2, 234567, 2345), -- Cliente 2
(3, 345678, 3456), -- Cliente 3
(4, 456789, 4567), -- Cliente 4
(5, 567890, 5678), -- Cliente 5
(6, 678901, 6789), -- Cliente 6
(7, 789014, 7890); -- Cliente 7

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
INSERT INTO Producto (Id, Nombre, Fecha_Vencimiento, IdCajero, IdCategoria) VALUES
(1, 'Coca-Cola pequeño', '2024-12-31', 1, 2),  -- Gaseosa
(2, 'Coca-Cola mediano', '2024-12-31', 1, 2),  -- Gaseosa
(3, 'Coca-Cola grande', '2024-12-31', 1, 2),  -- Gaseosa
(4, 'Pepsi pequeño', '2024-12-31', 1, 2),      -- Gaseosa
(5, 'Pepsi mediano', '2024-12-31', 1, 2),      -- Gaseosa
(6, 'Pepsi grande', '2024-12-31', 1, 2),      -- Gaseosa
(7, 'Pipoca pequeña', '2024-10-31', 10, 4),  -- Snack
(8, 'Pipoca mediana', '2024-10-31', 10, 4),  -- Snack
(9, 'Pipoca grande', '2024-10-31', 10, 4),  -- Snack
(10, 'Nachos con Queso', '2024-10-31', 10, 4),  -- Snack
(11, 'Chocolate Crunch', '2024-11-15', 5, 3), -- Confitería
(12, 'Gominolas', '2024-11-30', 5, 3),       -- Confitería
(13, 'Agua Mineral', '2024-12-31', 8, 1),    -- Bebida
(14, 'Jugo de Naranja', '2024-11-30', 8, 1);  -- Bebida

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
SELECT * FROM Factura;-- 24. 
-- Insertar datos en la tabla Factura
INSERT INTO Factura (Id, CodigoQR, Fecha, IdCli_Virtual, IdCli_Presencial, IdCajero)
VALUES
(1, 'QR001', '2024-09-01', 1, NULL, NULL), -- Factura para cliente virtual con Id 1
(2, 'QR002', '2024-09-02', NULL, 1, 1),    -- Factura para cliente presencial con Id 1, procesada por el cajero con IdPersona 1
(3, 'QR003', '2024-09-03', NULL, 2, 5),    -- Factura para cliente presencial con Id 2, procesada por el cajero con IdPersona 5
(4, 'QR004', '2024-09-04', NULL, 3, 8),    -- Factura para cliente presencial con Id 3, procesada por el cajero con IdPersona 8
(5, 'QR005', '2024-09-05', NULL, 4, 10),    -- Factura para cliente presencial con Id 4, procesada por el cajero con IdPersona 10
(6, 'QR006', '2024-09-06', 2, NULL, NULL),    -- Factura para cliente virtual con Id 2
(7, 'QR007', '2024-09-07', 3, NULL, NULL),    -- Factura para cliente virtual con Id 3 
(8, 'QR008', '2024-09-08', 4, NULL, NULL),    -- Factura para cliente virtual con Id 4
(9, 'QR009', '2024-09-09', NULL, 5, 1),    -- Factura para cliente presencial con Id 5, procesada por el cajero con IdPersona 1
(10, 'QR010', '2024-09-10', 5, NULL, NULL);  -- Factura para cliente virtual con Id 5

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
INSERT INTO Combo_Factura (IdCombo, IdFactura, cantidad, MontoTotal)
VALUES
(1, 1, 2, 130.00),  -- Combo 1 en Factura 1, 2 unidades
(2, 1, 1, 40.00),  -- Combo 2 en Factura 1, 1 unidad
(3, 2, 3, 96.00),  -- Combo 3 en Factura 2, 3 unidades
(4, 2, 3, 195.00),  -- Combo 4 en Factura 2, 3 unidades
(5, 3, 1, 40.00),  -- Combo 5 en Factura 3, 1 unidades
(1, 4, 3, 195.00),  -- Combo 1 en Factura 4, 3 unidades
(2, 5, 1, 40.00),  -- Combo 2 en Factura 5, 1 unidades
(3, 6, 3, 96.00),  -- Combo 3 en Factura 6, 3 unidades
(4, 7, 3, 195.00),  -- Combo 4 en Factura 7, 3 unidades
(5, 7, 1, 40.00);  -- Combo 5 en Factura 7, 1 unidad

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

