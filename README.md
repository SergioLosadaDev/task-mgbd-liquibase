# PostgreSQL + Liquibase

Proyecto de ejemplo utilizando:

- PostgreSQL 16
- Docker Compose
- Liquibase
- Migraciones DDL y DML
- Datos de prueba
- Validaciones SQL

---

# Arquitectura

```text
Docker Compose
│
├── PostgreSQL
│
└── Liquibase
      │
      ├── Ejecuta migraciones DDL
      ├── Ejecuta migraciones DML
      └── Versiona la base de datos
```

---

# Estructura del proyecto

```text
project-root/
│
├── docker-compose.yml
├── liquibase.properties
├── README.md
│
└── database/
    └── changelog/
        ├── ddl/
        │   ├── 001-create-persona.sql
        │   ├── 002-create-rol.sql
        │   ├── 003-create-usuario.sql
        │   ├── 004-create-producto.sql
        │   ├── 005-create-factura.sql
        │   └── 006-create-detalle-factura.sql
        │
        ├── dml/
        │   ├── 001-insert-data.sql
        │   ├── 002-update-data.sql
        │   └── 003-delete-data.sql
        │
        └── queries/
            ├── 001-select-personas.sql
            ├── 002-select-facturas.sql
            └── 003-select-detalle-factura.sql
```

---

# Requisitos

Instalar previamente:

- Docker Desktop
- Docker Compose
- Git

Verificar instalación:

```bash
docker --version
docker compose version
```

---

# Levantar el proyecto

Desde la raíz del proyecto ejecutar:

```bash
docker compose up -d
```

---

# ¿Qué hace este comando?

Docker Compose automáticamente:

1. Descarga PostgreSQL 16.
2. Crea el contenedor PostgreSQL.
3. Crea la base de datos `ecommerce_db`.
4. Levanta Liquibase.
5. Ejecuta migraciones DDL.
6. Ejecuta migraciones DML.
7. Inserta datos de prueba.

---

# Verificar contenedores

```bash
docker ps
```

Resultado esperado:

```text
postgres-ecommerce
liquibase-ecommerce
```

---

# Ver logs de Liquibase

```bash
docker logs liquibase-ecommerce
```

Resultado esperado:

```text
Liquibase command 'update' was executed successfully.
```

---

# Acceder a PostgreSQL

Ingresar al contenedor:

```bash
docker exec -it postgres-ecommerce psql -U admin -d ecommerce_db
```

---

# Verificar tablas creadas

Dentro de PostgreSQL ejecutar:

```sql
\dt
```

Resultado esperado:

```text
persona
rol
usuario
producto
factura
detalle_factura
databasechangelog
databasechangeloglock
```

---

# Ejecutar consultas de validación

## Personas

```sql
SELECT
    id,
    nombres,
    apellidos,
    correo
FROM persona;
```

---

## Facturas

```sql
SELECT
    numero_factura,
    total
FROM factura;
```

---

## Detalle factura

```sql
SELECT
    factura_id,
    producto_id,
    cantidad
FROM detalle_factura;
```

---

# Verificar datos insertados

## Contar registros

```sql
SELECT COUNT(*) FROM persona;
SELECT COUNT(*) FROM producto;
SELECT COUNT(*) FROM factura;
```

---

# Rollback de Liquibase

Deshacer el último changeset:

```bash
docker exec -it liquibase-ecommerce \
liquibase \
--url=jdbc:postgresql://postgres:5432/ecommerce_db \
--username=admin \
--password=admin123 \
--changeLogFile=changelog/db.changelog-master.yaml \
rollbackCount 1
```

---

# Detener el proyecto

```bash
docker compose down
```

---

# Eliminar contenedores y volúmenes

```bash
docker compose down -v
```

---

# Eliminar imágenes Docker

```bash
docker rmi postgres:16
docker rmi liquibase/liquibase:latest
```

---

# Problemas comunes

## Puerto 5432 ocupado

Error:

```text
Bind for 0.0.0.0:5432 failed
```

Solución:

- Detener PostgreSQL local.
- O cambiar el puerto en `docker-compose.yml`.

Ejemplo:

```yaml
ports:
  - "5433:5432"
```

---

## Liquibase no encuentra PostgreSQL

Validar:

```bash
docker ps
```

y revisar logs:

```bash
docker logs postgres-ecommerce
docker logs liquibase-ecommerce
```

---

# Buenas prácticas recomendadas

## Separar migraciones

```text
ddl/
dml/
validation/
```

---

## Usar changesets pequeños

Un changeset debe representar:

- una tabla
- una relación
- un índice
- una modificación específica

---

## Nunca modificar changesets ejecutados

Liquibase guarda hashes en:

```text
DATABASECHANGELOG
```

Modificar changesets ya ejecutados puede generar errores.

---

# Tecnologías utilizadas

| Tecnología     | Versión |
| -------------- | ------- |
| PostgreSQL     | 16      |
| Liquibase      | latest  |
| Docker         | latest  |
| Docker Compose | v2      |

---

# Resultado esperado

Al finalizar:

✅ PostgreSQL levantado  
✅ Liquibase ejecutado  
✅ Tablas creadas  
✅ Relaciones creadas  
✅ Datos insertados  
✅ Validaciones funcionales  
✅ Base de datos versionada
