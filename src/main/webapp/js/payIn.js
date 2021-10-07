let customerOrderedArray = [];
let customerData = [];
let receiptData = [];
let paidOrderData = [];


//-- CREATE TABLE ROWS FOR PAID ORDERS --
function createPaidOrderRow(paidData) {
    let html = ``;
    console.log("paidata : ", paidData)
    paidData.forEach(paidOrder => {
            html += `<tr role="row" class="odd">
                            <td>` + paidOrder.py_id + `</td>
                            <td>` + paidOrder.cu_id.customerName + `</td>
                            <td>` + paidOrder.cu_id.customerSurname + `</td>
                            <td>` + paidOrder.ba_id + `</td> 
                            <td>` + paidOrder.py_DebtAmount + `</td>//toplam borç
                            <td>` + paidOrder.py_PaymentAmount + `</td> //ödeme tutarı
                            <td>` + paidOrder.py_RemainAmount + `</td> //kalan tutar
                            <td class="text-right">
                                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                    <button type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i>
                                    </button>
                                </div>
                            </td>
                         </tr>`;
        }
    )

    $('#paidOrderTable').html(html);
}

//---Get Customer Id on the orders---
function getCustomerIdList(data) {
    var found;
    data.forEach(order => {
        found = customerOrderedArray.find(item => item === order.cu_id)
        if (!found) {
            customerOrderedArray.push(order.cu_id);
        }
    })
    console.log(customerOrderedArray);
    mapCustomers(customerOrderedArray, customerData);
}

//---Get Orders---
function allOrders() {
    $.ajax({
        url: './orderAction-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            console.log("orderList : ", data);
            receiptData = data;
            getCustomerIdList(data);
        },
        error: function (err) {
            console.log(err)
        }
    })
}

//---Get All Customers---
function allCustomer() {
    $.ajax({
        url: './customer-get',
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            customerData = data;
            mapCustomers(data);
        },
        error: function (err) {
            console.log(err)
        }
    })

}

//---Get All Paid Orders---
function allPaidOrder() {
    $.ajax({
        url: './paidOrderServlet-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            console.log("paid orders : ", data);
            paidOrderData = data;

            paidOrderData.forEach(item => {
                var receipt = receiptData.find(receipt => receipt.boxAction_id == item.ba_id);

                if(receipt)
                {
                    item.ba_id = receipt.reciptNo;
                }

                var customer = customerData.find(customer => customer.cu_id == item.cu_id);
                if (customer) {
                    // console.log("a : ", a);
                    item.cu_id = {
                        customerName: customer.cu_name,
                        customerSurname: customer.cu_surname,
                    };
                }

            })
            createPaidOrderRow(paidOrderData);
        },
        error: function (err) {
            console.log(err)
        }
    })
}

//--CUSTOMER SELECT LIST MAPPING--
// customerOrderedArray : customer who ordered product
// customerData : All customer data

function mapCustomers(customerOrderedArray, customerData) {

    $.each(customerData, function (i, o) {
        var hasOrdered = customerOrderedArray.find(item => item == o.cu_id);
        // console.log("sipariş veren : ", hasOrdered);7
        if (hasOrdered) {
            $('#orderedCustomernames').append('<option value="' + o.cu_id + '">' + o.cu_name + " " + o.cu_surname + '</option>');
        }
    });
    $("#orderedCustomernames").selectpicker("refresh");
}

function bringReceipts(customerId) {
    $.each(receiptData, function (i, o) {
        if (customerId == o.cu_id) {
            $('#receiptname').append('<option value="' + o.boxAction_id + '">' + o.reciptNo + '</option>');
        }
    });
    $("#receiptname").selectpicker("refresh");
}

$('#orderedCustomernames').change(function () {
    console.log($(this).val())
    if ($(this).val() !== "default") {
        bringReceipts($(this).val());
    } else {
        $("#receiptname").val('default').selectpicker("refresh");
    }
});

$('#updatePayment').submit((event) => {
    event.preventDefault();

    const cu_id = $("#orderedCustomernames").val()
    const ba_id = $("#receiptname").val()
    const py_PaymentAmount = $("#payInAmount").val()
    const py_Detail = $("#payInDetail").val()

    const obj = {
        cu_id: cu_id,
        ba_id: ba_id,
        py_PaymentAmount: py_PaymentAmount,
        py_Detail: py_Detail,
    }
    console.log("obj : ",obj)
    $.ajax({
        url: './payin-post',
        type: 'POST',
        data: {obj: JSON.stringify(obj)},
        dataType: 'JSON',
        success: function (data) {
            if (data > 0) {
                console.log("data ;", data);
                alert("İşlem Başarılı");
                fncReset();
            } else {
                alert("İşlem sırasında hata oluştu.")
            }
        },
        error: function (err) {
            console.log(err)
            alert("İşlem işlemi sırısında bir hata oluştu!")
        }
    })
})
allCustomer();
allOrders();
allPaidOrder();



