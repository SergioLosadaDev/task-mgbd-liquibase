--liquibase formatted sql

--changeset smungo:004-create-producto

CREATE TABLE producto (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(12,2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    codigo_barras VARCHAR(100) UNIQUE,
    estado BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);