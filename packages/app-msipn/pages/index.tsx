import React from 'react';

export default function Home() {
  return (
    <main style={{fontFamily: 'sans-serif', padding: '2rem'}}>
      <h1>Aplicación de Prueba msipn</h1>
      <p>Esta app consume el motor msipn (core + dominios) fuera de los workspaces.</p>
      <ul>
        <li>CLI disponible vía <code>pnpm run msipn</code></li>
        <li>Revise bin/msipn para comandos de base de datos.</li>
      </ul>
    </main>
  );
}
