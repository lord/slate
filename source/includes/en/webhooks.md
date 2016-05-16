# Notifications

Datil can send you a HTTP notification each time an e-document is issued. You can subscribe to this notifications by providing the URL where you want to receive the e-document data.

## Subscription

### Operation

`POST /webhooks`

### Request

> #### Example request

```shell
curl -v https://link.datil.co/webhooks \
-H "Content-Type: application/json" \
-H "X-Key: <your-api-key>" \
-H "X-Password: <your-certificate-password>" \
-d '{
  "event_name": "receipt-issued",
  "webhook_url": "http://www.b2b.com/ereceipts/receive"
}'
```

```python
import requests
cabeceras = {'x-key': '<your-api-key>'}
suscripcion = {
  "event_name": "receipt-issued",
  "webhook_url": "http://www.b2b.com/ereceipts/receive"}

respuesta = requests.post(
    'https://link.datil.co/webhooks',
    headers = cabeceras,
    data = json.dumps(suscripcion))
```

```c#
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DatilClient {
  class InvoicingServiceClient {
    static void Main(string[] args) {

      // Este ejemplo utiliza RestSharp
      // Para instalar anda al menú: tools > Library Package Manager > Package Manager Console
      // copia y pega y presiona enter: Install-Package RestSharp

      var client = new RestClient("https://link.datil.co/");
      var idFactura = "<id-factura>";
      var request = new RestRequest("invoices/" + idFactura, Method.POST);
      request.AddHeader("X-Key", "<your-api-key>");
      request.AddBody(@"{
        ""event_name"": "receipt-issued",
        ""webhook_url"": "http://www.b2b.com/ereceipts/receive"
      }");

      IRestResponse response = client.Execute(request);

      Console.WriteLine(response.Content);
    }
  }
}
```

Parameter | Type | Description
--------- | ------- | -----------
event_name | string | Valid values: `receipt-issued` o `issue-error`. __Requerido__
webhook_url | string | Your URL where notifications will be sent.  __Requerido__

The `receipt-issued` event is emitted when the issuance process finalizes successfully. These are the possible end states:

* AUTORIZADO (authorized)
* NO AUTORIZADO (not authorized)

The `issue-error` event is emitted when an error occurs in any of the issuance steps. These are the possible end states:

* CREADO (created)
* DEVUELTO (returned)

## Events

For each event, you will receive a *POST* request including the e-document in JSON format at the URL you registered `webhook_url`.

### Authorized

An *Authorized* e-document has the following format:

```
{
  "secuencial":1267,
  "fecha_emision":"2015-12-04T19:28:56.782Z",
  "emisor":{
    "ruc":"0992712554001",
    "obligado_contabilidad":true,
    "contribuyente_especial":"",
    "nombre_comercial":"Datilmedia",
    "razon_social":"Datilmedia S.A.",
    "direccion":"Kennedy Norte Av. Miguel H. Alcivar",
    "establecimiento":{
      "punto_emision":"002",
      "codigo":"001",
      "direccion":"Calle A"
    },
    "email":"clientes@datilmedia.com"
  },
  "guia_remision":"001-002-007654320",
  "tipo":"factura",
  "moneda":"USD",
  "id":"1ae2afaf6fed46dcabb14d424311e232",
  "informacion_adicional":{
    "Tiempo de entrega":"5 días"
  },
  "ambiente":1,
  "totales":{
    "total_sin_impuestos":4359.54,
    "impuestos":[
      {
        "base_imponible":0.0,
        "valor":0.0,
        "codigo":"2",
        "codigo_porcentaje":"0"
      },
      {
        "base_imponible":4359.54,
        "valor":523.14,
        "codigo":"2",
        "codigo_porcentaje":"2"
      }
    ],
    "importe_total":4882.68,
    "propina":0.0,
    "descuento":0.0
  },
  "comprador":{
    "identificacion":"0924447956001",
    "tipo_identificacion":"04",
    "razon_social":"Juan Antonio Plaza",
    "direccion":"Calle única Numero: S/N",
    "telefono":"046015159",
    "email":"jplazaarguello@gmail.com"
  },
  "tipo_emision":1,
  "items":[
    {
      "precio_unitario":7.01,
      "descripcion":"CEMENTO ROCA 50 KG. (1) 40U C/PALET",
      "precio_total_sin_impuestos":4359.54,
      "impuestos":[
        {
          "base_imponible":4359.54,
          "valor":523.14,
          "tarifa":12.0,
          "codigo":"2",
          "codigo_porcentaje":"2"
        }
      ],
      "detalles_adicionales":{
        "Peso":"5000.0000",
        "Volumen":"1 Gl"
      },
      "cantidad":622.0,
      "codigo_auxiliar":"CTO2",
      "descuento":0.0,
      "codigo_principal":"CTO1"
    }
  ],
  "version":"1.0.0",
  "clave_acceso":"0412201501099271255400110010020000012671994716611",
  "api-key":"abcxyz1234567890mnbvqwe321tyu653",
  "autorizacion":{
    "numero":"0412201516042509927125540010331009539",
    "fecha":"2015-12-04T16:04:25",
    "estado":"AUTORIZADO",
    "mensajes":[

    ]
  }
}
```

