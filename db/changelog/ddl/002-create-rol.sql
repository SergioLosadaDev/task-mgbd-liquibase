--liquibase formatted sql

--changeset smungo:002-create-rol

CREATE TABLE rol (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(200),
    estado BOOLEAN DEFAULT TRUE
);