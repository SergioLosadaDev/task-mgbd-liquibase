--liquibase formatted sql

--changeset smungo:006-create-detalle-factura

CREATE TABLE detalle_factura (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    factura_id UUID NOT NULL,
    producto_id UUID NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_detalle_factura
        FOREIGN KEY (factura_id)
        REFERENCES factura(id),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto(id)
);