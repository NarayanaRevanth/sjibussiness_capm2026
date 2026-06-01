namespace poapplication.db;

using { poapplication.reuse } from './reuse';

using { Currency, cuid } from '@sap/cds/common';

context master{
    entity BusinessPartners{
        key NODE_KEY : reuse.Guid;
        BP_ID : reuse.String32;
        BP_ROLE : reuse.Role;
        EMAIL:reuse.Email;
        MOBILE:reuse.PhoneNumber;
        FAX:reuse.String32;
        WEB:reuse.String255;
        COMPANY_NAME:reuse.String255;
        ADDRESS_GUID: Association to Addresses;
    }

    entity Addresses: reuse.Address{
        key NODE_KEY:reuse.Guid;
        ADDRESS_TYPE:reuse.String32;
        VAL_START:Date;
        VAL_END:Date;
        LATITUDE: Decimal;
        LONGITUDE:Decimal;
        businesspartner : Association to BusinessPartners on businesspartner.ADDRESS_GUID = $self;  }

    entity Products {
        key NODE_KEY      : reuse.Guid ;
        PRODUCT_ID        : reuse.String32;
        TYPE_CODE         : String(2);
        CATEGORY          : reuse.String255;
        DESCRIPTION       : reuse.String255;
        TAX_TARIF_CODE    : Integer;
        MEASURE_UNIT      : String(3);
        WEIGHT_MEASURE    : Decimal(5,2);
        WEIGHT_UNIT       : String(3);
        PRICE             : Decimal(15,2);
        CURRENCY_CODE     : Currency ;
        WIDTH             : Decimal(5,2);
        DEPTH             : Decimal(5,2);
        HEIGHT            : Decimal(5,2);
        DIM_UNIT          : String(2);

        // Managed Association with cardinality 1:1
        SUPPLIER_GUID     : Association to BusinessPartners ;
    }

    entity Employees : cuid {
        nameFirst        : reuse.String32;
        nameLast         : reuse.String32;
        nameInitials     : reuse.String32;
        nameMiddle       : reuse.String32;
        gender           : reuse.Gender;
        language         : String(2);
        loginName        : String(16);
        phoneNumber      : reuse.PhoneNumber ;
        email            : reuse.Email ;
        Currency         : Currency;
        salaryAmount     : reuse.AmountT ;
        accountNumber    : String(16);
        bankId           : String(16);
        bankName         : String(64);
    }


}

context transaction {

    entity PurchaseOrders : reuse.Amounts {
        key NODE_KEY   : reuse.Guid ;
        PO_ID          : reuse.Guid ;
        PARTNER_GUID   : Association to master.BusinessPartners ;
        LIFECYCLE_STATUS : String(1);
        OVERALL_STATUS : String(1);

        // Unmanaged Association with cardinality 1:n
        Items : Association to many PurchaseItems on Items.PARENT_KEY = $self ;
    }

    entity PurchaseItems : reuse.Amounts {
        key NODE_KEY   : reuse.Guid;
        PARENT_KEY     : Association to PurchaseOrders ;
        PO_ITEMS_POS   : Integer ;

        // Managed Association with cardinality 1:1
        PRODUCT_GUID   : Association to master.Products ;
    }

    

}

entity PurchaseOrderAndItemView
    as select from transaction.PurchaseOrders as orders
    inner join transaction.PurchaseItems as items on items.PARENT_KEY.NODE_KEY = orders.NODE_KEY
    {
        orders.PO_ID as PurchaseOrderID,
        orders.PARTNER_GUID.BP_ID as BusinessPartnerID,
        orders.PARTNER_GUID.COMPANY_NAME as companyName,
        orders.OVERALL_STATUS as overallStatus,
        items.PO_ITEMS_POS as PurchaseOrderItem,
        items.PRODUCT_GUID.PRODUCT_ID as ProductID,
        items.PRODUCT_GUID.DESCRIPTION as ProductDescription
    }
    
// entity Students {
//     key StudentID : Integer;
//     FirstName : String(50);
//     LastName : String(50);
//     Email : String(100);
//     DateOfBirth : Date;
//     class : Association to Classes;
// }

// entity Classes {
//     key ClassID : Integer;
//     ClassName : String(100);
//     TeacherName : String(100);
// }

// entity Books {
//     key BookID : Integer;
//     Title : String(200);
//     AuthorName : String(100);
//     PublicationYear : Integer;
//     ISBN : String(20);
//     AuthorID : Integer;
//     Author : Association to one Authors ;
// }

// entity Authors {
//     key AuthorID : Integer;
//     FirstName : String(50);
//     LastName : String(50);
//     BirthDate : Date;
// }