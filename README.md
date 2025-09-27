# msip - Motor para Sistemas de Información estilo Pasos de Jesús

[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) Pruebas y seguridad:[![Estado Construcción gitlab](https://gitlab.com/pasosdeJesus/msip/badges/v2.2/pipeline.svg)](https://gitlab.com/pasosdeJesus/msip/-/pipelines?page=1&scope=all&ref=v2.2) [![Gem Version](https://badge.fury.io/rb/msip.svg)](https://badge.fury.io/rb/msip) [![Integración continua github](https://github.com/pasosdeJesus/msip/actions/workflows/rubyonrails.yml/badge.svg?branch=v2.2)](https://github.com/pasosdeJesus/msip/actions/workflows/rubyonrails.yml) [![CodeQL en github](https://github.com/pasosdeJesus/msip/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/pasosdeJesus/msip/actions/workflows/codeql-analysis.yml)

![Logo de msip](test/dummy/app/assets/images/logo.jpg)

Motor Ruby on Rails que proporciona una base segura y actualizada para
desarrollar sistemas de información complejos. Incluye componentes estándar,
interfaces automatizadas y mejores prácticas de seguridad.

## 🚀 Características Principales

### 📊 Vistas Automatizadas
- **Administración automática de modelos**: Generación de vistas y controladores
  sin código adicional
- **Filtros y paginación**: Listados con filtros configurables y paginación con
  `will_paginate`
- **Interfaz adaptable**: Diseño responsive con Bootstrap, Stimulus y jQuery
- **Componentes modernos**: `tom-select` para selecciones, controles nativos
  para fechas
- **Sistema de temas**: Múltiples temas de colores configurables por usuario

### 🏗️ Componentes Preconstruidos
- **Geolocalización**: Países, departamentos, municipios y centros poblados
  - Datos completos para Colombia, Venezuela y Honduras
  - Mapas SVG de departamentos y municipios de Colombia
- **Gestión de Personas**: Personas, documentos, y relaciones entre personas
- **Organizaciones**: Grupos, organizaciones sociales y sectores
- **Sistema de archivos**: Anexos con almacenamiento seguro

### 🔐 Seguridad y Control de Acceso
- **Autenticación**: Integración con Devise y bcrypt
- **Autorización flexible**: Sistema de roles y grupos con Cancancan
- **Respaldos seguros**: Exportación cifrada y comprimida con 7z

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
* Historial de cambios: [Versiones y publicaciones](https://gitlab.com/pasosdeJesus/msip/-/releases)

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

* Actualizaciones semestrales en sincronía con adJ (OpenBSD)
* Pruebas continuas en Linux via GitLab CI y Github Actions
* Actualización periódica de datos geográficos según DIVIPOLA colombiano
* Gemas actualizadas semanalmente para garantizar seguridad y funcionalidad

