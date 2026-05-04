--liquibase formatted sql

--changeset smungo:003-create-usuario

CREATE TABLE usuario (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    persona_id UUID NOT NULL UNIQUE,
    rol_id UUID NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    ultimo_login TIMESTAMP,
    estado BOOLEAN DEFAULT TRUE,

    CONSTRAINT fk_usuario_persona
        FOREIGN KEY (persona_id)
        REFERENCES persona(id),

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (rol_id)
        REFERENCES rol(id)
);