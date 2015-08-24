<%-- 
    Document   : index
    Created on : Jul 16, 2015, 12:05:21 PM
    Author     : eneye380
--%>

<%@page import="aspect.controller_bean.CategoryChoiceSB"%>
<%@page import="aspect.controller_bean.CategorySB"%>
<%@page import="java.util.ArrayList"%>
<%--Visitor/explanations_1/welcome/--%>
<%@include file="../header/header.jsp" %>

<!-- Page Content -->
<div class="container" >

    <!-- Jumbotron Header -->
    <header class="well">
        <h1>Welcome to the E-System</h1>
        <p>A Recommender System that Recommend Products with Explanations at Product Aspect Level </p>
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


    <jsp:useBean id="category" class="aspect.controller_bean.CategorySB" scope="request"/>
    <%
        ArrayList<CategorySB> c = category.getCatSet();
    %>




    <!-- Page Features -->

    <%for (int r = 0; r < c.size(); r++) {%>
    <%CategorySB ct = c.get(r);%>

    <%if (r+1 % 4 == 1) {%>
    <div class="row text-center ">
        <%}%>

        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/<%=ct.getCategory()%>.jpg" alt="image of <%=ct.getCategory()%>" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
                    <!--h3>Canon E0S 60D 18MP</h3-->
                    <h4 class="text-uppercase"><%=ct.getCategory()%></h4>
                    <!--p>Canon E0S 60D 18MP</p-->
                    <p>
                        <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a-->
                    <form action="../products/category.jsp" onsubmit1="checkout()">
                        <input type="hidden" name="category" id="prod_1" value="<%=ct.getCategory()%>">
                        <input type="submit" value="View" class="btn btn-primary" >
                    </form>
                    </p>
                </div>
            </div>
        </div>
        <%if (r+1 % 4 == 0) {%>
    </div>
    <%}%>


    <%}%>

    <!--div class="row text-center well">
        
        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
            <div class="thumbnail">
                <img src="../../../img/B0040JHVC2.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                <div class="caption">
    <!--h3>Canon E0S 60D 18MP</h3>
    <h4>Digital SLR Cameras</h4>
    <!--p>Canon E0S 60D 18MP</p>
    <p>
    <!--a href="productview.jsp" class="btn btn-primary">View</a> <a href="#" class="btn btn-default"></a>
<form action="../products/category.jsp" onsubmit1="checkout()">
    <input type="hidden" name="category" id="prod_1" value="digital slr">
    <input type="submit" value="View" class="btn btn-primary" >
</form>
</p>
</div>
</div>



    <!--div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
        <div class="thumbnail">
            <img src="../../../img/B0040JHVC2.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
            <div class="caption">
                
                <h4>Digital SLR Cameras</h4>
                
                <p>
                    
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
            <img src="../../../img/B003MPSING.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
            <div class="caption">
                
                <h4>Compact Cameras</h4>
                
                <p>
                    
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
            <img src="../../../img/B00A9T56KG.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
            <div class="caption">
                
                <h4>Laptops</h4>
                
                <p>
                    
                <form action="../products/category.jsp" onsubmit1="return retrievePaR(this)">
                    <input type="hidden" name="category" id="prod_3" value="laptops">
                    <input type="submit" value="View" class="btn btn-primary" >
                </form>
                </p>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">
        <div class="thumbnail">
            <img src="../../../img/B007KW5FVA.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
            <div class="caption">
                
                <h4>Tablets</h4>
                
                <p>
                  
                <form action="../products/category.jsp" onsubmit1="return retrievePaR(this)">
                    <input type="hidden" name="category" id="prod_4" value="tablets">
                    <input type="submit" value="View" class="btn btn-primary" >
                </form>
                </p>
            </div>
        </div>
    </div>

</div-->
    <!-- /.row -->
</div>
    <hr>

    <%@include file="../footer/footer.jsp" %>