### Not authorized

A *Not authorized* e-document has the following format:


```
{
  "secuencial":1267,
  "fecha_emision":"2015-12-04T19:28:56.782Z",
  "emisor":{
    "ruc":"0992712554001",
    "obligado_contabilidad":true,
    "contribuyente_especial":"",
    "nombre_comercial":"Datilmedia",
    "razon_social":"Datilmedia S.A.",
    "direccion":"Kennedy Norte Av. Miguel H. Alcivar",
    "establecimiento":{
      "punto_emision":"002",
      "codigo":"001",
      "direccion":"Calle A"
    },
    "email":"clientes@datilmedia.com"
  },
  "guia_remision":"001-002-007654320",
  "tipo":"factura",
  "moneda":"USD",
  "id":"1ae2afaf6fed46dcabb14d424311e232",
  "informacion_adicional":{
    "Tiempo de entrega":"5 días"
  },
  "ambiente":1,
  "totales":{
    "total_sin_impuestos":4359.54,
    "impuestos":[
      {
        "base_imponible":0.0,
        "valor":0.0,
        "codigo":"2",
        "codigo_porcentaje":"0"
      },
      {
        "base_imponible":4359.54,
        "valor":523.14,
        "codigo":"2",
        "codigo_porcentaje":"2"
      }
    ],
    "importe_total":4882.68,
    "propina":0.0,
    "descuento":0.0
  },
  "comprador":{
    "identificacion":"0924447956001",
    "tipo_identificacion":"04",
    "razon_social":"Juan Antonio Plaza",
    "direccion":"Calle única Numero: S/N",
    "telefono":"046015159",
    "email":"jplazaarguello@gmail.com"
  },
  "tipo_emision":1,
  "items":[
    {
      "precio_unitario":7.01,
      "descripcion":"CEMENTO ROCA 50 KG. (1) 40U C/PALET",
      "precio_total_sin_impuestos":4359.54,
      "impuestos":[
        {
          "base_imponible":4359.54,
          "valor":523.14,
          "tarifa":12.0,
          "codigo":"2",
          "codigo_porcentaje":"2"
        }
      ],
      "detalles_adicionales":{
        "Peso":"5000.0000",
        "Volumen":"1 Gl"
      },
      "cantidad":622.0,
      "codigo_auxiliar":"CTO2",
      "descuento":0.0,
      "codigo_principal":"CTO1"
    }
  ],
  "version":"1.0.0",
  "clave_acceso":"0412201501099271255400110010020000012671994716611",
  "api-key":"abcxyz1234567890mnbvqwe321tyu653",
  "autorizacion": {
    "numero": "2907201515283909927125540017656314390",
    "fecha": "2015-09-28T19:28:56.782Z",
    "estado": "NO AUTORIZADO",
    "mensajes": [{
      "identificador": 46,
      "mensaje": "RUC NO EXISTE",
      "informacion_adicional": "El RUC debe tener 13 dígitos.",
      "tipo": "ERROR"
    }]
  }
}
```

### Returned

A *Returned* e-document has the following format:


