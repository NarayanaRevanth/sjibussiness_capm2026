using CatalogService as service from '../../srv/cat-service';

annotate service.PurchaseOrderSrv with @(
        UI.SelectionFields: [
                PO_ID,
                GROSS_AMOUNT,
                PARTNER_GUID.COMPANY_NAME,
                PARTNER_GUID.ADDRESS_GUID.COUNTRY
        ],
        UI.LineItem       : [
                {
                        $Type: 'UI.DataField',
                        Value: PO_ID
                },
                {
                        $Type: 'UI.DataField',
                        Value: PARTNER_GUID.COMPANY_NAME
                },
                {
                        $Type: 'UI.DataField',
                        Value: PARTNER_GUID.BP_ID
                },
                {
                        $Type: 'UI.DataField',
                        Value: GROSS_AMOUNT
                },
                {
                        $Type: 'UI.DataField',
                        Value: NET_AMOUNT
                },
                {
                        $Type: 'UI.DataField',
                        Value: TAX_AMOUNT
                },
                {
                        $Type : 'UI.DataFieldForAction',
                        Action: 'CatalogService.discountPrice',
                        Label : 'Apply Discount',
                        Inline: false
                },
                {
                        $Type: 'UI.DataField',
                        Value: LSC,
                        Criticality: LSCRI
                },
                {
                        $Type: 'UI.DataField',
                        Value: OSC,
                        Criticality: OSCRI
                },
                {
                        $Type: 'UI.DataField',
                        Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
                }
        ],
        UI.HeaderInfo : {
                TypeName: 'Purchase Order',
                TypeNamePlural: 'Purchase Orders',
                Title: {
                        Label: 'PO ID',
                        Value: PO_ID
                },
                Description: {
                        Label : 'Company Name',
                        Value: PARTNER_GUID.COMPANY_NAME
                },
                ImageUrl: 'https://pngimg.com/uploads/meta/meta_PNG5.png'
        },
        UI.Facets : [
                {
                        $Type: 'UI.CollectionFacet',
                        Label : 'Purchase Order Details',
                        Facets : [
                                {
                                        $Type : 'UI.ReferenceFacet',
                                        Label : 'More details about the purchase order',
                                        Target: '@UI.FieldGroup#MoreDetails'
                                },
                                {
                                        $Type: 'UI.ReferenceFacet',
                                        Label : 'Amount details about the purchase order',
                                        Target : '@UI.FieldGroup#Amount'
                                }
                        ]
                },
                {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Items of the purchase order',
                        Target : 'Items/@UI.LineItem'
                }
        ],
        UI.FieldGroup #MoreDetails: {
                $Type : 'UI.FieldGroupType',
                Data : [
                        {
                                $Type : 'UI.DataField',
                                Value : PO_ID
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PARTNER_GUID_NODE_KEY
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : LSC,
                                Criticality : LSCRI
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : OSC,
                                Criticality : OSCRI
                        }
                ]
        },
        UI.FieldGroup #Amount: {
                $Type : 'UI.FieldGroupType',
                Data : [
                        {
                                $Type : 'UI.DataField',
                                Value : GROSS_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : NET_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : TAX_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : CURRENCY_code
                        }
                ]
        }
);

annotate service.PurchaseItemSrv with @(
        UI.LineItem : [
                {
                        $Type: 'UI.DataField',
                        Value: PO_ITEMS_POS
                },
                {
                        $Type: 'UI.DataField',
                        Value: PRODUCT_GUID_NODE_KEY
                },
                {
                        $Type: 'UI.DataField',
                        Value: PRODUCT_GUID.PRODUCT_ID
                },
                {
                        $Type: 'UI.DataField',
                        Value: GROSS_AMOUNT
                },
                {
                        $Type: 'UI.DataField',
                        Value: NET_AMOUNT
                },
                {
                        $Type: 'UI.DataField',
                        Value: TAX_AMOUNT
                }
        ],
        UI.HeaderInfo : {
                TypeName: 'Purchse Item',
                TypeNamePlural: 'Purchase Items',
                Title : {
                        $Type : 'UI.DataField',
                        Value : PO_ITEMS_POS
                },
                Description : {
                        $Type : 'UI.DataField',
                        Value : PRODUCT_GUID.DESCRIPTION
                },
                ImageUrl: 'https://pngimg.com/uploads/meta/meta_PNG5.png'
        },
        UI.Facets : [
                {
                        $Type : 'UI.CollectionFacet',
                        Label : 'Product and Item Details',
                        Facets : [
                                {
                                        $Type : 'UI.ReferenceFacet',
                                        Label : 'Item - Price Information',
                                        Target: '@UI.FieldGroup#ItemPriceInformation'
                                },
                                {
                                        $Type: 'UI.ReferenceFacet',
                                        Label : 'Product - Details',
                                        Target : '@UI.FieldGroup#ProductDetails'
                                }
                        ]
                }
        ],
        UI.FieldGroup #ItemPriceInformation: {
                $Type : 'UI.FieldGroupType',
                Data : [
                        {
                                $Type : 'UI.DataField',
                                Value : PO_ITEMS_POS
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : GROSS_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : NET_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : TAX_AMOUNT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : CURRENCY_code
                        }
                ]
        },
        UI.FieldGroup #ProductDetails : {
                $Type : 'UI.FieldGroupType',
                Data : [
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.PRODUCT_ID
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.DESCRIPTION
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.CATEGORY
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.TAX_TARIF_CODE
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.PRICE
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.CURRENCY_CODE
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.WEIGHT_MEASURE
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.WEIGHT_UNIT
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.WIDTH
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.DEPTH
                        },
                        {
                                $Type : 'UI.DataField',
                                Value : PRODUCT_GUID.HEIGHT
                        }

                ]
        },
);