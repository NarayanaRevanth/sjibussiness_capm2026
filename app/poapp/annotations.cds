using CatalogService as service from '../../srv/cat-service';

annotate service.PurchaseOrderSrv with @(
    UI.SelectionFields        : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem               : [
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
            $Type      : 'UI.DataField',
            Value      : LSC,
            Criticality: LSCRI
        },
        {
            $Type      : 'UI.DataField',
            Value      : OSC,
            Criticality: OSCRI
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        }
    ],
    UI.HeaderInfo             : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {
            Label: 'PO ID',
            Value: PO_ID
        },
        Description   : {
            Label: 'Company Name',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl      : 'https://pngimg.com/uploads/meta/meta_PNG5.png'
    },
    UI.Facets                 : [
        {
        $Type : 'UI.CollectionFacet',
        Label : 'Purchase Order Details',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'More details about the purchase order',
                Target: '@UI.FieldGroup#MoreDetails'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Amount details about the purchase order',
                Target: '@UI.FieldGroup#Amount'
            }
        ]
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'Additional Information',
        Target: 'Items/@UI.LineItem'
    }
    ],
    UI.FieldGroup #MoreDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: PO_ID
            },
            {
                $Type: 'UI.DataField',
                Value: PARTNER_GUID_NODE_KEY
            },
            {
                $Type      : 'UI.DataField',
                Value      : LSC,
                Criticality: LSCRI
            },
            {
                $Type      : 'UI.DataField',
                Value      : OSC,
                Criticality: OSCRI
            }
        ]
    },
    UI.FieldGroup #Amount     : {
        $Type: 'UI.FieldGroupType',
        Data : [
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
                $Type: 'UI.DataField',
                Value: CURRENCY_code
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
        ]
);