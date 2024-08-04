-- Public_Queries for GitHub
-- # I - Necesito crear una BBDD 
CREATE DATABASE NuovoDataBase
GO

-- # II.1
USE NuovoDataBase
CREATE TABLE Clientes(
idCliente int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
Nombre varchar(50) NOT NULL,
Apellido varchar(50) NOT NULL,
Fnacimiento date NOT NULL,
Domicilio varchar(50) NOT NULL,
idPais char(3) NOT NULL,
Telefono varchar(12) NULL,
Email varchar(30) NOT NULL,
Observaciones varchar(1000) NULL,
FechaAlta datetime NOT NULL)
GO
SELECT * FROM Clientes

-- # II.2
CREATE TABLE Record(
idRecord int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
FechaRecord date NOT NULL,
Observaciones varchar(1000) NULL)
GO
SELECT * FROM Record

-- # II.3
CREATE TABLE RecordCliente(
idRecord int NOT NULL,
idCliente int NOT NULL,
idCampania int NOT NULL,
PRIMARY KEY (idRecord, idCliente, idCampania))
GO
SELECT * FROM RecordCliente

-- # II.4
CREATE TABLE Pais(
idPais char(3) NOT NULL PRIMARY KEY,
NombrePais varchar(100) NOT NULL)
GO
SELECT * FROM Pais

-- # II.5
CREATE TABLE HoraCaptacion(
idHCaptacion int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
FechaCaptacion date NOT NULL,
EstadoCaptacion smallint NOT NULL,
Observaciones varchar(1000) NULL)
GO
SELECT * FROM HoraCaptacion

-- # II.6
CREATE TABLE HoraCapClienteCampania(
idHCaptacion int NOT NULL, 
idCliente int NOT NULL,
idCampania int NOT NULL,
PRIMARY KEY (idHCaptacion, idCliente, idCampania))
GO
SELECT * FROM HoraCapClienteCampania

-- # II.7
CREATE TABLE HorarioEstado(
idEstado smallint NOT NULL IDENTITY(1, 1) PRIMARY KEY,
Descripcion varchar(50) NOT NULL)
GO
SELECT * FROM HorarioEstado

-- # II.8
CREATE TABLE Producto(
idProducto int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
Producto varchar(100) NOT NULL)
SELECT * FROM Producto

-- # II.9
CREATE TABLE Compra(
idCompras int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
Concepto int NOT NULL,
Fecha datetime NOT NULL,
Monto money NOT NULL,
Observaciones varchar(1000) NULL)
SELECT * FROM Compra

-- # II.10
CREATE TABLE CompraCliente(
idCompras int NOT NULL,
idCliente int NOT NULL,
idHCaptacion int NOT NULL,
PRIMARY KEY (idCompras , idCliente , idHCaptacion))
SELECT * FROM CompraCliente


-- # II.11
CREATE TABLE Campania(
idCampania int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
NombreCampania varchar(50) NOT NULL)
SELECT * FROM Campania

-- # II.12
CREATE TABLE CampaniaProducto(
idCampania int NOT NULL, 
idProducto int NOT NULL,
Descripcion varchar (100) NOT NULL
PRIMARY KEY (idCampania, idProducto))
GO
SELECT * FROM CampaniaProducto

-- # II.13
CREATE TABLE ConceptoCompra(
idConcepto int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
Concepto varchar(100) NOT NULL)
GO
SELECT * FROM ConceptoCompra

-- III - Relaciones de 13 tablas
-- III - 1. Cliente con País a través del IdPais
ALTER TABLE Clientes
ADD CONSTRAINT FK_idPais FOREIGN KEY (idPais) REFERENCES Pais (idPais)
GO

-- III - 2. ConceptoCompra con Compra a través de IdConcepto y Concepto
ALTER TABLE Compra
ADD CONSTRAINT FK_idConcepto FOREIGN KEY (Concepto) REFERENCES ConceptoCompra (idConcepto)
GO

-- III - 3 HorarioEstado con HoraCaptacion a través de IdEstado y EstadoCaptacion
ALTER TABLE HoraCaptacion
ADD CONSTRAINT FK_idEstado FOREIGN KEY (EstadoCaptacion) REFERENCES HorarioEstado (idEstado)
GO

-- III - 4 Compra con CompraCliente a través de IdCompras
ALTER TABLE CompraCliente
ADD CONSTRAINT FK_idCompras FOREIGN KEY (IdCompras) REFERENCES Compra (IdCompras)
GO

-- III - 5 Cliente con CompraCliente a través de IdCliente
ALTER TABLE CompraCliente
ADD CONSTRAINT FK_idCliente FOREIGN KEY (idCliente) REFERENCES Clientes (IdCliente)
GO

