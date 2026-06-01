namespace poapplication.reuse;
using { Currency } from '@sap/cds/common';

type Guid : UUID ;
type PhoneNumber : String32 ;
type Email : String255;
type Role : String(2);
type String32 : String(32);
type String255 : String(255);
type String50 : String(50);

//Enumerator
type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}

//Reuse for Amount
type AmountT : Decimal(15, 2) @(
    Scemantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

aspect Amounts{
    CURRENCY: Currency;
    GROSS_AMOUNT : AmountT;
    NET_AMOUNT : AmountT;
    TAX_AMOUNT : AmountT;
}

aspect Address{
    STREET : String255;
    CITY : String255;
    BUILDING : String255;
    POSTAL_CODE : String(12);
    COUNTRY : String255;
}
