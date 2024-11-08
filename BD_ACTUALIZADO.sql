CREATE DATABASE restauranteML;
USE restauranteML;

CREATE TABLE persona (
  id INT AUTO_INCREMENT PRIMARY KEY,
  primer_nombre VARCHAR(50) NOT NULL,
  segundo_nombre VARCHAR(50),
  primer_apellido VARCHAR(50) NOT NULL,
  segundo_apellido VARCHAR(50),
  telefono VARCHAR(15),
  email VARCHAR(100) 
);
INSERT INTO persona (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, email) VALUES 
('Sabina', 'Graciela', 'Leonardo', 'Mucun', '43100916', 'sabina@gmail.com'),
('Josefina', 'Graciela', 'Churunel', 'Lopel', NULL, 'josefina@gmail.com'),
('Edyn', 'Leonardo', 'Mucun', 'Churunel', '55363050', 'edyn@gmail.com');

CREATE TABLE rol (
  id_rol INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO rol (nombre) values
('Admin'), 
('Mesero'),
('Cocinero');

CREATE TABLE permisos (
    id_permiso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NOT NULL
);

INSERT INTO permisos (nombre, descripcion) VALUES
('manage-users', 'Permite gestionar usuarios'),
('view-reports', 'Permite ver informes'),
('edit-settings', 'Permite editar configuraciones');

CREATE TABLE rol_permisos (
    rol_id INT NOT NULL,
    permiso_id INT NOT NULL,
    PRIMARY KEY (rol_id, permiso_id),
    FOREIGN KEY (rol_id) REFERENCES rol(id_rol),
    FOREIGN KEY (permiso_id) REFERENCES permisos(id_permiso)
);

INSERT INTO rol_permisos (rol_id, permiso_id) VALUES
(1, 1), -- Asignar el permiso 'manage-users' al rol con id 1
(1, 2), -- Asignar el permiso 'view-reports' al rol con id 1
(2, 3); -- Asignar el permiso 'edit-settings' al rol con id 2


CREATE TABLE estado_usuario (
  id_estado INT AUTO_INCREMENT PRIMARY KEY,
  estado BOOLEAN NOT NULL, 
  descripcion VARCHAR(25)
);

INSERT INTO estado_usuario (estado, descripcion) values
(1, 'Activo'), 
(2, 'Inactivo');

CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  id_persona INT NOT NULL, 
  rol_id INT NOT NULL,
  estado_id INT NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_persona) REFERENCES persona(id),
  FOREIGN KEY (rol_id) REFERENCES rol(id_rol),
  FOREIGN KEY (estado_id) REFERENCES estado_usuario(id_estado)
);

ALTER TABLE usuarios
ADD CONSTRAINT unique_id_persona UNIQUE (id_persona);

INSERT INTO usuarios (id_persona, rol_id, estado_id, username, password) VALUES 
(1, 2, 1, 'sabina@gmail.com', 'sabina'),
(2, 3, 1, 'josefina@gmail.com', 'josefina'),
(3, 1, 1, 'edyn@gmail.com','edyn');


select * from usuarios;

SELECT 
    u.id_usuario,
    p.primer_nombre,
    p.segundo_nombre,
    p.primer_apellido,
    p.segundo_apellido,
    r.nombre AS rol,
    e.descripcion AS estado,
    u.username,
    u.password,
    u.fecha_creacion
FROM 
    usuarios u
JOIN 
    persona p ON u.id_persona = p.id
JOIN 
    rol r ON u.rol_id = r.id_rol
JOIN 
    estado_usuario e ON u.estado_id = e.id_estado;
    
SELECT id_persona, primer_nombre FROM personas;

SELECT p.*
FROM persona p
LEFT JOIN usuarios u ON p.id = u.id_persona
WHERE u.id_usuario IS NULL;

select * from usuarios;


CREATE TABLE categorias_platillos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);
insert into categorias_platillos (nombre) values 
("Desayunos"), 
("Almuerzo"), 
("Bebidas");

CREATE TABLE platillos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  categoria_id INT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES categorias_platillos(id)
);

ALTER TABLE platillos
ADD imagen VARCHAR(255);

