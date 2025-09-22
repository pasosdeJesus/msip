# Documentación de msip - Motor para Sistemas de Información

Motor sobre Ruby on Rails que facilita el desarrollo y actualización de Sistemas
de Información al estilo Pasos de Jesús.

## 🎯 Filosofía del Proyecto

msip aplica el principio de **"convención sobre configuración"** de Rails a un
nivel superior, permitiendo:
- Desarrollo rápido de aplicaciones
- Metodología ágil para puesta en marcha
- Ciclos regulares de actualización (cada 6 meses para tecnologías base)
- Mantenimiento a largo plazo sobre tecnologías recientes

**Elecciones técnicas distintivas:**
- Uso del español en sistemas desarrollados y fuentes
- Modelo `usuario` para autenticación con Devise
- Enfoque en sostenibilidad y actualizaciones periódicas

## 📚 Índice de Documentación

### 🏗️ **Implementación**
- **[Requisitos del Sistema](requisitos.md)** - Configuración necesaria
- **[Iniciar un SI usando msip](iniciar-si-usando-msip.md)** - Guía de inicio
  rápido
- **[Ejemplo con Vistas Automáticas](ejemplo-con-vistas-automaticas.md)** - Caso
  práctico completo

#### **Modelos de Datos**
- **[Modelo Entidad-Asociación](modelo-entidad-asociacion.md)** - Estructura
  general
- **[Tablas Básicas](tablas-basicas.md)** - Parámetros y catálogos
- **[Tablas Asociativas](tablas-asociativas.md)** - Relaciones entre entidades
- **[Modelo Usuario](modelo-usuario.md)** - Autenticación y personalización
- **[Personalización de Modelos](personalizacion-de-modelos.md)**
  - [Familiares](familiares.md) - Extensión del modelo Persona
  - [Ubicación Predefinida](ubicacionpre.md) - Datos geográficos

#### **Controladores**
- **[Facilidades de Controladores](facilidades-controlador.md)** - Herencia de
  `Msip::ModelosController`

#### **Vistas y Frontend**
- **[Vistas Automáticas](vistas-automaticas.md)** - Generación automática de
  interfaces
- **[Rutas, Controladores y Vistas](rutas-controladores-vistas.md)** -
  Personalización
- **[Punto de Montaje](punto-de-montaje.md)** - Configuración de rutas
- **[Recursos JavaScript y CSS](recursos-javascript-y-css.md)** - Gestión de
  assets
- **[Diseño Visual](diseño-visual-logo-y-favicon.md)** - Logo y favicon
- **[Temas de Colores](temas.md)** - Personalización visual
- **[ProSidebar y Iconos](diseño-visual-prosidebar.md)** - Navegación avanzada
- **[Stimulus Controllers](stimulus.md)** - Controladores modernos

#### **Internacionalización**
- **[Inflecciones en Español](inflecciones_espanol.md)** - Gramática y
  pluralización
- **[Internacionalización](internacionalizacion-nombres-campos-y-tablas.md)** -
  Nombres de campos/tablas
- **[Localización](localizacion-numeros-y-fechas.md)** - Formatos numéricos y de
  fecha
- **[Personalizaciones](personalizaciones_desarrolladores.md)** - Para
  desarrolladores

### 🧪 **Pruebas y Calidad**
- **[Aplicación de Prueba](aplicacion-de-prueba.md)** - Entorno de desarrollo
- **[Pruebas con Minitest](pruebas-con-minitest.md)** - Testing unitario
- **[Pruebas del Sistema](pruebas-al-sistema-con-puppeteer.md)** - Testing
  end-to-end

### 🔧 **Mantenimiento**
- **[Respaldo Cifrado](respaldo-cifrado.md)** - Configuración de backups
- **[Actualizaciones](https://gitlab.com/pasosdeJesus/msip/wiki)** - Wiki con
  guías de actualización

### 📐 **Convenciones y Modularidad**
- **[Convenciones de Código](convenciones.md)** - Estándares del proyecto
- **[Motores con msip](iniciar-motor-con-msip.md)** - Creación de motores
  derivados

## 🚀 Flujo de Aprendizaje Recomendado

1. **Comienza con**: [Requisitos](requisitos.md) → [Aplicación de
   Prueba](aplicacion-de-prueba.md)
2. **Primer proyecto**: [Iniciar un SI usando msip](iniciar-si-usando-msip.md) →
   [Ejemplo con Vistas Automáticas](ejemplo-con-vistas-automaticas.md)
3. **Profundización**: Explora las secciones según tus necesidades específicas

## 💡 ¿Necesitas Ayuda?

- Revisa la [aplicación de prueba](aplicacion-de-prueba.md) para ejemplos
  funcionales
- Consulta las [convenciones](convenciones.md) para estándares de código
- Utiliza el [wiki](https://gitlab.com/pasosdeJesus/msip/wiki) para
  actualizaciones

