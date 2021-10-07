<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">

<head>
    <title>Ödeme Girişi</title>
    <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>

<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="inc/sideBar.jsp"></jsp:include>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">

        <jsp:include page="inc/topMenu.jsp"></jsp:include>

        <h3 class="mb-3">
            Kasa Yönetimi
            <small class="h6">Ödeme Girişi</small>
        </h3>


        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Ödeme Ekle</div>

            <form class="row p-3">

                <div class="col-md-3 mb-3">
                    <label for="cname" class="form-label">Müşteri Seçiniz</label>
                    <select class="form-select" name="cname" id="cname">
                        <option value="0">Tümü</option>
                        <option value="1">Ali Bilmem</option>
                        <option value="2">Erkan Bilsin</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="payOutType" class="form-label">Ödeme Türü</label>
                    <select class="form-select" name="payOutType" id="payOutType">
                        <option value="-1">Ödeme Türünü Seçiniz</option>
                        <option value="0">Nakit</option>
                        <option value="1">Kredi Kartı</option>
                        <option value="2">Havale</option>
                        <option value="3">EFT</option>
                        <option value="4">Banka Çeki</option>
                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="paymentAmount" class="form-label">Ödeme Tutarı</label>
                    <input type="text" name="paymentAmount" id="paymentAmount" class="form-control"/>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="paymentDetail" class="form-label">Ödeme Detay</label>
                    <input type="text" name="paymentDetail" id="paymentDetail" class="form-control"/>
                </div>

                <div class="btn-group col-md-3 " role="group">
                    <button type="submit" class="btn btn-outline-primary mr-1">Gönder</button>
                    <button type="reset" class="btn btn-outline-primary">Temizle</button>
                </div>
            </form>
        </div>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Müşteri Listesi</div>

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
                        <th>Id</th>
                        <th>Adı</th>
                        <th>Soyadı</th>
                        <th>Ünvan</th>
                        <th>Kod</th>
                        <th>Türü</th>
                        <th>Telefon</th>
                        <th>Mail</th>
                        <th class="text-center" style="width: 155px;">Yönetim</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- for loop  -->
                    <tr role="row" class="odd">
                        <td>84</td>
                        <td>011</td>
                        <td>Su</td>
                        <td>120</td>
                        <td>84</td>
                        <td>011</td>
                        <td>Su</td>
                        <td>120</td>
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
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="inc/js.jsp"></jsp:include>
</body>

</html>

