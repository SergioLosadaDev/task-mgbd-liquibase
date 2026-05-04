--liquibase formatted sql

--changeset smungo:005-create-factura

CREATE TABLE factura (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    numero_factura VARCHAR(30) UNIQUE NOT NULL,
    cliente_id UUID NOT NULL,
    usuario_id UUID NOT NULL,
    fecha_factura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(12,2) NOT NULL,
    impuesto DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVA',

    CONSTRAINT fk_factura_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES persona(id),

    CONSTRAINT fk_factura_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuario(id)
);