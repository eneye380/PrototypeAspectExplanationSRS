<%-- 
    Document   : adminconsole
    Created on : Aug 8, 2015, 3:43:13 PM
    Author     : eneye380
--%>

<%@page import="aspect.controller_bean.CategoryChoiceSB"%>
<%--Visitor/explanations/products/products.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.controller_bean.CategorySB"%>
<%@page import="aspect.controller_bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.controller_bean.ProductSB"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.controller_bean.ProductSBLocal"%>
<%@include file="../header/headerproductview.jsp" %>
<!-- Page Content -->
<script>


</script>
<style>
    .a,.b,.c{

    }
    .c{

    }
    .recommendation{
        /**background: rgb(60,90,100);*/
        background: rgb(10,50,50);

    }
    .rec_prodname_h4{
        color: grey;
    }
    .nhidden{
        color:white;
    }
    .aspect{
        background: rgb(10,50,50);
        color:orange;
    }
</style>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<!--script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script-->
<script src="https://cdn.jsdelivr.net/jquery.flot.tooltip/0.8.4/jquery.flot.tooltip.min.js" type="text/javascript" ></script>
<script src="http://code.highcharts.com/highcharts.js" type="text/javascript" ></script>




<div class="container" id="pbody">

    <jsp:useBean id="productcategory" class="aspect.controller_bean.CategoryChoiceSB" scope="request"/>
    <jsp:setProperty name="productcategory" property="category" param="category" />
    <%
    %>
    <%--jsp:getProperty name="productcategory" property="category"/--%>
    <%        String s = "";
        ArrayList<CategoryChoiceSB> p = productcategory.getSet();
        ArrayList<String> myR = new ArrayList();
        if (p.size() > 1) {
            for (int i = 0; i < p.size(); i++) {
                CategoryChoiceSB l = p.get(i);
                myR.add(l.getProduct());
            }
        }

    %>
    <!--%=myR%--!>
    <jsp:useBean id="detail" class="aspect.controller_bean.ProductDetailSB" scope="request"/>
    <jsp:setProperty name="detail" property="prodid" value="<%=s%>"/>
    <jsp:setProperty name="detail" property="recommSet" value="<%=myR%>"/>

    <%
        ArrayList<Productdetail> d = detail.retrieveDetail();
    %>  

    <%
        Productdetail pdqp = d.get(0);
    %>

    <jsp:useBean id="aspectScore" class="aspect.controller_bean.AspectScoreSB" scope="request"/>
    <jsp:setProperty name="aspectScore" property="prodid" value="<%=s%>"/>
    <jsp:setProperty name="aspectScore" property="recommSet" value="<%=myR%>"/>
    <%
        Map<String, Map<String, Map<String, Number>>> scores = new HashMap();
        scores = aspectScore.retrieveAspectScores();
    %>
    <!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
    <!--%=scores%-->
    <body id="body" onload1="retrievePRJSONDetail('<%=s%>')">

        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" >
            <div class="container-fluid" >
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../welcome/">ESRS</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="#">Products</a>
                        </li>
                        <li>
                            <a href="#">Concept</a>
                        </li>
                        <li>
                            <a href="#" onclick="">About</a>
                        </li>
                    </ul>
                    <span class="pull-right" style="color:rgb(255,247,217)"><%=dd%></span>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>


        <div class="thumbnail">

            <div class="jumbotron text-center" style="background: rgb(10,50,50)">
                <span style="color:white;margin-bottom:20px;display:block">Welcome, <%=pageContext.getAttribute("user", PageContext.SESSION_SCOPE)%></span>
                <!--span style="color:white"><%=PageContext.SESSION_SCOPE%></span-->
                <div class="thumbnail">
                    <h3>Explanation Facility for Social Recommender Systems</h3>
                    <h4>Management Console</h4>
                </div>
                <div class="thumbnail">
                    <div class="well" style="background: rgb(10,50,50)">
                        <div class="thumbnail">
                            <div class="row">

                                <div class="col-lg-6">
                                    
                                    <a href="category.jsp"><div class="btn btn-block" style="background: rgb(225,155,155); color:rgb(30,50,50)">VIEW PRODUCTS</div></a>
                                </div>
                                <div class="col-lg-6 ">
                                   
                                    <a href="product-edit.jsp"><div class="btn btn-block" style="background: rgb(30,50,50); color:rgb(225,155,155)"> EDIT PRODUCTS</div></a>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


        </div>

        <%--jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/--%>
        <%--jsp:getProperty name="category" property="catSet"/--%>
        <%--
            ArrayList<CategorySB> c = category.getCatSet();

        --%>





</div>
</div>
<!-- /.container -->
<div class="container">

    <hr>

    <%@include file="../footer/footer.jsp" %>