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
    offsetY: 35,
    offsetX: 74.453125,
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
    offsetY: 9,
    offsetX: 92.453125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Grupos'
      ],
      [
        'li:nth-of-type(7) > a'
      ],
      [
        'text/Grupos'
      ]
    ],
    offsetY: 9,
    offsetX: 39.5,
  });
  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Grupos'
      }
    ],
    target: 'main',
    selectors: [
      'h1'
    ]
  })


  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Nuevo'
      ],
      [
        '#div_contenido a'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/div[2]/div[2]/a'
      ],
      [
        'pierce/#div_contenido a'
      ],
      [
        'text/Nuevo'
      ]
    ],
    offsetY: 29,
    offsetX: 33
  });

  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#grupo_nombre'
      ],
      [
        'xpath///*[@id="grupo_nombre"]'
      ],
      [
        'pierce/#grupo_nombre'
      ]
    ],
    offsetY: 18,
    offsetX: 80,
  });
  await runner.runStep({
    type: 'change',
    value: 'grux',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#grupo_nombre'
      ],
      [
        'xpath///*[@id="grupo_nombre"]'
      ],
      [
        'pierce/#grupo_nombre'
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
    type: 'change',
    value: 'grux',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#grupo_observaciones'
      ],
      [
        'xpath///*[@id="grupo_observaciones"]'
      ],
      [
        'pierce/#grupo_observaciones'
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
        'xpath///*[@id="new_grupo"]/div[7]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 27,
    offsetX: 35,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/grupos/102',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Regresar'
      ],
      [
        '#div_contenido a:nth-of-type(1)'
      ],
      [
        'xpath///*[@id="div_contenido"]/div[5]/a[1]'
      ],
      [
        'pierce/#div_contenido a:nth-of-type(1)'
      ],
      [
        'text/Regresar'
      ]
    ],
    offsetY: 18,
    offsetX: 18,
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
    offsetY: 12,
    offsetX: 43,
  });
  await runner.runStep({
    type: 'change',
    value: 'grux',
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
          'xpath///*[@id="div_contenido"]/form/table/tbody/tr/td[7]/a[2]'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 27,
      offsetX: 72.796875,
    });
  }

  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Msip::Estadosol eliminado.'
      }
    ],
    target: 'main',
    selectors: [
      'div.alert',
      'xpath/*[@id="div_contenido"]/div[2]',
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
