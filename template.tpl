___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Bloomreach Discovery item builder",
  "description": "We populate the items in the order in the format for Bloomreach Discovery",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "Description",
    "displayName": "This variable returns an object with the following variables: \u003c/br\u003e \u003cul\u003e \u003cli\u003eproduct_id (item_id)\u003c/i\u003e \u003cli\u003esku (item_id)\u003c/i\u003e  \u003cli\u003ename (item_name)\u003c/i\u003e\u003cli\u003eprice (price)\u003c/i\u003e \u003cli\u003equantity (quantity)\u003c/i\u003e \u003c/ul\u003e\u003cbr/\u003e\nit is based on the standard setup of Bloomreach variables. The data is mapped based on the GA4 items object."
  },
  {
    "type": "TEXT",
    "name": "triggerEvent",
    "displayName": "What event should populate this variable?",
    "simpleValueType": true,
    "help": "This variable supports conversions only, so it\u0027s generally set to the purchase event",
    "defaultValue": "purchase"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const math = require('Math');
const getType = require('getType');


if(copyFromDataLayer('event', 2) == data.triggerEvent){
const mapProductData = i => {
  const itemObj = {
    prod_id: i.item_id,
    sku: i.item_id,
    name: i.item_name,
    price: i.price,
    quantity: i.quantity ? math.round(i.quantity) : i.quantity
  };
  return itemObj;
};


const eec = copyFromDataLayer('ecommerce', 1) || {};
if (getType(eec.items) === 'array') {
  return eec.items.map(i => {
    const product = mapProductData(i);
    return product;
  });
}
}else{
  return undefined;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 9-8-2024 16:42:55


