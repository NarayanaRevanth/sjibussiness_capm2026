sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"poapplication/poapp/test/integration/pages/PurchaseOrderSrvList",
	"poapplication/poapp/test/integration/pages/PurchaseOrderSrvObjectPage",
	"poapplication/poapp/test/integration/pages/PurchaseItemSrvObjectPage"
], function (JourneyRunner, PurchaseOrderSrvList, PurchaseOrderSrvObjectPage, PurchaseItemSrvObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('poapplication/poapp') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSrvList: PurchaseOrderSrvList,
			onThePurchaseOrderSrvObjectPage: PurchaseOrderSrvObjectPage,
			onThePurchaseItemSrvObjectPage: PurchaseItemSrvObjectPage
        },
        async: true
    });

    return runner;
});

