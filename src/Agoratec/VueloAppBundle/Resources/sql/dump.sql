--USUARIOS
----------

--DROP TABLE app.usuarios;

CREATE TABLE app.usuarios(
	uid SERIAL PRIMARY KEY,
	login varchar(30) UNIQUE NOT NULL,
	nombre varchar(30),
	apellido varchar(30),
	fecha_nac date	
);

INSERT INTO app.usuarios(login,nombre,apellido)
VALUES('test1','testuno','uno');

INSERT INTO app.usuarios(login,nombre,apellido)
VALUES('test2','testdos','dos');

--AVIONES
---------

--DROP TABLE app.aviones;

CREATE TABLE app.aviones(
	avid SERIAL PRIMARY KEY,
	marca varchar(80),
	modelo varchar(80),
	usuario_id integer REFERENCES app.usuarios(uid)
);

INSERT INTO app.aviones(marca,modelo,usuario_id)
VALUES('marca1','modelo2',1);

INSERT INTO app.aviones(marca,modelo,usuario_id)
VALUES('marca1','modelo1',1);

INSERT INTO app.aviones(marca,modelo,usuario_id)
VALUES('marca2','modelo1',2);

--POSICIONES
------------

--DROP TABLE app.avion_posicion;

CREATE TABLE app.avion_posicion(
	avion integer REFERENCES app.aviones(avid),
	orientacion smallint CHECK(orientacion>=0 AND orientacion<360),
	velocidad numeric(5,2) CHECK(velocidad>=0 AND velocidad<112),
	altitud smallint  CHECK(altitud<13000),
	posicion GEOGRAPHY(POINT,4326) NOT NULL,
	hora timestamp,
	CONSTRAINT pk_avion_posicion PRIMARY KEY(avion,hora)
);

INSERT INTO app.avion_posicion(avion,orientacion,velocidad,altitud,posicion,hora)
VALUES(1,210,40,2000,ST_GeographyFromText('SRID=4326;POINT(-110 30)'), now());

INSERT INTO app.avion_posicion(avion,orientacion,velocidad,altitud,posicion,hora)
VALUES(2,100,20,1000,ST_GeographyFromText('SRID=4326;POINT(39 -6)'), now());

INSERT INTO app.avion_posicion(avion,orientacion,velocidad,altitud,posicion,hora)
VALUES(3,10,14,200,ST_GeographyFromText('SRID=4326;POINT(40 -5)'), now());

--AEROPUERTOS
-------------

--DROP TABLE app.aeropuertos;

CREATE TABLE app.aeropuertos(
	aid SERIAL PRIMARY KEY,
	nombre varchar(30),
	tipo char(1) CHECK(tipo='O' OR tipo='A' OR tipo='Z'),
	posicion GEOGRAPHY(POINT,4326)
);

INSERT INTO app.aeropuertos(nombre,tipo,posicion)
VALUES('Caceres','A',ST_GeographyFromText('SRID=4326;POINT(41 -4)'));

INSERT INTO app.aeropuertos(nombre,tipo,posicion)
VALUES('Badajoz','O',ST_GeographyFromText('SRID=4326;POINT(38 -6)'));

--ZONAS
-------

--DROP TABLE app.zonas;

CREATE TABLE app.zonas(
	zid SERIAL PRIMARY KEY,
	nombre varchar(30),
	tipo char(1) CHECK(tipo='P' OR tipo='W' OR tipo='V'),
	area GEOGRAPHY(POLYGON,4326)
);

INSERT INTO app.zonas(nombre,tipo,area)
VALUES('Extremadura','W',ST_GeographyFromText('SRID=4326;POLYGON((0 0, 0 10, 10 10, 10 0, 0 0))'));

INSERT INTO app.zonas(nombre,tipo,area)
VALUES('Extremadura2','W',ST_GeographyFromText('SRID=4326;POLYGON((38 5, 38 6, 39 6, 39 5,38 5))'));

--hay que cerrar los puntos en polygon

--Ejemplo de consulta

SELECT zid,nombre,tipo,ST_AsText(area)
FROM app.zonas

