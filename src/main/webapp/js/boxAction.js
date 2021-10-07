var productData = [];
var boxActionData = [];
var customerData = [];
function orderDelete(boxAction_id) {

    let answer = confirm("Siparişi Silmek İstediğinizden Emin Misiniz?");
    if (answer) {

        $.ajax({
            url: './boxAction-delete?boxAction_id=' + boxAction_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if (data != "0") {
                    fncReset();
                } else {
                    alert("Silme İşlemi Başarısız Oldu!");
                }
            },
            error: function (err) {
                console.log(err)
            }

        })
    }
}


function createBoxActionRow(productData, boxActionData) {
    let html = ``

    boxActionData.forEach(boxAction => {
        if (boxAction.orderStatus === false) {
            productData.forEach(product => {
                if (product.pr_id == boxAction.pr_id) {
                    const customerFullName = getCustomerName(boxAction.cu_id);
                    html += `<tr role="row" class="odd">
                            <td>` + boxAction.boxAction_id + `</td>
                            <td>` + product.pr_title + `</td>
                            <td>` + boxAction.amount * product.pr_sale_price + " ₺" + `</td>
                            <td>` + boxAction.amount + `</td>
                            <td>` + customerFullName + `</td>
                            <td>` + boxAction.reciptNo + `</td>
                            <td class="text-right" >
                                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                     <button onclick="orderDelete(` + boxAction.boxAction_id + `)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                                </div>
                            </td>
                         </tr>`;
                }
            });
        }
    })

    $('#boxActiontableBody').html(html);
}

function getCustomerName(cu_id) {
    var name = "";
    customerData.forEach(item => {
        if (item.cu_id == cu_id) {
            name = item.cu_name + " " + item.cu_surname;
            return name;
        }
    })
    return name;
}

function mapCustomers(customerList) {
    $.each(customerList, function (i, o) {
        $('#cname').append('<option value="' + o.cu_id + '">' + o.cu_name + " " + o.cu_surname +'</option>');
    });
    $("#cname").selectpicker("refresh")
}

function mapProducts(productList) {
    $.each(productList, function (i, o) {
        $('#pname').append('<option value="' + o.pr_id + '">' + o.pr_title + '</option>');
    });
    $("#pname").selectpicker("refresh");

}

function fncReset() {
        select_id = 0;
        $('#boxAction_add_form').trigger("reset");
        $("#cname").val('default').selectpicker("refresh");
        $("#pname").val('default').selectpicker("refresh");

        allBoxActions();
        codeGenerator();
}

function codeGenerator() {
    const date = new Date();
    const time = date.getTime();
    const key = time.toString().substring(4);
    $('#reciptNo').val(key)
    console.log(key)
}

// GET ALL CUSTOMERS
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

// GET ALL PRODUCTS
function allProduct() {
    $.ajax({
        url: './product-get',
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            productData = data;
            mapProducts(data);
        },
        error: function (err) {
            console.log(err)
        }
    })
}

function allBoxActions() {
    $.ajax({
        url: './boxAction-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            boxActionData = data;
            createBoxActionRow(productData, boxActionData);
        },
        error: function (err) {
            console.log(err)
        }
    })

}



codeGenerator();
allCustomer();
allProduct();
allBoxActions();

$('#boxAction_add_form').submit((event) => {
    event.preventDefault();

    const cu_id = $("#cname").val()
    const pr_id = $("#pname").val()
    const amount = $("#amount").val()
    const reciptNo = $("#reciptNo").val()

    const obj = {
        amount: parseInt(amount),
        reciptNo: reciptNo,
        pr_id: parseInt(pr_id),
        cu_id: parseInt(cu_id),
    }

    $.ajax({
        url: './boxAction-post',
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

$('#updateBoxAction').submit((event) => {
    event.preventDefault();
    boxActionData.forEach((boxAction) => {
            if (boxAction.orderStatus === false) {
                const obj = {
                    boxAction_id: boxAction.boxAction_id,
                    amount: boxAction.amount,
                    reciptNo: boxAction.reciptNo,
                    pr_id: boxAction.pr_id,
                    cu_id: boxAction.cu_id,
                    orderStatus: true
                }
                console.log(obj)
                $.ajax({
                    url: './orderAction-post',
                    type: 'POST',
                    data: {obj: JSON.stringify(obj)},
                    dataType: 'JSON',
                    success: function (data) {
                        if (data > 0) {
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
            }
        }
    )
})