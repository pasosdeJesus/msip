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
    offsetX: 51.953125,
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
    offsetY: 22,
    offsetX: 58.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Sectores de organizaciones sociales'
      ],
      [
        'li:nth-of-type(12) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[12]/a'
      ],
      [
        'pierce/li:nth-of-type(12) > a'
      ],
      [
        'text/Sectores de organizaciones'
      ]
    ],
    offsetY: 7,
    offsetX: 137.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Nuevo'
      ],
      [
        'div:nth-of-type(2) a'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/div[2]/div[2]/a'
      ],
      [
        'pierce/div:nth-of-type(2) a'
      ],
      [
        'text/Nuevo'
      ]
    ],
    offsetY: 21,
    offsetX: 20,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/sectoresorgsocial/nueva.%23%3CMsip::Sectororgsocial::ActiveRecord_Relation:0x00000f66e02eeba8%3E',
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
        '#sectororgsocial_nombre'
      ],
      [
        'xpath///*[@id="sectororgsocial_nombre"]'
      ],
      [
        'pierce/#sectororgsocial_nombre'
      ]
    ],
    offsetY: 17,
    offsetX: 293,
  });
  await runner.runStep({
    type: 'change',
    value: 'sectorx',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#sectororgsocial_nombre'
      ],
      [
        'xpath///*[@id="sectororgsocial_nombre"]'
      ],
      [
        'pierce/#sectororgsocial_nombre'
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
    value: 'sectorx',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#sectororgsocial_observaciones'
      ],
      [
        'xpath///*[@id="sectororgsocial_observaciones"]'
      ],
      [
        'pierce/#sectororgsocial_observaciones'
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
        'xpath///*[@id="new_sectororgsocial"]/div[6]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 19,
    offsetX: 42,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/sectoresorgsocial/103',
        title: ''
      }
    ]
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
          'xpath///*[@id="div_contenido"]/div[5]/a[3]'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 25,
      offsetX: 59.25,
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