-- III 6 + 7 + 8
-- 6 HoraCapClienteCampania con HoraCaptacion a través de IdHCaptacion
-- 7 HoraCapClienteCampania con Cliente a través de IdCliente
-- 8 HoraCapClienteCampania con Campania a través de IdCampania
ALTER TABLE HoraCapClienteCampania
ADD CONSTRAINT FK_idHCaptacion FOREIGN KEY (idHCaptacion) REFERENCES HoraCaptacion (idHCaptacion),
	CONSTRAINT FK_idCliente_Clientes FOREIGN KEY (idCliente) REFERENCES Clientes (idCliente),
	CONSTRAINT FK_idCampania FOREIGN KEY (idCampania) REFERENCES Campania (idCampania);
GO

-- III 9 + 10
-- 9 CampaniaProducto con Producto a través de IdProducto
-- 10 CampaniaProducto con Campania a través de IdCampania
ALTER TABLE CampaniaProducto
ADD CONSTRAINT FK_idProducto FOREIGN KEY (idProducto) REFERENCES Producto (idProducto),
	CONSTRAINT FK_idCampania_Campania FOREIGN KEY (idCampania) REFERENCES Campania (idCampania);
GO

-- III 11 + 12 + 13
-- 11 Record con RecordCliente a través de IdRecord
-- 12 RecordCliente con Cliente a través de IdCliente
-- 13 RecordCliente con Campania a través de IdCampania
ALTER TABLE RecordCliente
ADD CONSTRAINT FK_idRecord FOREIGN KEY (IdRecord) REFERENCES Record (IdRecord),
	CONSTRAINT FK_idCliente_RecordCliente FOREIGN KEY (idCliente) REFERENCES Clientes (idCliente),
	CONSTRAINT FK_idCampania_RecordCliente FOREIGN KEY (idCampania) REFERENCES Campania (idCampania);
GO

-- IV - A 
INSERT INTO Pais (IdPais, NombrePais)
VALUES  
('IND', 'India'),
('USA', 'Estados Unidos'),
('ESP', 'España'),
('GRC', 'Grecia'),
('MEX', 'México'),
('BRA', 'Brasil'),
('DEU', 'Alemania');
GO
SELECT * FROM Pais

INSERT INTO Clientes (Nombre, Apellido, Fnacimiento, Domicilio, idPais, Telefono, Email, Observaciones, FechaAlta)
VALUES  
('Raul' , 'Gonzales' , '1986/05/25' , 'Gualtatas 2526' , 'ESP', '6644859632' , 'donraul@gmail.es' , 'No hay observacion', '2024/01/05 00:00:00' ),
('James' , 'Nicole' , '1990/03/02' , 'Oniell jack 2568 ' , 'USA', '1254685632' , 'wuarden@green.us' , 'No hay observacion', '2024/01/06 00:01:00' ),
('Marta' , 'Perez' , '1995/05/03' , 'Brasilia 25 ' , 'BRA', '564322553' , 'mPerezbra@getmail.com' , 'No hay observacion', '2024/02/01 00:00:00' ),
('Claudio' , 'Ramirez' , '1984/08/02' , 'Cheguan 225 ' , 'ESP', '66852125' , 'clauRami@gmail.es' , 'No hay observacion', '2024/02/01 00:02:02' ),
('Markuis' , 'Papadopulus' , '1982/02/06' , 'Grikindier 223 ' , 'GRC', '2548542355' , 'papadopulusm@gmail.com' , 'Es griego', '2024/02/01 00:06:00' ),
('Carlos' , 'Trebor' , '1966/05/03' , 'Pedro pastor 2 ' , 'MEX', '135852133' , 'Carlitos@gmail.ue' , 'No hay observacion', '2024/02/01 00:00:00' ),
('Otto' , 'Von Kunstmann' , '1975/09/01' , 'Otigger str 3' , 'DEU', '6582216335' , 'elaleman@aleman.com' , 'Es Aleman', '2024/02/01 00:08:00' ),
('Uit' , 'Tlinnlnie' , '1977/05/05' , 'Intrati 22' , 'IND', '1325865523' , 'uit@guit.in' , 'Es Indio', '2024/02/06 00:00:00' );
GO
SELECT * FROM Clientes

INSERT INTO HorarioEstado (Descripcion)
VALUES  
('Prime tarde-noche'),
('Valle Mediatarde, media mañana'),
('Breakfast antes de las 10 AM'),
('Nocturno despues de las 00:00');
GO
SELECT * FROM HorarioEstado

INSERT INTO HoraCaptacion (FechaCaptacion, EstadoCaptacion, Observaciones)
VALUES  
('2024/01/05', '1', 'Lead'),
('2024/01/05', '2', 'Lead'),
('2024/02/01', '1', 'Cliente'),
('2024/02/01', '3', 'Prospecto'),
('2024/02/01', '1', 'Lead');
GO
SELECT * FROM HoraCaptacion

INSERT INTO Campania (NombreCampania)
VALUES  
('Producto Estrella 1'),
('Producto Estrella 2'),
('Producto Estrella 3');
GO
SELECT * FROM Campania

INSERT INTO ConceptoCompra (Concepto)
VALUES  
('Compra producto Estrella 1'),
('Compra producto Estrella 2'),
('Compra producto Estrella 3');
GO
SELECT * FROM ConceptoCompra

