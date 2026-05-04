# Conceptos Fundamentales: Liquibase, Migraciones y Docker Compose

## 1. Liquibase

### Definición

Liquibase es una herramienta de control de versiones para bases de datos que permite gestionar, automatizar y versionar cambios estructurales en una base de datos de forma segura y controlada.

Se utiliza principalmente en proyectos backend y arquitecturas modernas para mantener sincronizados los entornos de desarrollo, pruebas y producción.

### Objetivos principales

- Automatizar cambios en la base de datos.
- Versionar la estructura de la BD.
- Facilitar despliegues continuos (CI/CD).
- Evitar inconsistencias entre ambientes.
- Permitir auditoría de cambios.

### Funcionalidades principales

- Ejecución automática de scripts SQL.
- Control de cambios mediante historial.
- Rollback de cambios.
- Integración con Docker y pipelines.
- Compatibilidad con múltiples motores de BD:
  - PostgreSQL
  - MySQL
  - Oracle
  - SQL Server
  - MariaDB

### Ejemplo básico de uso

```bash
liquibase update
```

Este comando aplica todos los cambios pendientes definidos en los changelogs.

---

# 2. Changelog

## Definición

Un changelog es el archivo principal donde se registran todos los cambios que se realizarán sobre la base de datos.

Liquibase lee este archivo para identificar:

- Qué cambios existen.
- Cuáles ya fueron ejecutados.
- Cuáles faltan por ejecutar.

## Características

- Puede escribirse en:
  - XML
  - YAML
  - JSON
  - SQL

- Contiene uno o varios changesets.
- Funciona como historial de versiones de la base de datos.

## Ejemplo en YAML

```yaml
databaseChangeLog:
  - changeSet:
      id: 1
      author: admin
      changes:
        - createTable:
            tableName: usuarios
            columns:
              - column:
                  name: id
                  type: BIGINT
```

---

# 3. Changeset

## Definición

Un changeset es una unidad individual de cambio dentro de un changelog.

Representa una modificación específica en la base de datos.

## Características

- Tiene identificador único.
- Posee autor.
- Se ejecuta una sola vez.
- Liquibase registra su ejecución en la tabla:

```sql
DATABASECHANGELOG
```

## Ejemplos de cambios

- Crear tablas.
- Modificar columnas.
- Insertar datos.
- Crear índices.
- Eliminar restricciones.

## Ejemplo

```yaml
- changeSet:
    id: 2
    author: dev
    changes:
      - addColumn:
          tableName: usuarios
          columns:
            - column:
                name: email
                type: VARCHAR(100)
```

---

# 4. Rollback

## Definición

Rollback es el proceso de revertir cambios realizados en la base de datos.

Permite regresar la BD a un estado anterior en caso de:

- errores,
- fallos de despliegue,
- inconsistencias,
- cambios incorrectos.

## Importancia

El rollback es fundamental en entornos productivos porque:

- reduce riesgos,
- mejora recuperación ante errores,
- permite despliegues más seguros.

## Tipos de rollback

### Automático

Liquibase puede generar rollback automáticamente para ciertos cambios.

### Manual

El desarrollador define explícitamente cómo revertir el cambio.

## Ejemplo

```yaml
- changeSet:
    id: 3
    author: admin
    changes:
      - createTable:
          tableName: productos

    rollback:
      - dropTable:
          tableName: productos
```

## Comando de rollback

```bash
liquibase rollbackCount 1
```

Revierte el último changeset ejecutado.

---

# 5. DDL (Data Definition Language)

## Definición

DDL es el conjunto de instrucciones SQL utilizadas para definir o modificar estructuras de bases de datos.

## Objetivo

Gestionar:

- tablas,
- columnas,
- índices,
- restricciones,
- esquemas.

## Comandos principales

| Comando  | Función           |
| -------- | ----------------- |
| CREATE   | Crear objetos     |
| ALTER    | Modificar objetos |
| DROP     | Eliminar objetos  |
| TRUNCATE | Vaciar tablas     |

## Ejemplos

### Crear tabla

```sql
CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(100)
);
```

### Modificar tabla

```sql
ALTER TABLE usuarios
ADD COLUMN email VARCHAR(100);
```

### Eliminar tabla

```sql
DROP TABLE usuarios;
```

---

# 6. DML (Data Manipulation Language)

## Definición

DML es el conjunto de instrucciones SQL utilizadas para manipular datos almacenados en las tablas.

## Objetivo

Permitir operaciones CRUD:

- Create
- Read
- Update
- Delete

## Comandos principales

