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
    offsetY: 37,
    offsetX: 59.953125,
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
    offsetY: 15,
    offsetX: 75.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Etiquetas'
      ],
      [
        '#div_contenido li:nth-of-type(4) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[4]/a'
      ],
      [
        'pierce/#div_contenido li:nth-of-type(4) > a'
      ],
      [
        'text/Etiquetas'
      ]
    ],
    offsetY: 14,
    offsetX: 33.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'thead td:nth-of-type(3)'
      ],
      [
        'xpath///*[@id="div_contenido"]/form/table/thead/tr[2]/td[3]'
      ],
      [
        'pierce/thead td:nth-of-type(3)'
      ]
    ],
    offsetY: 12.5,
    offsetX: 117.453125,
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
        'text/Nueva'
      ]
    ],
    offsetY: 23,
    offsetX: 29.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/etiquetas/nueva.%23%3CMsip::Etiqueta::ActiveRecord_Relation:0x00000892d479ad28%3E',
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
        '#etiqueta_nombre'
      ],
      [
        'xpath///*[@id="etiqueta_nombre"]'
      ],
      [
        'pierce/#etiqueta_nombre'
      ]
    ],
    offsetY: 13,
    offsetX: 205.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'etix',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#etiqueta_nombre'
      ],
      [
        'xpath///*[@id="etiqueta_nombre"]'
      ],
      [
        'pierce/#etiqueta_nombre'
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
    value: 'etix',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#etiqueta_observaciones'
      ],
      [
        'xpath///*[@id="etiqueta_observaciones"]'
      ],
      [
        'pierce/#etiqueta_observaciones'
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
        'xpath///*[@id="new_etiqueta"]/div[6]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 25,
    offsetX: 35.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/etiquetas/102',
        title: ''
      }
    ]
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
    offsetY: 385,
    offsetX: 55,
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
    offsetY: 13,
    offsetX: 74.5,
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
    offsetY: 4,
    offsetX: 51.453125,
  });
  await runner.runStep({
    type: 'change',
    value: 'etix',
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
    offsetY: 21,
    offsetX: 43.296875,
  });

}
  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Alt'
  });

  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Msip::Etiqueta eliminada.'
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
