<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Yönetim</title>
    <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="inc/sideBar.jsp"></jsp:include>
    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">
        <jsp:include page="inc/topMenu.jsp"></jsp:include>

        <h3 class="mb-3">
            Ürünler
            <small class="h6">Ürün Paneli</small>
        </h3>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Ürün Ekle</div>

            <form class="row p-3" id="product_add_form">
                <div class="col-md-3 mb-3">
                    <label for="pr_title" class="form-label">Başlık</label>
                    <input type="text" name="pr_title" id="pr_title" class="form-control" required/>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="pr_buy_price" class="form-label">Alış Fiyatı</label>
                    <input type="number" name="pr_buy_price" id="pr_buy_price" class="form-control" required/>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="pr_sale_price" class="form-label">Satış Fiyatı</label>
                    <input type="number" name="pr_sale_price" id="pr_sale_price" class="form-control" required/>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="pcode" class="form-label">Ürün Kodu</label>
                    <input type="number" name="pcode" id="pcode" class="form-control" required/>
                </div>


                <div class="col-md-3 mb-3">
                    <label for="pr_tax_select" class="form-label">KDV</label>
                    <select class="form-select" name="pr_tax_select" id="pr_tax_select" required>
                        <option value="">Seçiniz</option>
                        <option value="1">Dahil</option>
                        <option value="2">%1</option>
                        <option value="3">%8</option>
                        <option value="4">%18</option>
                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="pr_unit" class="form-label">Birim</label>
                    <select class="form-select" name="pr_unit" id="pr_unit" required>
                        <option value="">Seçiniz</option>
                        <option value="1">Adet</option>
                        <option value="2">KG</option>
                        <option value="3">Metre</option>
                        <option value="4">Paket</option>
                        <option value="5">Litre</option>
                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="pr_quantity" class="form-label">Miktar</label>
                    <input type="number" name="pr_quantity" id="pr_quantity" class="form-control" required/>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="pr_detail" class="form-label">Ürün Detay</label>
                    <input type="text" name="pr_detail" id="pr_detail" class="form-control"/>
                </div>


                <div class="btn-group col-md-3 " role="group">
                    <button type="submit" class="btn btn-outline-primary mr-1">Gönder</button>
                    <button onclick="fncReset()" type="button" class="btn btn-outline-primary">Temizle</button>
                </div>
            </form>
        </div>


        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Ürün Listesi</div>

            <div class="row mt-3" style="padding-right: 15px; padding-left: 15px;">
                <div class="col-sm-3"></div>
                <div class="col-sm-3"></div>
                <div class="col-sm-3"></div>
                <div class="col-sm-3">
                    <div class="input-group flex-nowrap">
                        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" placeholder="Arama.." aria-label="Username"
                               aria-describedby="addon-wrapping">
                        <button class="btn btn-outline-primary">Ara</button>
                    </div>
                </div>


            </div>

            <div class="table-responsive">
                <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Uid</th>
                        <th>Başlık</th>
                        <th>Alış Fiyatı</th>
                        <th>Satış Fiyatı</th>
                        <th>Kod</th>
                        <th>KDV</th>
                        <th>Birim</th>
                        <th>Miktar</th>
                        <th>Detay</th>
                        <th class="text-center" style="width: 155px;">Yönetim</th>
                    </tr>
                    </thead>
                    <tbody id="tableRow">
                    <!-- for loop  -->

                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="productDetailModel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: black" id="ptitle">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row ">


                    <div class="col-md-3 mb-3">
                        <label class="form-label">Alış Fiyatı</label>
                        <div style="color: black" id="buy_price" class="form-text"></div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="form-label">Satış Fiyatı</label>
                        <div style="color: black" id="sale_price" class="form-text"></div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="form-label">Ürün Kodu</label>
                        <div style="color: black" id="pr_code" class="form-text"></div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="form-label">KDV</label>
                        <div style="color: black" id="tax" class="form-text"></div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="form-label">Birim</label>
                        <h5 style="color: black" id="unit" class="form-text"></h5>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Miktar</label>
                        <h5 style="color: black" id="quantity" class="form-text"></h5>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Ürün Detay</label>
                        <h5 style="color: black " id="detail" class="form-text"></h5>
                    </div>



                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Kapat</button>

            </div>
        </div>
    </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/products.js"></script>
</body>

</html>