--liquibase formatted sql

--changeset smungo:003-delete-data

DELETE FROM producto
WHERE codigo_barras = 'XYZ999';