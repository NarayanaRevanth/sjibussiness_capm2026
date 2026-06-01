using { poapplication.db.master as master, poapplication.db.transaction as transaction } from '../db/Schema';

type outputResponse : {
            totalGrossAmount : Decimal(15,2);
            totalNetAmount : Decimal(15,2);
            totalTaxAmount : Decimal(15,2);
        }

service CatalogService @(path : 'poapp'){

    entity EmployeeSrv as projection on master.Employees;

    entity ProductSrv as projection on master.Products ;

    entity AddressSrv as projection on master.Addresses ;

    entity BusinessPartnerSrv as projection on master.BusinessPartners ;

    entity PurchaseOrderSrv as projection on transaction.PurchaseOrders{
        *,
        case LIFECYCLE_STATUS
            when 'N' then 'New'
            when 'P' then 'In Process'
            when 'C' then 'Completed'
            else 'Unknown'
        end as LSC : String(20) @title : '{i18n>lifecycle_status}' ,
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            else 0
        end as LSCRI : Integer,

        case OVERALL_STATUS
            when 'O' then 'Open'
            when 'P' then 'Partially Delivered'
            when 'D'then 'Delivered'
            else 'Unknown'
        end as OSC : String(20) @title : '{i18n>overall_status}' ,
        case OVERALL_STATUS
            when 'O' then 1
            when 'P' then 2
            when 'D'then 3
            else 0
        end as OSCRI : Integer
    }
    actions
    {
        //function getsumofitems_forPO() returns Decimal(15,2);
        action discountPrice() ;//returns array of PurchaseOrderSrv;
        function getsumofitems_forPO() returns outputResponse;
    };

    entity PurchaseItemSrv as projection on transaction.PurchaseItems;

    function getHighestSalariedEmployee() returns array of EmployeeSrv;

    function getMostExpensiveProduct() returns array of ProductSrv;
}