insert into platillos (nombre, descripcion, categoria_id, precio, imagen ) values ("Tradicional huevos revueltos", "Legendario Chapin", 1, "38.00", "https://i.blogs.es/bd9c52/my-project-1/1366_2000.jpg" );

insert into platillos (nombre, descripcion, categoria_id, precio, imagen ) values 
("HUEVOS CON TOMATE Y CEBOLLA", "LEGENDARIO CHAPIN", 1, "45.00", "https://d36fw6y2wq3bat.cloudfront.net/recipes/huevos-revueltos-con-tomate-y-mozzarella/900/huevos-revueltos-con-tomate-y-mozzarella_version_1667361637.jpg" ),
("HUEVOS MEXICANO RANCHERO", "LEGENDARIO CHAPIN", 1, "45.00", "https://www.paulinacocina.net/wp-content/uploads/2023/01/huevos-rancheros-1.jpg" ),
("HUEVOS CON CHORIZO (RINCON SUIZO, TECPAN)", "LEGENDARIO CHAPIN", 1, "65.00", "https://media-cdn.tripadvisor.com/media/photo-s/13/c2/4d/98/huevos-con-chorizo.jpg" ),
("HUEVOS CON CHULETA", "LEGENDARIO CHAPIN", 1, "65.00", "https://img.freepik.com/fotos-premium/foto-chuletas-cerdo-albahaca-huevo-frito-plato-blanco_959624-9644.jpg" ),
("HUEVOS CON CARNE", "LEGENDARIO CHAPIN", 1, "65.00", "https://images-gmi-pmc.edge-generalmills.com/8be98ede-9e15-427e-b0e6-252b11089424.jpg" ),
("HUEVOS CON POLLO A LA PLANCHA", "LEGENDARIO CHAPIN", 1, "65.00", "https://i.pinimg.com/736x/df/e5/d6/dfe5d63a2de6017f5bfd4e9ed53ae1ac.jpg" ),
("CEVICHE DE CAMARON", "CEVICHES", 2, "60.00", "https://www.aki.com.ec/wp-content/uploads/2021/02/ceviche_camaron.jpg" ),
("CEVICHE DE PESCADO", "CEVICHES", 2, "60.00", "https://www.laylita.com/recetas/wp-content/uploads/Ceviche-de-pescado-receta.jpg" ),
("HAMBURGUESA CLASICA DE FILETE DE POLLO", "HAMBURGUESAS", 2, "38.00", "https://img.freepik.com/fotos-premium/hamburguesa-filete-pollo-queso-lechuga-tocino-parte-superior-gran-pan-dorado-sienta-encima-gran_1249410-57007.jpg" ),
("HAMBURGUESA DE CAMARON CON QUESO MOZZARELLA", "HAMBURGUESAS", 2, "55.00", "https://i.pinimg.com/1200x/2d/fb/88/2dfb88e223e2938450e476aef324d1e3.jpg" ),
("CALDO DE MARISCOS", "MARISCOS", 2, "85.00", "https://static.wixstatic.com/media/e3d573_11f10492cd9e488f9a8331d470f5e7d4~mv2.jpg/v1/fill/w_640,h_366,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/e3d573_11f10492cd9e488f9a8331d470f5e7d4~mv2.jpg" ),
("CALDO DE PESCADO", "MARISCOS", 2, "75.00", "https://peopleenespanol.com/thmb/zAkKHp_KlH0QOWfk8QyHoaSxk70=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/caldo-de-pescado-a-la-mexicana-2000-e24a3683c02b4391b2d70572a0343b83.jpg" ),
("CAMARONES EMPANIZADOS", "CAMARONES", 2, "85.00", "https://www.cocinadelirante.com/800x600/filters:format(webp):quality(75)/sites/default/files/images/2024/09/recetas-con-camarones-empanizados-como-si-estuvieras-en-la-playa.jpg" ),
("NARANJADA SIMPLE O CON SODA PEQUEÑO", "BEBIDAS FRIAS", 3, "20.00", "https://cdn5.recetasdeescandalo.com/wp-content/uploads/2020/10/Naranjada-casera-el-refresco-mas-natural-y-sencillo.jpg" ),
("LIMONADA SIMPLE O CON SODA PEQUEÑO", "BEBIDAS FRIAS", 3, "20.00", "https://www.guiarepsol.com/content/dam/repsol-guia/contenidos-imagenes/comer/recetas/limonada-casera/gr-cms-media-featured_images-none-3a1849fa-68ef-4bef-b03a-80a9ba6f6b67-thumbnails-esy-054339614-jpg-0x740_q100.jpg.transform/rp-rendition-xs/image.jpg" ),
("HORCHATA ", "BEBIDAS FRIAS", 3, "20.00", "https://w7.pngwing.com/pngs/98/960/png-transparent-horchata-aguas-frescas-mexican-cuisine-drink-restaurant-drink-horchata-aguas-frescas-mexican-cuisine-thumbnail.png" ),
("PIÑA ", "JUGOS NATURALES Y LICUADOS", 3, "25.00", "https://imag.bonviveur.com/batido-de-pina.jpg" ),
("FRESA ", "JUGOS NATURALES Y LICUADOS", 3, "25.00", "https://www.shutterstock.com/image-photo/strawberry-smoothie-milkshake-isolated-on-260nw-2315552095.jpg" ),
("PEPSI ", "SODAS", 3, "10.00", "https://thumbs.dreamstime.com/b/pepsi-de-ml-puede-aislarse-en-fondo-blanco-156453197.jpg" ),
("COCA COLA ", "SODAS", 3, "10.00", "https://www.coca-cola.com/content/dam/onexp/cl/es/brands/coca-cola/General-Card-Coca-Cola-Original.jpg"),
("CAFE NEGRO ", "BEBIDAS CALIENTES", 3, "10.00", "https://st.depositphotos.com/2235295/2688/i/450/depositphotos_26885089-stock-photo-coffee-cup-with-jute-bag.jpg"),
("CHOCOLATE  ", "BEBIDAS CALIENTES", 3, "10.00", "https://www.funtastyc.es/blog/wp-content/uploads/2021/11/bebidas-y-chocolates-calientes-para-combatir-el-fr%C3%ADo-810x540.jpg");