INSERT INTO Compra (Concepto, Fecha, Monto, Observaciones)
VALUES  
('1', '2024/01/02 00:00:00', '5000.0000', 'Comprador de productos estrella 1'),
('2', '2024/01/02 00:00:00', '3500.0000', 'Comprador de productos estrella 2'),
('3', '2024/01/03 00:00:00', '5000.0000', 'Comprador de productos estrella 1');
GO
SELECT * FROM Compra

SELECT idCompras FROM Compra
SELECT idCliente FROM Clientes
SELECT idHCaptacion FROM HoraCaptacion
INSERT INTO CompraCliente (IdCompras, IdCliente, idHCaptacion)
VALUES  
('1', '1', '1'), 
('2', '2', '2'), 
('3', '3', '3');
GO
SELECT * FROM CompraCliente

-- B - Edición de tablas
-- # IV.B.1 
INSERT INTO HoraCaptacion (FechaCaptacion, EstadoCaptacion, Observaciones)
VALUES ('2024/01/05 10:00', '1', 'DESCONOCIDO')
GO
SELECT * FROM HoraCaptacion

-- # IV.B.2
-- idhCaptacion: Deberás colocar el idHCaptacion autogenerado en la tabla HoraCaptacion
SELECT * FROM HoraCaptacion
SELECT idCliente FROM Clientes
SELECT idCampania FROM Campania
INSERT INTO HoraCapClienteCampania (IdHCaptacion, IdCliente, IdCampania)
VALUES ('6', '4', '1');
GO
SELECT * FROM HoraCapClienteCampania

-- # V
-- # V.1
SELECT * FROM Clientes

-- # V.2
SELECT Nombre FROM Clientes

-- # V.3 
WITH LosTresPrimeroRegistros AS (
SELECT TOP 3 * FROM Clientes ORDER BY IdCliente)
SELECT * FROM LosTresPrimeroRegistros ORDER BY Fnacimiento ASC;
GO

-- # V.4
SELECT DISTINCT IdPais FROM Clientes

-- # V.5
SELECT * FROM Clientes
UPDATE Clientes SET Email = '200@gmail.es' WHERE IdCliente = 1;
GO

-- # V.6
SELECT * FROM Compra
SELECT AVG(Monto) AS promedioMontoCompra FROM Compra;

-- # V.7
SELECT * FROM HoraCaptacion
SELECT * FROM HoraCaptacion WHERE FechaCaptacion BETWEEN '2024-01-01' AND '2024-01-30';
SELECT * FROM HoraCaptacion WHERE FechaCaptacion NOT BETWEEN '2024-01-01' AND '2024-01-30';

-- # V.8
SELECT * FROM Clientes
DECLARE @idpais CHAR(3) 
SET @idpais = 'ESP'
IF @idpais = 'ESP'
BEGIN
SELECT * FROM Clientes WHERE idPais=@idpais
END
ELSE 
BEGIN
print 'No se cumple la condicion'
END
GO

-- # V.9
SELECT * FROM Pais
SELECT *,(CASE 
	WHEN idPais = 'BRA' THEN 'America'
	WHEN idPais = 'MEX' THEN 'America'
	WHEN idPais = 'USA' THEN 'America'
	WHEN idPais = 'DEU' THEN 'Europa'
	WHEN idPais = 'ESP' THEN 'Europa'
	WHEN idPais = 'GRC' THEN 'Europa'
	WHEN idPais = 'IND' THEN 'Asia'
	END) AS Continente FROM Pais;

-- # V.10
SELECT * FROM Clientes
CREATE proc Nuevo_cliente(
			@dni varchar(20),
			@nombre varchar(50),
			@apellido varchar(50),
			@fnacimiento date,
			@domicilio varchar(50),
			@idpais char(3),
			@tel varchar(12),
			@email varchar(30),
			@observacion varchar(1000)
			)
as
IF NOT EXISTS(SELECT * from Clientes WHERE dni=@dni)
BEGIN
	INSERT INTO Clientes (dni,Nombre,Apellido,Fnacimiento,Domicilio,idPais,Telefono,Email,Observaciones)
	VALUES (@dni,@nombre,@apellido,@fnacimiento,@domicilio,@idpais,@tel,@email,@observacion)
	print 'El cliente se agregó correctamente'
	return
END;
GO

EXEC Nuevo_cliente '2351365', 'Raúl','Stuart','19850521','Las regasta 25','ESP','655821547','Raul@krokimail.com',''
GO

-- Resume:
SELECT * FROM Campania
SELECT * FROM CampaniaProducto
SELECT * FROM Clientes
SELECT * FROM Compra
SELECT * FROM CompraCliente
SELECT * FROM ConceptoCompra
SELECT * FROM HoraCapClienteCampania
SELECT * FROM HoraCaptacion
SELECT * FROM HorarioEstado
SELECT * FROM Pais
SELECT * FROM Producto
SELECT * FROM Record
SELECT * FROM RecordCliente
