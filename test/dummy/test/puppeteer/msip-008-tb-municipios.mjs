import {
  preparar,
  prepararYAutenticarDeAmbiente,
  terminar
} from "@pasosdeJesus/pruebas_puppeteer"

(async () => {

  const tiempoini = performance.now()

  let timeout = 15000
  let urlini, runner, browser, page
  [urlini, runner, browser, page] = await prepararYAutenticarDeAmbiente(timeout, preparar)

  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Administrar'
      ],
      [
        '#navbarDropdownAdministrar'
      ],
      [
        'xpath///*[@id="navbarDropdownAdministrar"]'
      ],
      [
        'pierce/#navbarDropdownAdministrar'
      ],
      [
        'text/Administrar'
      ]
    ],
    offsetY: 13,
    offsetX: 23.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Tablas básicas'
      ],
      [
        'li:nth-of-type(4) > a'
      ],
      [
        'xpath///*[@id="navbarSupportedContent"]/ul[2]/li[2]/ul/li[4]/a'
      ],
      [
        'pierce/li:nth-of-type(4) > a'
      ],
      [
        'text/Tablas básicas'
      ]
    ],
    offsetY: 11,
    offsetX: 66.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Municipios'
      ],
      [
        'li:nth-of-type(8) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[8]/a'
      ],
      [
        'pierce/li:nth-of-type(8) > a'
      ],
      [
        'text/Municipios'
      ]
    ],
    offsetY: 9,
    offsetX: 65.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'form > div:nth-of-type(1) a'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/div[1]/div[1]/a'
      ],
      [
        'pierce/form > div:nth-of-type(1) a'
      ]
    ],
    offsetY: 24,
    offsetX: 51.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/municipios/nueva.%23%3CMsip::Municipio::ActiveRecord_Relation:0x00000f6741919b20%3E',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#municipio_nombre'
      ],
      [
        'xpath///*[@id="municipio_nombre"]'
      ],
      [
        'pierce/#municipio_nombre'
      ]
    ],
    offsetY: 13,
    offsetX: 203.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'mux',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#municipio_nombre'
      ],
      [
        'xpath///*[@id="municipio_nombre"]'
      ],
      [
        'pierce/#municipio_nombre'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Antioquia / Colombia'
      ],
      [
        '#municipio_departamento_id-opt-1'
      ],
      [
        'xpath///*[@id="municipio_departamento_id-opt-1"]'
      ],
      [
        'pierce/#municipio_departamento_id-opt-1'
      ]
    ],
    offsetY: 13,
    offsetX: 96.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Código dentro del departamento/estado'
      ],
      [
        '#municipio_munlocal_cod'
      ],
      [
        'xpath///*[@id="municipio_munlocal_cod"]'
      ],
      [
        'pierce/#municipio_munlocal_cod'
      ]
    ],
    offsetY: 19,
    offsetX: 67.5,
  });
  await runner.runStep({
    type: 'change',
    value: '10000',
    selectors: [
      [
        'aria/Código dentro del departamento/estado'
      ],
      [
        '#municipio_munlocal_cod'
      ],
      [
        'xpath///*[@id="municipio_munlocal_cod"]'
      ],
      [
        'pierce/#municipio_munlocal_cod'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'change',
    value: '10000',
    selectors: [
      [
        'aria/Código secundario del país'
      ],
      [
        '#municipio_codreg'
      ],
      [
        'xpath///*[@id="municipio_codreg"]'
      ],
      [
        'pierce/#municipio_codreg'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Tab'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Tab',
    target: 'main'
  });
  await runner.runStep({
    type: 'change',
    value: 'obs',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#municipio_observaciones'
      ],
      [
        'xpath///*[@id="municipio_observaciones"]'
      ],
      [
        'pierce/#municipio_observaciones'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Crear'
      ],
      [
        'div.form-actions > input'
      ],
      [
        'xpath///*[@id="new_municipio"]/div[13]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 11,
    offsetX: 36.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/municipios/100002',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'dd:nth-of-type(4)'
      ],
      [
        'xpath///*[@id="div_contenido"]/dl/dd[4]'
      ],
      [
        'pierce/dd:nth-of-type(4)'
      ],
      [
        'text/Antioquia / Colombia'
      ]
    ],
    offsetY: 4,
    offsetX: 198.5,
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: ' '
  });
  await runner.runStep({
    type: 'keyUp',
    key: ' ',
    target: 'main'
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Regresar'
      ],
      [
        'div.form-actions > a:nth-of-type(1)'
      ],
      [
        'xpath///*[@id="div_contenido"]/div[5]/a[1]'
      ],
      [
        'pierce/div.form-actions > a:nth-of-type(1)'
      ],
      [
        'text/Regresar'
      ]
    ],
    offsetY: 12,
    offsetX: 44.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        '#filtro_busnombre'
      ],
      [
        'xpath///*[@id="filtro_busnombre"]'
      ],
      [
        'pierce/#filtro_busnombre'
      ]
    ],
    offsetY: 7,
    offsetX: 76.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'mux',
    selectors: [
      [
        '#filtro_busnombre'
      ],
      [
        'xpath///*[@id="filtro_busnombre"]'
      ],
      [
        'pierce/#filtro_busnombre'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Enter'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Enter',
    target: 'main'
  });

  {
    const targetPage = page
    const promises = []; 
    promises.push(targetPage.waitForNavigation())

    targetPage.on('dialog', async dialog => {
      console.log(dialog.message())
      await dialog.accept(); //dismiss()
    })
    await runner.runStep({
      type: 'click',
      target: 'main',
      selectors: [
        [
          'aria/Eliminar'
        ],
        [
          'a.btn-danger'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 19,
      offsetX: 23.890625,
    });
  }

  debugger

  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        title: 'Msip::Municipio eliminado.'
      }
    ],
    target: 'main',
    selectors: [
      'div.alert',
      'pierce/div.alert'
    ]
  })

  await terminar(runner)

  const tiempofin = performance.now();
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
