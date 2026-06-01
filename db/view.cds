namespace poapplication.view;

using { poapplication.db.master, poapplication.db.transaction } from './Schema';

context views{

    define view ![POWorklist] as 
    select from transaction.PurchaseOrders {
        key PO_ID as ![PurchaseOrderID],
        key Items.PO_ITEMS_POS as ![PurchaseOrderItem],
        PARTNER_GUID.BP_ID as ![BusinessPartnerID],
        PARTNER_GUID.COMPANY_NAME as ![CompanyName],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        CURRENCY as ![Currency],
        OVERALL_STATUS as ![OverallStatus],
        LIFECYCLE_STATUS as ![LifecycleStatus],
        Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
        Items.PRODUCT_GUID.DESCRIPTION as ![ProductDescription],
        PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]


    }

    define view ![ItemView] as
    select from transaction.PurchaseItems {
        PARENT_KEY.PARTNER_GUID.NODE_KEY as ![CustomerKey],
        PRODUCT_GUID.NODE_KEY as ![ProductKey],
        CURRENCY as ![CurrencyCode],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as ![OverallStatus]
}

define view ![ProductView] as
    select from master.Products mixin {
        PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductKey = $self.ProductKey
       } into {
            NODE_KEY as ![ProductKey],
            DESCRIPTION as ![ProductDescription],
            CATEGORY as ![ProductCategory],
            PRICE as ![Price],
            SUPPLIER_GUID.BP_ID as ![SupplierId],
            SUPPLIER_GUID.COMPANY_NAME as ![SupplierName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            PO_ORDER as ![ToItems]
        }
}