```
{
  "secuencial":1267,
  "fecha_emision":"2015-12-04T19:28:56.782Z",
  "emisor":{
    "ruc":"0992712554001",
    "obligado_contabilidad":true,
    "contribuyente_especial":"",
    "nombre_comercial":"Datilmedia",
    "razon_social":"Datilmedia S.A.",
    "direccion":"Kennedy Norte Av. Miguel H. Alcivar",
    "establecimiento":{
      "punto_emision":"002",
      "codigo":"001",
      "direccion":"Calle A"
    },
    "email":"clientes@datilmedia.com"
  },
  "guia_remision":"001-002-007654320",
  "tipo":"factura",
  "moneda":"USD",
  "id":"1ae2afaf6fed46dcabb14d424311e231",
  "informacion_adicional":{
    "Tiempo de entrega":"5 días"
  },
  "ambiente":1,
  "totales":{
    "total_sin_impuestos":4359.54,
    "impuestos":[
      {
        "base_imponible":0.0,
        "valor":0.0,
        "codigo":"2",
        "codigo_porcentaje":"0"
      },
      {
        "base_imponible":4359.54,
        "valor":523.14,
        "codigo":"2",
        "codigo_porcentaje":"2"
      }
    ],
    "importe_total":4882.68,
    "propina":0.0,
    "descuento":0.0
  },
  "comprador":{
    "identificacion":"0924447956001",
    "tipo_identificacion":"04",
    "razon_social":"Juan Antonio Plaza",
    "direccion":"Calle única Numero: S/N",
    "telefono":"046015159",
    "email":"jplazaarguello@gmail.com"
  },
  "tipo_emision":1,
  "items":[
    {
      "precio_unitario":7.01,
      "descripcion":"CEMENTO ROCA 50 KG. (1) 40U C/PALET",
      "precio_total_sin_impuestos":4359.54,
      "impuestos":[
        {
          "base_imponible":4359.54,
          "valor":523.14,
          "tarifa":12.0,
          "codigo":"2",
          "codigo_porcentaje":"2"
        }
      ],
      "detalles_adicionales":{
        "Peso":"5000.0000",
        "Volumen":"1 Gl"
      },
      "cantidad":622.0,
      "codigo_auxiliar":"CTO2",
      "descuento":0.0,
      "codigo_principal":"CTO1"
    }
  ],
  "version":"1.0.0",
  "clave_acceso":"0412201501099271255400110010020000012671994716611",
  "api-key":"abcxyz1234567890mnbvqwe321tyu653",
  "envio_sri":{
    "estado":"DEVUELTA",
    "mensajes":[
      {
        "identificador":"35",
        "mensaje":"ARCHIVO NO CUMPLE ESTRUCTURA XML",
        "tipo":"ERROR",
        "informacion_adicional":"Se encontró el siguiente error en la estructura del comprobante: cvc-minLength-valid: Value '' with length = '0' is not facet-valid with respect to minLength '1' for type '#AnonType_valordetAdicionaldetallesAdicionalesdetalledetallesfactura'."
      }
    ]
  }
}
```

### Signature error

```
{
  "secuencial":766,
  "firma":{
    "result":"bad",
    "error":"Clave de firma incorrecta, por favor inténtalo nuevamente.",
    "status":400
  },
  "fecha_emision":"2015-12-16T15:38:01-05:00",
  "emisor":{
    "ruc":"1792478103001",
    "obligado_contabilidad":"true",
    "contribuyente_especial":"",
    "nombre_comercial":"Dátil",
    "razon_social":"Datilmedia S.A.",
    "direccion":"Guayaquil Ecuador",
    "establecimiento":{
      "punto_emision":"003",
      "codigo":"001",
      "direccion":"Av. Primera 123 y Calle 2da, Guayas, Guayaquil."
    },
    "email":"jplaza@datilmedia.com"
  },
  "tipo":"factura",
  "moneda":"USD",
  "id":"9d30f85b12435a007ba1235e5007d123",
  "informacion_adicional":null,
  "ambiente":2,
  "certificate-password":null,
  "totales":{
    "total_sin_impuestos":2,
    "impuestos":[
      {
        "base_imponible":2274.11,
        "valor":272.89,
        "codigo":"2",
        "codigo_porcentaje":"2"
      }
    ],
    "importe_total":2547.0,
    "propina":0,
    "descuento":0,
    "descuento_adicional":0
  },
  "comprador":{
    "email":"jplaza@datilmedia.com",
    "identificacion":"0924392929",
    "tipo_identificacion":"04",
    "razon_social":"Juan Antonio Plaza",
    "direccion":"Mall del Sol Piso 3, Guayaquil",
    "telefono":"099999119"
  },
  "tipo_emision":1,
  "items":[
    {
      "cantidad":1,
      "codigo_principal":"8806085980334",
      "precio_unitario":1,
      "descripcion":"TELEVISORES LED 3D SAMSUNG UN55H6400AHXPA",
      "precio_total_sin_impuestos":1,
      "impuestos":[
        {
          "base_imponible":1,
          "valor":0.12,
          "tarifa":12.0,
          "codigo":"2",
          "codigo_porcentaje":"2"
        }
      ],
      "descuento":0
    },
    {
      "cantidad":2,
      "codigo_principal":"8806085462113",
      "precio_unitario":600,
      "descripcion":"LED 46 UN46F5500 SMART SAMSUNG",
      "precio_total_sin_impuestos":1200.00,
      "impuestos":[
        {
          "base_imponible":1200.00,
          "valor":144,
          "tarifa":12,
          "codigo":"2",
          "codigo_porcentaje":"2"
        }
      ],
      "descuento":0
    }
  ],
  "clave_acceso":"1612201501179247810300120010030987657662795494211",
  "api-key":"1b123043215678b890ce7656780032ce"
}
```
