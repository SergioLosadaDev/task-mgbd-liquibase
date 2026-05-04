SELECT
    f.numero_factura,
    p.nombres || ' ' || p.apellidos AS cliente,
    f.total,
    f.fecha_factura
FROM factura f
INNER JOIN persona p
    ON f.cliente_id = p.id;