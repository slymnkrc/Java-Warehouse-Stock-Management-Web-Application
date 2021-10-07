// PRODUCT ADD START
let select_id = 0
$('#product_add_form').submit((event) => {
    event.preventDefault();

    const pr_title = $("#pr_title").val()
    const pr_buy_price = $("#pr_buy_price").val()
    const pr_sale_price = $("#pr_sale_price").val()
    const pcode = $("#pcode").val()
    const pr_tax_select = $("#pr_tax_select").val()
    const pr_unit = $("#pr_unit").val()
    const pr_quantity = $("#pr_quantity").val()
    const pr_detail = $("#pr_detail").val()

    const obj = {
        pr_title: pr_title,
        pr_buy_price: pr_buy_price,
        pr_sale_price: pr_sale_price,
        pr_code: pcode,
        pr_tax: pr_tax_select,
        pr_unit: pr_unit,
        pr_quantity: pr_quantity,
        pr_detail: pr_detail
    }

    if (select_id != 0) {
        obj["pr_id"] = select_id;
    }
    $.ajax({
        url: './product-post',
        type: 'POST',
        data: {obj: JSON.stringify(obj)},
        dataType: 'JSON',
        success: function (data) {
            if (data > 0) {
                alert("İşlem Başarılı")
                fncReset();
            } else {
                console.log(data)
                alert("İşlem sırasında hata oluştu.")
            }
        },
        error: function (err) {
            console.log(err)
            alert("İşlem işlemi sırısında bir hata oluştu!")
        }
    })


})
// PRODUCT ADD END

// PRODUCT LIST START
function allProduct() {
    $.ajax({
        url: './product-get',
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            createRow(data);
        },
        error: function (err) {
            console.log(err)
        }
    })
}

let globalArr = []

function createRow(data) {
    globalArr = data;
    let html = ``
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        let ptax = ""
        let punit = ""
        if (itm.pr_tax == 1) {
            ptax = 'Dahil'
        } else if (itm.pr_tax == 2) {
            ptax = '%1'
        } else if (itm.pr_tax == 3) {
            ptax = '%8'
        } else {
            ptax = '%18'
        }
        const prtax = ptax
        if (itm.pr_unit == 1) {
            punit = 'Adet'
        } else if (itm.pr_unit == 2) {
            punit = 'KG'
        } else if (itm.pr_unit == 3) {
            punit = 'Metre'
        } else if (itm.pr_unit == 4) {
            punit = 'Paket'
        } else {
            punit = 'Litre'
        }
        const prunit = punit
        html += `<tr role ="row" class="odd">
             <td>` + itm.pr_id + `</td>           
             <td>` + itm.pr_title + `</td>           
             <td>` + itm.pr_buy_price + `</td>           
             <td>` + itm.pr_sale_price + `</td>           
             <td>` + itm.pr_code + `</td>           
             <td>` + prtax + `</td>           
             <td>` + prunit + `</td>           
             <td>` + itm.pr_quantity + `</td>           
             <td>` + itm.pr_detail + `</td>       
             <td class="text-right">
                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                    <button onclick="fncProductDelete(` + itm.pr_id + `)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                    <button onclick="fncProductDetail(` + i + `)" data-bs-toggle="modal" data-bs-target="#productDetailModel" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                    <button onclick="fncProductUpdate(` + i + `)" type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i></button>
                </div>
             </td>
           </tr>`;
    }
    $('#tableRow').html(html);
}

// PRODUCT LİST END

function codeGenerator() {
    const date = new Date();
    const time = date.getTime();
    const key = time.toString().substring(4);
    $('#pcode').val(key)
}

allProduct();

// reset function
function fncReset() {
    select_id = 0;
    $('#product_add_form').trigger("reset");
    codeGenerator();
    allProduct();
}

// PRODUCT DELETE - START
function fncProductDelete(pr_id) {
    let answer = confirm("Ürünü Silmek İstediğinizden Emin Misiniz?");
    if (answer) {

        $.ajax({
            url: './product-delete?pr_id=' + pr_id,
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

// PRODUCT DELETE - END

// PRODUCT DETAIL - START

function fncProductDetail(i) {
    const itm = globalArr[i];
    select_id = itm.pr_id

    $("#ptitle").text(itm.pr_title + " " + " - " + itm.pr_id);
    $("#buy_price").text(itm.pr_buy_price == "" ? '-----' : itm.pr_buy_price);
    $("#sale_price").text(itm.pr_sale_price == "" ? '-----' : itm.pr_sale_price);
    $("#pr_code").text(itm.pr_code == "" ? '-----' : itm.pr_code);
    $("#tax").text(itm.pr_tax == 1 ? 'Dahil' : itm.pr_tax == 2 ?  '%1' : itm.pr_tax == 3 ? '%8' : '%18');
    $("#unit").text(itm.pr_unit == 1 ? 'Adet' : itm.pr_unit == 2 ? 'KG' : itm.pr_unit == 3 ? 'Metre' : itm.pr_unit == 4 ? 'Paket' : 'Litre');
    $("#quantity").text(itm.pr_quantity == "" ? '-----' : itm.pr_quantity);
    $("#detail").text(itm.pr_detail == "" ? '-----' : itm.pr_detail);
}

// PRODUCT DETAIL - END

// PRODUCT UPDATE  - START

function fncProductUpdate(i){
    const itm = globalArr[i];
    select_id = itm.pr_id

    $("#pr_title").val(itm.pr_title)
    $("#pr_buy_price").val(itm.pr_buy_price)
    $("#pr_sale_price").val(itm.pr_sale_price)
    $("#pcode").val(itm.pr_code)
    $("#pr_tax_select").val(itm.pr_tax)
    $("#pr_unit").val(itm.pr_unit)
    $("#pr_quantity").val(itm.pr_quantity)
    $("#pr_detail").val(itm.pr_detail)
}

// PRODUCT UPDATE - END
