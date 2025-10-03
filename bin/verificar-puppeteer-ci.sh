#!/bin/sh
# Script para verificar la configuración de Puppeteer en CI con OpenBSD

echo "=== Verificador de configuración Puppeteer CI para OpenBSD ==="
echo

# Verificar variables de ambiente
echo "1. Variables de ambiente CI:"
echo "   CI = ${CI:-'no definida'}"
echo "   CONCABEZA = ${CONCABEZA:-'no definida'}"
echo "   IPDES = ${IPDES:-'no definida'}"
echo "   PUERTOPRU = ${PUERTOPRU:-'no definida'}"
echo

# Verificar navegadores disponibles
echo "2. Navegadores disponibles:"
if [ -x "/usr/local/bin/chrome" ]; then
    echo "   ✅ Chrome encontrado en /usr/local/bin/chrome"
    /usr/local/bin/chrome --version 2>/dev/null || echo "      (Error al obtener versión)"
else
    echo "   ❌ Chrome no encontrado en /usr/local/bin/chrome"
fi

if [ -x "/usr/local/bin/chromium" ]; then
    echo "   ✅ Chromium encontrado en /usr/local/bin/chromium"
    /usr/local/bin/chromium --version 2>/dev/null || echo "      (Error al obtener versión)"
else
    echo "   ❌ Chromium no encontrado en /usr/local/bin/chromium"
fi

if [ -x "/usr/bin/chromium-browser" ]; then
    echo "   ✅ Chromium-browser encontrado en /usr/bin/chromium-browser"
else
    echo "   ❌ Chromium-browser no encontrado en /usr/bin/chromium-browser"
fi
echo

# Verificar modo headless de Chromium
echo "3. Prueba de modo headless:"
if [ -x "/usr/local/bin/chromium" ]; then
    echo "   Probando Chromium en modo headless..."
    if /usr/local/bin/chromium --headless --disable-gpu --dump-dom about:blank 2>/dev/null | head -1 | grep -q "html"; then
        echo "   ✅ Modo headless funciona correctamente"
    else
        echo "   ❌ Problema con modo headless"
    fi
elif [ -x "/usr/local/bin/chrome" ]; then
    echo "   Probando Chrome en modo headless..."
    if /usr/local/bin/chrome --headless --disable-gpu --dump-dom about:blank 2>/dev/null | head -1 | grep -q "html"; then
        echo "   ✅ Modo headless funciona correctamente"
    else
        echo "   ❌ Problema con modo headless"
    fi
else
    echo "   ❌ No hay navegador disponible para probar"
fi
echo

# Verificar dependencias de Puppeteer
echo "4. Dependencias JavaScript:"
if [ -f "pruebas_puppeteer/package.json" ]; then
    echo "   ✅ package.json encontrado"
    if [ -d "pruebas_puppeteer/node_modules" ]; then
        echo "   ✅ node_modules instalado"
    else
        echo "   ❌ node_modules no encontrado - ejecutar 'yarn install'"
    fi
else
    echo "   ❌ package.json no encontrado"
fi
echo

# Verificar configuración de la aplicación
echo "5. Configuración de la aplicación:"
if [ -f "test/dummy/.env" ]; then
    echo "   ✅ Archivo .env encontrado"
    echo "   Variables de BD configuradas:"
    grep "^BD_" test/dummy/.env | sed 's/^/     /'
else
    echo "   ❌ Archivo .env no encontrado en test/dummy"
fi
echo

# Verificar estado de la base de datos
echo "6. Estado de la base de datos:"
if command -v psql >/dev/null 2>&1; then
    if psql -U rails -d rails_test -c "SELECT 1;" >/dev/null 2>&1; then
        echo "   ✅ Conexión a base de datos exitosa"
    else
        echo "   ❌ Error de conexión a base de datos"
    fi
else
    echo "   ❌ psql no disponible"
fi
echo

echo "=== Verificación completada ==="
echo
echo "Recomendaciones:"
echo "- En CI, la variable CI estará definida automáticamente"
echo "- No definir CONCABEZA para usar modo headless por defecto"
echo "- Asegurar que Chromium 7.7+ esté instalado para soporte headless"
echo "- Verificar que PostgreSQL esté corriendo y configurado"