CREATE TABLE mesas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero INT NOT NULL UNIQUE,
  capacidad_max INT NOT NULL
);

INSERT INTO mesas (numero, capacidad_max) VALUES (1, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (2, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (3, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (4, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (5, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (6, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (7, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (8, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (9, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (10, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (11, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (12, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (13, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (14, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (15, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (16, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (17, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (18, 6);
INSERT INTO mesas (numero, capacidad_max) VALUES (19, 6);



CREATE TABLE ordenes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  mesa_id INT NOT NULL,
  fecha_orden DATETIME DEFAULT NOW(),
  total DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (mesa_id) REFERENCES mesas(id)
);
ALTER TABLE ordenes ADD COLUMN estado VARCHAR(75);

select * from ordenes;

CREATE TABLE detalles_orden (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orden_id INT NOT NULL,
  platillo_id INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (orden_id) REFERENCES ordenes(id),
  FOREIGN KEY (platillo_id) REFERENCES platillos(id)
);
ALTER TABLE detalles_orden ADD COLUMN subtotal DECIMAL(10, 2);

INSERT INTO detalles_orden (orden_id, platillo_id, cantidad)
VALUES (1, 1, 4);


select * from ordenes;
select * from detalles_orden;
select * from platillos;
select * from mesas;
select * from usuarios;
select * from categorias_platillos;
select * from persona;
select * from rol;

DELETE FROM detalles_orden WHERE id= 22;
-- Tabla facturas

CREATE TABLE facturas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nit_cliente VARCHAR(12) NULL,
  nombre_cliente VARCHAR(100) NOT NULL,
  direccion VARCHAR(150),
  orden_id INT NOT NULL,
  fecha_factura DATETIME DEFAULT NOW(),
  FOREIGN KEY (orden_id) REFERENCES ordenes(id)
);
ALTER TABLE facturas
ADD totalFactura DECIMAL(10, 2);

-- Inserción de datos en facturas
INSERT INTO facturas (orden_id, total) VALUES
(1, 50.00),
(3, 30.00);


