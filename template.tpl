___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "categories": ["bloomreach", bloomreach discovery],
  "securityGroups": [],
  "displayName": "Bloomreach Discovery Item Builder",
  "description": "We populate the items in the order in the format for Bloomreach Discovery based on the \u003ca href\u003d\"\u003ca href\u003d\"https://documentation.bloomreach.com/discovery/docs/add-to-cart-atc\"\u003eofficial documentation\u003c/a\u003e",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "Description",
    "displayName": "\u003cstrong\u003eDescription\u003c/strong\u003e\n\u003cp\u003eThis variable returns an object with the following variables: \u003c/br\u003e \u003cul\u003e \u003cli\u003eproduct_id (item_id)\u003c/i\u003e \u003cli\u003esku (item_id)\u003c/i\u003e  \u003cli\u003ename (item_name)\u003c/i\u003e\u003cli\u003eprice (price)\u003c/i\u003e \u003cli\u003equantity (quantity)\u003c/i\u003e \u003c/ul\u003e\u003cbr/\u003e\nIt is based on the standard setup of Bloomreach Discovery variables, from their \u003ca href\u003d\"\u003ca href\u003d\"https://documentation.bloomreach.com/discovery/docs/add-to-cart-atc-pixel#at\"\u003eofficial documentation\u003c/a\u003e.  The data is mapped based on the GA4 items object by default.\u003c/p\u003e"
  },
  {
    "type": "RADIO",
    "name": "configType",
    "displayName": "Type of configuration",
    "radioItems": [
      {
        "value": "ga4Standard",
        "displayValue": "GA4 Standard Configuration"
      },
      {
        "value": "custom",
        "displayValue": "Custom Configuration"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "Standard Configuration",
    "displayName": "Standard Configuration",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "ga4Standard",
        "checkboxText": "Use the GA4 standard mapping as described above",
        "simpleValueType": true,
        "defaultValue": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "configType",
        "paramValue": "ga4Standard123",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "customConfig",
    "displayName": "Custom Configuration",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "arrayName",
        "displayName": "Object  to collect data from (this is a variable in GTM)",
        "simpleValueType": true,
        "help": "This is the ecommerce.items array in GA4 standard setup"
      },
      {
        "type": "TEXT",
        "name": "prod_id",
        "displayName": "product_id variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "sku",
        "displayName": "sku variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "name",
        "displayName": "name variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "price",
        "displayName": "price variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "quantity",
        "displayName": "quantity variable to map",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "configType",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const math = require('Math');
const getType = require('getType');
const log = require('logToConsole');
var configType = data.configType;

//log('configType = ' + configType);

if(data.configType === 'ga4Standard'){
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
return [];  
  
}else if(configType === 'custom'){
  var br_prod_id = data.prod_id;
  var br_sku = data.sku;
  var br_item_name = data.item_name;  
  var br_price = data.price;  
  var br_quantity = data.quantity;    
  
  const mapProductData = i => {
  const itemObj = {
    prod_id: i.data.prod_id,
    sku: i.data.sku,
    name: i.data.name,
    price: i.data.price,
    quantity: i.data.quantity ? math.round(i.data.quantity) : i.data.quantity
  };
  log(itemObj);  
  return itemObj;
};
const eec = copyFromDataLayer(data.arrayName, 1) || {};
 log(eec); 
if (getType(eec.items) === 'array') {
  return eec.map(i => {
    const product = mapProductData(i);
    return product;
  });
}
return [];  
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
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 9-8-2024 16:42:55


