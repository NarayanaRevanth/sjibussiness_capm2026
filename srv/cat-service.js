module.exports = cds.service.impl(async function () {
    /*
        There are three generic handlers for all CRUD operations on the "Purchase Orders" entity.
        1. this.before() - is called before the request is processed. This is used to validate the request and to modify the request data before it is processed( pre-checks / validations).
        2. this.on() - is called when the request is processed. This is used to implement the business logic for the request.
        3. this.after() - is called after the request is processed. This is used to modify the response data before it is sent back to the client.
    */

    // Step-1 : Get the object refrence from ODATA request
    const { EmployeeSrv, PurchaseItemSrv, PurchaseOrderSrv  } = this.entities;

    // Step-2 : We are using this.before() handler to validate the rquest.
    this.before('INSERT', EmployeeSrv, (request, response) => {
        console.log("Salary : ", request.data.salaryAmount);
        // Step-3 : We are validating the salary amount to be greater than 1000.
        if (request.data.salaryAmount > 60000) {
            // Step-4 : If the salary amount is less than 60000, we are throwing an error.
            request.error(400, "You are not allowed to insert the record with salary amount greater than 60000. Please get the approval from your line manager.");
        }
    })


    // Step-2 : We are using this.before() handler to validate the rquest.
    this.before('UPDATE', EmployeeSrv, (request, response) => {
        console.log("Salary : ", request.data.salaryAmount);
        console.log("Currency : ", request.data.Currency_code);
        // Step-3 : We are validating the salary amount to be greater than 1000.
        if (request.data.Currency_code = 'USD' && request.data.salaryAmount > 60000) {
            // Step-4 : If the salary amount is less than 60000, we are throwing an error.
            request.error(500, "You are not allowed to update the record with salary amount greater than 60000.");
        };
        if (request.data.Currency_code = 'EUR' && request.data.salaryAmount > 10000) {
            // Step-4 : If the salary amount is less than 60000, we are throwing an error.
            request.error(500, "You are not allowed to update the record with salary amount greater than 10000.");
        }
    })

    this.on('getHighestSalariedEmployee', async (request, response) => {
        try
        {
            const transaction = cds.tx(request);
            const response = await transaction.read(EmployeeSrv).orderBy({
                    salaryAmount: 'desc'
            }).limit(10);
            return response;
        }
        catch(error){
            return 'ERROR' + error.toString();
        }

    })

    //validation for post product
    const { ProductSrv } = this.entities;

    this.before('INSERT', ProductSrv, (request, response) => {
        console.log("Price : ", request.data.PRICE);
        // Step-3 : We are validating the PRICE to be greater than 1000.
        if (request.data.PRICE > 1000) 
        {
            // Step-4 : If the salary amount is less than 60000, we are throwing an error.
            request.error(400, "You are not allowed to insert the record with salary amount greater than 1000. Please get the approval from your line manager.");
        }
    })

    //get highest price product.
    this.on('getMostExpensiveProduct', async (request, response) => {
        try
        {
            console.log("Get Most Expensive Product");
            const transaction = cds.tx(request);
            const response = await transaction.read(ProductSrv).orderBy({
                    PRICE: 'desc'
            }).limit(10);
            return response;
        }
        catch(error){
            return 'ERROR' + error.toString();
        }

    })


    //get sum of items for given purchase order.
    /*this.on('getsumofitems_forPO', async (request, response) => {
        const poKey = request.params[0]; // Assuming the key is passed as a parameter in the URL
        try
        {
            console.log("Key :", request.params[0]);

            //poKey = request.params[0];
            // Fetch all PurchaseItems for this Purchase Order
            const items = await SELECT.from('poapplication.db.transaction.PurchaseItems')
            .columns('NET_AMOUNT', 'GROSS_AMOUNT', 'TAX_AMOUNT')
            .where({ PARENT_KEY_NODE_KEY : poKey.NODE_KEY });

            if (!items || items.length === 0) 
            {
                console.log("No items found for Purchase Order:", request.params[0]);
                 return 0;
            }
            // Sum up NET_AMOUNT (you can change to GROSS_AMOUNT if needed)
            let total = 0;
            for (const item of items)
            {
                const net = item.NET_AMOUNT || 0;
                total += net;
            }

            return total;

        }
        catch(error){
            return 'ERROR' + error.toString();
        }
    }) */

    this.on('getsumofitems_forPO', async (request, response) => {
        const poKey = request.params[0]; // Assuming the key is passed as a parameter in the URL
        try
        {
            let grossAmount = 0, netAmount = 0, taxAmount = 0;
            console.log("Key :", request.params[0]);

            //poKey = request.params[0];
            const transaction = cds.tx(request);
            // Fetch all PurchaseItems for this Purchase Order
            const sumOfItems = await transaction.run(
                SELECT.columns('GROSS_AMOUNT','NET_AMOUNT','TAX_AMOUNT').from(PurchaseItemSrv).where({ PARENT_KEY_NODE_KEY : poKey.NODE_KEY })
            )
            for (const item of sumOfItems) {
                grossAmount += parseInt(item.GROSS_AMOUNT);
                netAmount += parseInt(item.NET_AMOUNT);
                taxAmount += parseInt(item.TAX_AMOUNT);
            }
            return {grossAmount, netAmount, taxAmount};

        }
        catch(error){
            return 'ERROR' + error.toString();
        }
    })

    // Step-2 : Implementation of custom function using this.on() handler.
    this.on('discountPrice', async(request, response) => {
        try {
            const ID = request.params[0];
            //const discontedPercentage = request.data.discountPercentage;
        // Step-3: Create transaction and execute the query to get the highest salaried employee.
        const transaction = cds.tx(request);

        // Step-4 : Update purchase order with discounted price.
       await transaction.update(PurchaseOrderSrv).set({
            GROSS_AMOUNT: {
                '-=' : 1000
            },
            NET_AMOUNT: {
                '-=' : 800
            },
            TAX_AMOUNT: {
                '-=' : 200
            }
        }).where(ID)

        } catch (error) {
            return 'ERROR : ' + error.toString();
        }

    })

})