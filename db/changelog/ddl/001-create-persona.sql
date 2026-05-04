--liquibase formatted sql

--changeset smungo:001-create-persona

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE persona (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tipo_documento VARCHAR(20) NOT NULL,
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(150) UNIQUE,
    direccion VARCHAR(200),
    fecha_nacimiento DATE,
    estado BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);