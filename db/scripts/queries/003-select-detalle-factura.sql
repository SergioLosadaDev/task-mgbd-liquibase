SELECT
    f.numero_factura,
    pr.nombre AS producto,
    df.cantidad,
    df.precio_unitario,
    df.subtotal
FROM detalle_factura df
INNER JOIN factura f
    ON df.factura_id = f.id
INNER JOIN producto pr
    ON df.producto_id = pr.id;