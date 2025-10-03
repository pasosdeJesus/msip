# Integración de Pruebas Puppeteer con GitHub Actions en OpenBSD

## Resumen

Este documento describe la configuración para ejecutar las pruebas end-to-end con Puppeteer en GitHub Actions utilizando OpenBSD como plataforma de ejecución, aprovechando la restauración del modo headless de Chromium en OpenBSD 7.7.

## Características Principales

- **Plataforma prioritaria**: OpenBSD (como plataforma principal de desarrollo)
- **CI/CD**: GitHub Actions con VMs de OpenBSD 
- **Navegador**: Chromium en modo headless (funcional desde OpenBSD 7.7)
- **Modificaciones mínimas**: Cambios pequeños al código existente
- **Compatibilidad**: Mantiene funcionalidad local en OpenBSD

## Archivos Modificados

### 1. `.github/workflows/openbsd-puppeteer.yml`

Workflow de GitHub Actions que:
- Ejecuta una VM de OpenBSD 7.6+ en GitHub Actions
- Instala todas las dependencias (Ruby, Node.js, PostgreSQL, Chromium)
- Configura la base de datos de pruebas
- Ejecuta las pruebas Puppeteer en modo headless
- Incluye timeout de 45 minutos y logging detallado

**Características importantes:**
- Usa `vmactions/openbsd-vm@v1` para emular OpenBSD
- Memoria asignada: 4GB para mejor performance
- Instala Chromium con soporte headless completo
- Configuración automática de PostgreSQL
- Variables de ambiente optimizadas para CI

### 2. `pruebas_puppeteer/index.mjs`

Modificaciones mínimas para detectar entorno CI:
- Detección automática de `CI=true` para activar modo headless
- Prioriza navegadores de OpenBSD (`/usr/local/bin/chromium`)
- Configuración optimizada para entornos sin interfaz gráfica
- Fallbacks para diferentes sistemas operativos

### 3. `bin/verificar-puppeteer-ci.sh`

Script de verificación que:
- Comprueba configuración de navegadores
- Verifica modo headless
- Valida variables de ambiente
- Diagnostica problemas comunes

## Configuración de Variables

### Variables CI Automáticas
- `CI=true`: Se define automáticamente en GitHub Actions
- Activa modo headless sin necesidad de `CONCABEZA`

### Variables de Prueba
- `IPDES=127.0.0.1`: IP del servidor de pruebas
- `PUERTOPRU=33001`: Puerto del servidor Rails
- `RAILS_ENV=test`: Entorno de Rails
- `DATABASE_URL`: Conexión a PostgreSQL

## Flujo de Ejecución

1. **Checkout del código**: Descarga el repositorio
2. **Preparación del sistema**: Actualiza OpenBSD e instala paquetes
3. **Configuración de servicios**: PostgreSQL, dependencias Ruby/Node
4. **Preparación de la aplicación**: Base de datos, assets, configuración
5. **Instalación de dependencias JS**: yarn install en pruebas_puppeteer
6. **Ejecución de pruebas**: bin/pruebasjs.sh con timeout de 20 minutos
7. **Limpieza y reporte**: Logs y diagnósticos en caso de error

## Beneficios de esta Implementación

### Para Desarrollo Local en OpenBSD
- **Sin cambios**: Las pruebas funcionan igual que antes
- **Compatibilidad**: Modo con/sin cabeza según configuración
- **Debugging**: Mantiene todas las capacidades de desarrollo

### Para CI/CD en GitHub Actions
- **Automatización**: Ejecución automática en push/PR
- **Consistencia**: Mismo entorno que desarrollo (OpenBSD)
- **Eficiencia**: Modo headless automático en CI
- **Robustez**: Timeouts y manejo de errores

## Activación y Uso

### Ejecución Automática
Las pruebas se ejecutan automáticamente en:
- Push a ramas `main` o `v2.2`
- Pull requests a estas ramas
- Programación semanal (domingos 02:00 UTC)

### Ejecución Manual
En GitHub:
1. Ir a la pestaña "Actions"
2. Seleccionar "Pruebas Puppeteer en OpenBSD"
3. Clic en "Run workflow"

### Verificación Local
```bash
# En OpenBSD, verificar configuración
./bin/verificar-puppeteer-ci.sh

# Ejecutar pruebas localmente
cd test/dummy
bin/pruebasjs.sh
```

## Requisitos Mínimos

### Sistema OpenBSD
- OpenBSD 7.6+ (recomendado 7.7+ para mejor soporte headless)
- Chromium instalado (`pkg_add chromium`)
- PostgreSQL configurado
- Ruby 3.4+, Node.js, Yarn

### GitHub Actions
- Repositorio con Actions habilitado
- Workflow file en `.github/workflows/`
- Sin configuración adicional requerida

## Solución de Problemas

### Problemas Comunes

1. **Timeout en pruebas**
   - Revisar logs en GitHub Actions
   - Verificar que Chromium inicie correctamente
   - Comprobar configuración de base de datos

2. **Error de navegador**
   - Asegurar que Chromium esté instalado
   - Verificar permisos de ejecución
   - Comprobar modo headless con verificador

3. **Fallas en CI pero funciona local**
   - Revisar variables de ambiente CI
   - Comprobar configuración de .env
   - Verificar timeouts específicos del CI

### Debugging

Los logs de GitHub Actions incluyen:
- Versiones de software instalado
- Configuración de variables de ambiente
- Output completo de las pruebas
- Información de procesos en caso de error

## Ventajas de OpenBSD 7.7+

La restauración del modo headless en OpenBSD 7.7 proporciona:
- **Estabilidad**: Chromium headless funciona sin modificaciones
- **Performance**: Mejor rendimiento en entornos sin GUI
- **Simplicidad**: No requiere servidores X virtuales
- **Compatibilidad**: Mismas APIs que otros sistemas operativos

## Mantenimiento

### Actualizaciones Recomendadas
- Mantener OpenBSD actualizado (syspatch)
- Actualizar Chromium regularmente
- Monitorear compatibilidad de dependencias Node.js/Ruby

### Monitoreo
- Revisar ejecuciones semanales programadas
- Verificar tiempos de ejecución (objetivo < 30 min)
- Comprobar logs por errores intermitentes

## Conclusión

Esta implementación logra el objetivo de ejecutar pruebas Puppeteer en GitHub Actions sobre OpenBSD con modificaciones mínimas, aprovechando las mejoras en el soporte headless de Chromium. Mantiene OpenBSD como plataforma prioritaria mientras proporciona integración CI/CD robusta y automatizada.