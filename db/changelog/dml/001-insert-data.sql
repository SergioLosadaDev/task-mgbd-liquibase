--liquibase formatted sql

--changeset smungo:001-insert-data
INSERT INTO rol (id, nombre, descripcion)
VALUES
(uuid_generate_v4(), 'ADMIN', 'Administrador del sistema'),
(uuid_generate_v4(), 'CAJERO', 'Usuario cajero');

INSERT INTO persona (
    id,
    tipo_documento,
    numero_documento,
    nombres,
    apellidos,
    telefono,
    correo,
    direccion
)
VALUES
(
    '11111111-1111-1111-1111-111111111111',
    'CC',
    '100001',
    'Juan',
    'Perez',
    '3001234567',
    'juan@email.com',
    'Bogota'
),
(
    '22222222-2222-2222-2222-222222222222',
    'CC',
    '100002',
    'Maria',
    'Lopez',
    '3009876543',
    'maria@email.com',
    'Medellin'
);


INSERT INTO usuario (
    id,
    persona_id,
    rol_id,
    username,
    password_hash
)
VALUES
(
    uuid_generate_v4(),
    '11111111-1111-1111-1111-111111111111',
    (SELECT id FROM rol WHERE nombre = 'ADMIN'),
    'admin',
    'encrypted_password'
);


INSERT INTO producto (
    id,
    nombre,
    descripcion,
    precio,
    stock,
    codigo_barras
)
VALUES
(
    '33333333-3333-3333-3333-333333333333',
    'Laptop Lenovo',
    'Laptop empresarial',
    3500.00,
    10,
    'ABC123'
),
(
    '44444444-4444-4444-4444-444444444444',
    'Mouse Logitech',
    'Mouse inalambrico',
    120.00,
    50,
    'XYZ999'
);

INSERT INTO factura (
    id,
    numero_factura,
    cliente_id,
    usuario_id,
    subtotal,
    impuesto,
    total
)
VALUES
(
    '55555555-5555-5555-5555-555555555555',
    'FAC-001',
    '22222222-2222-2222-2222-222222222222',
    (SELECT id FROM usuario WHERE username = 'admin'),
    3620.00,
    687.80,
    4307.80
);

INSERT INTO detalle_factura (
    id,
    factura_id,
    producto_id,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES
(
    uuid_generate_v4(),
    '55555555-5555-5555-5555-555555555555',
    '33333333-3333-3333-3333-333333333333',
    1,
    3500.00,
    3500.00
),
(
    uuid_generate_v4(),
    '55555555-5555-5555-5555-555555555555',
    '44444444-4444-4444-4444-444444444444',
    1,
    120.00,
    120.00
);