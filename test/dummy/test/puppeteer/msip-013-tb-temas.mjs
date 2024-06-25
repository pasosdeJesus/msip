
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
    offsetY: 15,
    offsetX: 89.453125,
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
    offsetX: 77.453125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Temas'
      ],
      [
        'li:nth-of-type(13) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[13]/a'
      ],
      [
        'pierce/li:nth-of-type(13) > a'
      ],
      [
        'text/Temas'
      ]
    ],
    offsetY: 12,
    offsetX: 34.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Nombre'
      ],
      [
        'th:nth-of-type(2)'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/table/thead/tr[1]/th[2]'
      ],
      [
        'pierce/th:nth-of-type(2)'
      ],
      [
        'text/Nombre'
      ]
    ],
    offsetY: 156,
    offsetX: 54.5,
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
    offsetY: 30,
    offsetX: 47.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/temas/nueva.%23%3CMsip::Tema::ActiveRecord_Relation:0x00000f663a9da828%3E',
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
        '#tema_nombre'
      ],
      [
        'xpath///*[@id="tema_nombre"]'
      ],
      [
        'pierce/#tema_nombre'
      ]
    ],
    offsetY: 10,
    offsetX: 187.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'temax',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#tema_nombre'
      ],
      [
        'xpath///*[@id="tema_nombre"]'
      ],
      [
        'pierce/#tema_nombre'
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
        'aria/Fondo'
      ],
      [
        '#tema_fondo'
      ],
      [
        'xpath///*[@id="tema_fondo"]'
      ],
      [
        'pierce/#tema_fondo'
      ]
    ],
    offsetY: 9,
    offsetX: 54.5,
  });
  await runner.runStep({
    type: 'change',
    value: '#ab3f99',
    selectors: [
      [
        'aria/Fondo'
      ],
      [
        '#tema_fondo'
      ],
      [
        'xpath///*[@id="tema_fondo"]'
      ],
      [
        'pierce/#tema_fondo'
      ]
    ],
    target: 'main'
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'body'
      ],
      [
        'xpath//html/body'
      ],
      [
        'pierce/body'
      ]
    ],
    offsetY: 388,
    offsetX: 48,
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
        'aria/Observaciones'
      ],
      [
        '#tema_observaciones'
      ],
      [
        'xpath///*[@id="tema_observaciones"]'
      ],
      [
        'pierce/#tema_observaciones'
      ]
    ],
    offsetY: 21,
    offsetX: 41.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'temax',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#tema_observaciones'
      ],
      [
        'xpath///*[@id="tema_observaciones"]'
      ],
      [
        'pierce/#tema_observaciones'
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
        'xpath///*[@id="new_tema"]/div[27]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 15,
    offsetX: 35.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/temas/104',
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
    type: 'keyDown',
    target: 'main',
    key: ' '
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: ' '
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: ' '
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: ' '
  });
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: ' '
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
          'xpath///*[@id="div_contenido"]/div[5]/a[4]'
        ],
        [
          'pierce/a.btn-danger'
        ],
        [
          'text/Eliminar'
        ]
      ],
      offsetY: 24,
      offsetX: 37.953125,
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
