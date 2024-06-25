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
    offsetY: 27,
    offsetX: 53.453125,
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
    offsetY: 8,
    offsetX: 78.453125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Departamentos/Estados'
      ],
      [
        '#div_contenido li:nth-of-type(2) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[2]/a'
      ],
      [
        'pierce/#div_contenido li:nth-of-type(2) > a'
      ],
      [
        'text/Departamentos/Estados'
      ]
    ],
    offsetY: 3,
    offsetX: 141.5,
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
    offsetY: 10,
    offsetX: 34.5,
    assertedEvents: [
      {
        type: 'navigation'
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
        '#departamento_nombre'
      ],
      [
        'xpath///*[@id="departamento_nombre"]'
      ],
      [
        'pierce/#departamento_nombre'
      ]
    ],
    offsetY: 20,
    offsetX: 156.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'x',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#departamento_nombre'
      ],
      [
        'xpath///*[@id="departamento_nombre"]'
      ],
      [
        'pierce/#departamento_nombre'
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
    value: 'col',
    selectors: [
      [
        'aria/País *[role="combobox"]'
      ],
      [
        '#departamento_pais_id-ts-control'
      ],
      [
        'xpath///*[@id="departamento_pais_id-ts-control"]'
      ],
      [
        'pierce/#departamento_pais_id-ts-control'
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
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Código dentro del país'
      ],
      [
        '#departamento_deplocal_cod'
      ],
      [
        'xpath///*[@id="departamento_deplocal_cod"]'
      ],
      [
        'pierce/#departamento_deplocal_cod'
      ]
    ],
    offsetY: 19,
    offsetX: 46.5,
  });
  await runner.runStep({
    type: 'change',
    value: '10000',
    selectors: [
      [
        'aria/Código dentro del país'
      ],
      [
        '#departamento_deplocal_cod'
      ],
      [
        'xpath///*[@id="departamento_deplocal_cod"]'
      ],
      [
        'pierce/#departamento_deplocal_cod'
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
        '#departamento_codreg'
      ],
      [
        'xpath///*[@id="departamento_codreg"]'
      ],
      [
        'pierce/#departamento_codreg'
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
    value: '1',
    selectors: [
      [
        'aria/Latitud'
      ],
      [
        '#departamento_latitud'
      ],
      [
        'xpath///*[@id="departamento_latitud"]'
      ],
      [
        'pierce/#departamento_latitud'
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
    value: '1',
    selectors: [
      [
        'aria/Longitud'
      ],
      [
        '#departamento_longitud'
      ],
      [
        'xpath///*[@id="departamento_longitud"]'
      ],
      [
        'pierce/#departamento_longitud'
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
        'aria/Crear'
      ],
      [
        'div.form-actions > input'
      ],
      [
        'xpath///*[@id="new_departamento"]/div[11]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 8,
    offsetX: 35.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/departamentos/10001',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'dt:nth-of-type(3)'
      ],
      [
        'xpath///*[@id="div_contenido"]/dl/dt[3]'
      ],
      [
        'pierce/dt:nth-of-type(3)'
      ]
    ],
    offsetY: 12,
    offsetX: 50.5,
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
    offsetY: 23,
    offsetX: 60.5,
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
    offsetY: 35,
    offsetX: 42.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'x',
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
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/10001[role="link"]'
      ],
      [
        'td:nth-of-type(1) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/table/tbody/tr/td[1]/a'
      ],
      [
        'pierce/td:nth-of-type(1) > a'
      ],
      [
        'text/10001'
      ]
    ],
    offsetY: 12,
    offsetX: 30.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'dd:nth-of-type(5)'
      ],
      [
        'xpath///*[@id="div_contenido"]/dl/dd[5]'
      ],
      [
        'pierce/dd:nth-of-type(5)'
      ]
    ],
    offsetY: 0,
    offsetX: 200.5,
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
          'xpath///*[@id="div_contenido"]/div[4]/a[3]'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 30,
      offsetX: 40.75,
    });
  }

  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Msip::Departamento eliminado.'
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

