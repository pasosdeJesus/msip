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
    offsetY: 24,
    offsetX: 57.953125
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
    offsetY: 17,
    offsetX: 78.953125
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Fuentes de prensa'
      ],
      [
        '#div_contenido li:nth-of-type(6) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[6]/a'
      ],
      [
        'pierce/#div_contenido li:nth-of-type(6) > a'
      ],
      [
        'text/Fuentes de prensa'
      ]
    ],
    offsetY: 9,
    offsetX: 58.5
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Filtrar[role="gridcell"]'
      ],
      [
        'thead td:nth-of-type(6)'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/table/thead/tr[2]/td[6]'
      ],
      [
        'pierce/thead td:nth-of-type(6)'
      ]
    ],
    offsetY: 27.5,
    offsetX: 147.34375
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
        'div.col-sm-2 > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/div[2]/div[2]/a'
      ],
      [
        'pierce/div.col-sm-2 > a'
      ]
    ],
    offsetY: 16,
    offsetX: 58.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/fuentesprensa/nueva.%23%3CMsip::Fuenteprensa::ActiveRecord_Relation:0x0000089238c14260%3E',
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
        '#fuenteprensa_nombre'
      ],
      [
        'xpath///*[@id="fuenteprensa_nombre"]'
      ],
      [
        'pierce/#fuenteprensa_nombre'
      ]
    ],
    offsetY: 5,
    offsetX: 284.5
  });
  await runner.runStep({
    type: 'change',
    value: 'fuex',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#fuenteprensa_nombre'
      ],
      [
        'xpath///*[@id="fuenteprensa_nombre"]'
      ],
      [
        'pierce/#fuenteprensa_nombre'
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
    value: '',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#fuenteprensa_observaciones'
      ],
      [
        'xpath///*[@id="fuenteprensa_observaciones"]'
      ],
      [
        'pierce/#fuenteprensa_observaciones'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Backspace'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Backspace',
    target: 'main'
  });
  await runner.runStep({
    type: 'change',
    value: 'fuex',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#fuenteprensa_observaciones'
      ],
      [
        'xpath///*[@id="fuenteprensa_observaciones"]'
      ],
      [
        'pierce/#fuenteprensa_observaciones'
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
        'xpath///*[@id="new_fuenteprensa"]/div[6]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 17,
    offsetX: 45.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/fuentesprensa/101',
        title: ''
      }
    ]
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
    offsetY: 30,
    offsetX: 38.5
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
    offsetY: 22,
    offsetX: 77.25
  });
  await runner.runStep({
    type: 'change',
    value: 'fuex',
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
          'xpath///*[@id="div_contenido"]/form/table/tbody/tr/td[6]/a[2]'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 22,
      offsetX: 43.296875
    });
  }

  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Msip::Fuenteprensa eliminada.'
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