| Comando | Función          |
| ------- | ---------------- |
| INSERT  | Insertar datos   |
| UPDATE  | Actualizar datos |
| DELETE  | Eliminar datos   |
| SELECT  | Consultar datos  |

## Ejemplos

### Insertar datos

```sql
INSERT INTO usuarios (id, nombre)
VALUES (1, 'Carlos');
```

### Actualizar datos

```sql
UPDATE usuarios
SET nombre = 'Juan'
WHERE id = 1;
```

### Eliminar datos

```sql
DELETE FROM usuarios
WHERE id = 1;
```

### Consultar datos

```sql
SELECT * FROM usuarios;
```

---

# 7. Docker Compose

## Definición

Docker Compose es una herramienta que permite definir y administrar múltiples contenedores Docker mediante un archivo YAML.

Facilita la ejecución de aplicaciones compuestas por varios servicios.

## Objetivos

- Automatizar entornos.
- Levantar múltiples contenedores.
- Gestionar redes y volúmenes.
- Simplificar despliegues locales.

## Casos comunes

- Backend + Base de datos.
- Microservicios.
- Entornos de desarrollo.
- Integración con Liquibase.

## Archivo principal

```yaml
docker-compose.yml
```

## Ejemplo básico

```yaml
version: "3.9"

services:
  postgres:
    image: postgres:16
    container_name: postgres-db
    environment:
      POSTGRES_DB: ecommerce
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin
    ports:
      - "5432:5432"

  liquibase:
    image: liquibase/liquibase
    depends_on:
      - postgres
    volumes:
      - ./db:/liquibase/changelog
    command: --url=jdbc:postgresql://postgres:5432/ecommerce
      --username=admin
      --password=admin
      --changeLogFile=master.yml
      update
```

## Comandos importantes

### Levantar servicios

```bash
docker compose up
```

### Ejecutar en segundo plano

```bash
docker compose up -d
```

### Detener servicios

```bash
docker compose down
```

---

# 8. Migraciones de Base de Datos

## Definición

Las migraciones son procesos controlados de modificación de la estructura o datos de una base de datos a lo largo del tiempo.

Permiten evolucionar la BD de manera ordenada y versionada.

## Objetivos

- Mantener trazabilidad.
- Sincronizar ambientes.
- Automatizar cambios.
- Reducir errores manuales.

## Características

- Versionadas.
- Repetibles.
- Auditables.
- Automatizables.

## Flujo típico de migraciones

```text
Desarrollador crea changeset
            ↓
Se agrega al changelog
            ↓
Liquibase detecta cambios pendientes
            ↓
Liquibase ejecuta migraciones
            ↓
Se registra ejecución en DATABASECHANGELOG
```

## Ejemplo de migración

### Migración V1

```sql
CREATE TABLE productos (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(100)
);
```

### Migración V2

```sql
ALTER TABLE productos
ADD COLUMN precio DECIMAL(10,2);
```

---

# Relación entre todos los conceptos

| Concepto       | Relación                      |
| -------------- | ----------------------------- |
| Liquibase      | Herramienta de migración      |
| Changelog      | Archivo principal de cambios  |
| Changeset      | Cambio individual             |
| Rollback       | Reversión de cambios          |
| DDL            | Cambios estructurales         |
| DML            | Manipulación de datos         |
| Docker Compose | Orquestación de contenedores  |
| Migraciones    | Evolución controlada de la BD |

---

# Ejemplo de Arquitectura Real

```text
Backend Spring Boot
        ↓
Liquibase
        ↓
PostgreSQL
        ↑
Docker Compose
```

## Flujo

1. El desarrollador crea un changeset.
2. El changeset se agrega al changelog.
3. Docker Compose levanta PostgreSQL y Liquibase.
4. Liquibase ejecuta migraciones automáticamente.
5. La BD queda actualizada.

---

# Buenas Prácticas

## Liquibase

- Usar un changeset por cambio lógico.
- Nunca modificar changesets ya ejecutados.
- Mantener IDs únicos.
- Definir rollback siempre que sea posible.

## Docker Compose

- Usar variables de entorno.
- Separar servicios por responsabilidad.
- Versionar el archivo compose.

## Migraciones

- Mantener scripts pequeños y claros.
- Probar migraciones antes de producción.
- Evitar cambios destructivos sin backup.

---

# Conclusión

Liquibase y las migraciones de bases de datos son herramientas fundamentales en el desarrollo moderno de software, especialmente en arquitecturas backend y microservicios.

Gracias a:

- changelogs,
- changesets,
- rollbacks,
- DDL,
- DML,
- y Docker Compose,

es posible construir sistemas:

- escalables,
- mantenibles,
- automatizados,
- y seguros para despliegues continuos.
