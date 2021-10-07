<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<head>
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
            Satış Yap
            <small class="h6">Satış Yönetim Paneli</small>
        </h3>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Yeni Satış</div>

            <form class="row p-3" id="boxAction_add_form">
                <div class="col-md-3 mb-3">
                    <label for="cname" class="form-label">Müşteriler</label>
                    <select id="cname" class="selectpicker" data-width="100%" data-show-subtext="true">
                        <option data-subtext="" value="default">Seçim Yapınız</option>

                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="pname" class="form-label">Ürünler</label>
                    <select id="pname" class="selectpicker" data-width="100%" data-show-subtext="true">
                        <option data-subtext="" value="default">Seçim Yapınız</option>
                    </select>
                </div>


                <div class="col-md-3 mb-3">
                    <label for="amount" class="form-label">Adet</label>
                    <input type="number" min="1" max="100" name="count" id="amount" class="form-control"/>
                </div>


                <div class="col-md-3 mb-3">
                    <label for="reciptNo" class="form-label">Fiş No</label>
                    <input type="text" min="1" max="100" name="bNo" id="reciptNo" class="form-control"/>
                </div>

                <div class="btn-group col-md-3 " role="group">
                    <button type="submit" class="btn btn-outline-primary mr-1">Ekle</button>
                </div>
            </form>
        </div>


        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Sepet Ürünleri</div>


            <div class="table-responsive">
                <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                    <thead>
                    <tr>
                        <th>BId</th>
                        <th>Ürün</th>
                        <th>Fiyat</th>
                        <th>Sayı</th>
                        <th>Müşteri</th>
                        <th>Fiş No</th>
                        <th class="text-center" style="width: 55px;">Sil</th>
                    </tr>
                    </thead>
                    <tbody id="boxActiontableBody">
                    <!-- for loop  -->
                    <tr role="row" class="odd">

                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="btn-group col-md-3 " role="group">
            <form id="updateBoxAction">
                <button type="submit" class="btn btn-outline-primary mr-1">Satışı Tamamla</button>
            </form>
        </div>

    </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/boxAction.js"></script>
</body>
</html>