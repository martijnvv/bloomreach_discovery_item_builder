# Bloomreach Discovery Item Builder

This variable template is a no-code solution to create the correct object to use in the Bloomreach Discovery pageview tags to send data from GTM to Bloomreach about e-commerce products.
The structure is setup to work with the GA4 data structure out of the box. However, if you have a different array with e-commerce objects, you can assign the array and variable names you want to map to Bloomreach.

The items object is used in Bloomreach Discovery with the conversion event: [Official documentation](https://documentation.bloomreach.com/discovery/docs/conversion-page-view-pixel)
 
## Options to populate the item object
You can select the following options
* GA4 Standard Configuration (when you want to use the GA4 recommended dataLayer object format)
* Custom configuration (if you wish to use a different dataLayer format)

When selecting custom configuration, you are required to set all the required variables for the item object yourself
