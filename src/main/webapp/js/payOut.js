// add - start
let select_id = 0
$('#payOut_form').submit((event) => {
    event.preventDefault();

    const potitle = $("#payOutTitle").val()
    const potype = $("#payOutType").val()
    const poamount = $("#payOutTotal").val()
    const podetail = $("#payOutDetail").val()


    const obj = {
        po_title: potitle,
        po_paymentType: potype,
        po_paymentAmount: poamount,
        po_paymentDetail: podetail,

    }

    if (select_id != 0) {
        // update
        obj["po_id"] = select_id;
    }
    $.ajax({
        url: './payout-servlet-post',
        type: 'POST',
        data: {obj: JSON.stringify(obj)},
        dataType: 'JSON',
        success: function (data) {
            if (data > 0) {
                alert("İşlem Başarılı")
                allPayOut();
                // fncReset();
            } else {
                alert("İşlem sırasında hata oluştu!");
            }
        },
        error: function (err) {
            console.log(err)
            alert("İşlem işlemi sırısında bir hata oluştu!");
        }
    })


})
// add - end

// all payout list - start
function allPayOut() {

    $.ajax({
        url: './payout-servlet-get',
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
        let potype = ""

        if (itm.po_type == 1) {
            potype = 'Nakit'
        } else if (itm.po_type == 2) {
            potype = 'Kredi Kartı'
        } else if (itm.po_type == 3) {
            potype = '%Havale'
        } else if (itm.po_type == 4) {
            potype = '%EFT'
        } else {
            potype = '%Banka Çeki'
        }
        const ptype = potype


        html += `<tr role="row" class="odd">
            <td>` + itm.po_id + `</td>
            <td>` + itm.po_title + `</td>
            <td>` + itm.po_paymentType + `</td>
            <td>` + itm.po_paymentDetail + `</td>
            <td>` + itm.po_paymentAmount + `</td>
           
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncPayOutDelete(` + itm.po_id + `)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
               </div>
            </td>
          </tr>`;
    }
    $('#tableRow').html(html);
}


allPayOut();
// all payout list - end

// payout DELETE - START
function fncPayOutDelete(po_id) {
    let answer = confirm("Silmek İstediğinizden Emin Misiniz?");
    if (answer) {

        $.ajax({
            url: './payout-servlet-delete?po_id=' + po_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if (data != "0") {
                    allPayOut();
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

// payout DELETE - END