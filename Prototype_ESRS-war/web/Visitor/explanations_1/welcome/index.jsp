<%-- 
    Document   : index
    Created on : Jul 16, 2015, 12:05:21 PM
    Author     : eneye380
--%>
<%--Visitor/explanations_1/welcome/--%>
<%@include file="../header/header.jsp" %>

<!-- Page Content -->
<div class="container" >

    <!-- Jumbotron Header -->
    <header class="well">
        <h1>Welcome to the E-System</h1>
        <p>A System that Provides Explanations at Product Aspects Level </p>
        <!--p><a class="btn btn-primary btn-primary" href1="viewproduct.jsp">View Products</a>
        </p-->
    </header>

    <hr>

    <!-- Title -->
    <div class="row">
        <div class="col-lg-12">
            <h3>Categories</h3>
        </div>
    </div>
    <!-- /.row -->

    <!-- Page Features -->
    <div class="row text-center well">

        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/B0040JHVC2.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
                    <!--h3>Canon E0S 60D 18MP</h3-->
                    <h4>Digital SLR Cameras</h4>
                    <!--p>Canon E0S 60D 18MP</p-->
                    <p>
                        <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a-->
                    <form action="../products/category.jsp" onsubmit1="checkout()">
                        <input type="hidden" name="category" id="prod_1" value="digital slr">
                        <input type="submit" value="View" class="btn btn-primary" >
                    </form>
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/B0035FZJI0.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
                    <!--h3>Canon E0S Rebel</h3-->
                    <h4>Compact Cameras</h4>
                    <!--p>Canon E0S Rebel T2i</p>
                    <p>
                        <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a-->
                        <form action="../products/category.jsp" onsubmit1="return retrievePaR(this)">
                        <input type="hidden" name="category" id="prod_2" value="compact">
                        <input type="submit" value="View" class="btn btn-primary" >
                    </form>
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/B003ZYF42C.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
                    <!--h3>Nikon D3100</h3-->
                    <h4>Laptops</h4>
                    <!--p>Nikon D3100 14.2MP</p-->
                    <p>
                        <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a-->
                    <form action="../products/category.jsp" onsubmit1="return retrievePaR(this)">
                        <input type="hidden" name="category" id="prod_3" value="laptop">
                        <input type="submit" value="View" class="btn btn-primary" >
                    </form>
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/B00427Z7N2.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
                    <!--h3>Pentax K-r</h3-->
                    <h4>Tablets</h4>
                    <!--p>Pentax K-r 12.4MP</p-->
                    <p>
                        <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a-->
                    <form action="../products/category.jsp" onsubmit1="return retrievePaR(this)">
                        <input type="hidden" name="category" id="prod_4" value="tablet">
                        <input type="submit" value="View" class="btn btn-primary" >
                    </form>
                    </p>
                </div>
            </div>
        </div>

    </div>
    <!-- /.row -->

    <hr>

    <%@include file="../footer/footer.jsp" %>
