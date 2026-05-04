--liquibase formatted sql

--changeset smungo:002-update-data

UPDATE producto
SET stock = stock - 1
WHERE id = '33333333-3333-3333-3333-333333333333';


UPDATE persona
SET telefono = '3119998888'
WHERE numero_documento = '100001';