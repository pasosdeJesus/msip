# msip - Motor para Sistemas de Información estilo Pasos de Jesús

[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) 
[![Estado Construcción gitlab](https://gitlab.com/pasosdeJesus/msip/badges/main/pipeline.svg)](https://gitlab.com/pasosdeJesus/msip/-/pipelines?page=1&scope=all&ref=main) 
[![Gem Version](https://badge.fury.io/rb/msip.svg)](https://badge.fury.io/rb/msip) 
[![Integración continua github](https://github.com/pasosdeJesus/msip/actions/workflows/rubyonrails.yml/badge.svg?branch=main)](https://github.com/pasosdeJesus/msip/actions/workflows/rubyonrails.yml) 
[![CodeQL en github](https://github.com/pasosdeJesus/msip/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/pasosdeJesus/msip/actions/workflows/codeql.yml)

![Logo de msip](test/dummy/app/assets/images/logo.jpg)

Motor Ruby on Rails que proporciona una base segura y actualizada para
desarrollar sistemas de información. Incluye componentes estándar,
interfaces automatizadas y mejores prácticas de seguridad.

> Nota sobre rama experimental `msipn`: Se está desarrollando un motor paralelo en TypeScript/Next.js dentro de `packages/msipn/*`. La aplicación de prueba ahora reside en `packages/app-msipn` y no hace parte de los `workspaces` de pnpm; se ejecuta de forma independiente con su propio `.env` (instalar con `cd packages/app-msipn && pnpm install`).

### Instalación experimental del CLI msipn (sin publicar aún)

Puedes incorporar el CLI experimental directamente desde esta rama usando el inicializador.

Opción rápida (inyecta dependencias y scripts en tu proyecto existente):

```sh
npx github:pasosdeJesus/msip#msipn
```

Lo anterior:
1. Añade dependencia `@pasosdejesus/msipn` apuntando a la rama `msipn` del repositorio.
2. Añade dependencias requeridas `kysely` y `pg` si faltan.
3. Crea script `bin/msipn`

Luego puedes ejecutar:

```sh
bin/msipn --help
bin/msipn db:migrate
```

Para agregar manualmente sin el inicializador, en tu `package.json`:
```jsonc
{
  "dependencies": {
    "@pasosdejesus/msipn": "github:pasosdeJesus/msip#msipn",
    "kysely": "^0.27.3",
    "pg": "^8.11.5"
  }
}
```
Y después `npm install` / `pnpm install` / `yarn`.

Advertencia: La estructura y API pueden cambiar hasta publicación estable.

### Verificación CI de instalación (GitHub)

Se ejecuta un flujo de GitHub Actions (`msipn GitHub Install Smoke Test`) que crea un proyecto temporal, instala `@pasosdejesus/msipn` desde la rama `msipn` y verifica que `npx msipn --help` incluya comandos clave (`db:migrate`, `db:rollback`). Esto asegura que el paquete es consumible directamente desde GitHub.

### Comandos CLI experimentales (rama `msipn`)

Dentro de `packages/app-msipn` existe un binario Node `bin/msipn` que provee tareas para la base de datos (similar a Rake) escritas en TypeScript.

Creación idempotente del rol superusuario definido en `.env`:

```sh
cd packages/app-msipn
cp .env.template .env # si aún no existe y ajusta PGUSER/PGPASSWORD
sudo ./bin/msipn db:super:createuser
```

El comando:
* Carga automáticamente `.env` (incluso bajo `sudo`).
* Intenta primero conexión directa (peer/password). Si falla, usa escalamiento no interactivo (sudo/doas) cuando está disponible.
* Es idempotente: si el rol existe, sólo actualiza contraseña.
* Añade/actualiza entrada en `~/.pgpass` (`*:*:*:PGUSER:PGPASSWORD`).

Variables de control opcionales:
* `PG_ESCALATION=direct|sudo|doas|root-su` fuerza modo.
* `PG_NO_SUDO=1` evita intentar sudo aunque exista.
* `PG_ALLOW_INTERACTIVE_SUDO=1` permite (como último recurso) sudo con prompt.

Requisitos para uso no interactivo:
* Sudo o doas configurado sin contraseña para ejecutar como el usuario del sistema `postgres` (e.g. entrada sudoers `usuario ALL=(postgres) NOPASSWD:ALL`).

Prueba automatizada:
* El archivo `packages/app-msipn/tests/db_super_createuser.test.ts` valida idempotencia y superusuario cuando `sudo -n -u postgres` está disponible; se auto-salta si no.

Después de crear el rol puedes crear la base y migrar:
```sh
./bin/msipn db:create
./bin/msipn db:migrate
```

Advertencia: Esta interfaz es experimental y su API puede cambiar hasta estabilizar el motor TypeScript.

## 🚀 Características Principales

### 📊 Vistas Automatizadas
- **Administración automática de modelos**: Generación de vistas y controladores
  sin código adicional
- **Filtros y paginación**: Listados con filtros configurables y paginación con
  `will_paginate`
- **Interfaz adaptable**: Diseño responsive con Bootstrap y Stimulus
- **Componentes modernos**: `tom-select` para selecciones, controles nativos
  para fechas

### 🏗️ Componentes Preconstruidos
- **Geolocalización**: Países, departamentos, municipios y centros poblados
  - Datos completos para Colombia, Venezuela y Honduras
  - Mapas SVG de departamentos y municipios de Colombia
  - Validaciones geográficas y jerarquías territoriales
- **Gestión de Personas**: Personas, documentos, y relaciones entre personas
  - Validaciones de documentos por país
  - Sistema de familiares y relaciones
  - Etiquetado para categorización flexible
- **Organizaciones**: Grupos, organizaciones sociales y sectores
  - Gestión de grupos con personas asociadas
  - Roles y cargos organizacionales
- **Sistema de archivos**: Anexos con almacenamiento seguro

### 🔐 Seguridad y Control de Acceso
- **Autenticación**: Integración con Devise y bcrypt
- **Autorización flexible**: Sistema de roles y grupos con Cancancan
- **Respaldos seguros**: Exportación cifrada y comprimida con 7z

### 📊 Calidad y Confiabilidad
- **Cobertura de pruebas minitest a modelos, controladores y helpers**: Superior al 70%
- **Pruebas End-to-End con Puppeteer**: Optimizadas para OpenBSD 7.7+
- **CI/CD robusto**: GitHub Actions y GitLab CI

### 🛠️ Desarrollo y Configuración
- **Configuración centralizada**: Variables de ambiente con `.env` y `dotenv`
- **Migraciones automáticas**: Inclusión automática de migraciones de motores
- **Tareas Rake**: Utilidades para mantenimiento de base de datos
- **Pruebas robustas**: Suite de pruebas con Minitest

## 📋 Requisitos

Consultalos en [requisitos del sistema](doc/requisitos.md).

## 🏁 Comenzar Rápido

### Aplicación de Demostración
msip incluye una aplicación completa en `test/dummy` que puedes ejecutar
inmediatamente:

```sh
# Crea un usuario y base de datos en PostgreSQL
# Clona el repositorio
git clone https://gitlab.com/pasosdeJesus/msip.git
cd msip

# Configura y ejecuta la aplicación de prueba
bundle install
cd test/dummy
cp .env.plantilla .env
# Edita .env y pon base de datos y usuario
rails db:setup
rails server
```

Sigue la guía completa de la [aplicación de prueba](doc/aplicacion-de-prueba.md)
para más detalles.

### Crear un Nuevo Proyecto

Consulta instrucciones detalladas en la 
[guía completa de nuevas aplicaciones](doc/iniciar-si-usando-msip.md).

# 📚 Documentación

* Guías de uso: [Documentación principal](doc/README.me)
* Vistas automáticas: [Configuración y uso](doc/vistas-automaticas.md)
* Actualizaciones: [Wiki del proyecto](https://gitlab.com/pasosdeJesus/msip/-/wikis/pages)
* Historial de publicaciones: [Versiones y publicaciones](https://gitlab.com/pasosdeJesus/msip/-/releases)

# 🐛 Reportar Problemas y Contribuir

## Encontraste un error?

Abre un [nuevo issue](https://gitlab.com/pasosdeJesus/msip/-/issues) con:

* Una descripción clara del problema
* Pasos para reproducirlo
* Versiones relevantes (Ruby, Rails, MSIP)

## ¿Quieres contribuir?

Consulta nuestras [guías de contribución](CONTRIBUTING.md) para:

* Reportar bugs
* Sugerir nuevas características
* Enviar pull requests

# 🔄 Mantenimiento y Actualizaciones

msip se mantiene actualizado mediante:

* Publicación de nuevas versiones más o menos cada 3 meses
* Actualizaciones semestrales al sistema base (distribución adJ) en sincronía con OpenBSD
* Gemas actualizadas semanalmente para garantizar seguridad y funcionalidad
* Pruebas continuas via GitHub Actions y Linux via GitLab CI
* Pruebas end-to-end automatizadas con Puppeteer en OpenBSD
* Actualización periódica de datos geográficos según DIVIPOLA colombiano
