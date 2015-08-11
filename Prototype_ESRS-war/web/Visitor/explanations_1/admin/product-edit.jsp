<%-- 
    Document   : product-edit
    Created on : Aug 9, 2015, 10:31:33 AM
    Author     : eneye380
--%>

<%@page import="java.io.File"%>
<%@page import="aspect.bean.CategoryChoiceSB"%>
<%--Visitor/explanations/products/products.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.bean.CategorySB"%>
<%@page import="aspect.bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.bean.ProductSB"%>
<%@page import="aspect.db_connection.DBUpdate"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.bean.ProductSBLocal"%>
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

    <jsp:useBean id="productcategory" class="aspect.bean.CategoryChoiceSB" scope="request"/>
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
    <jsp:useBean id="detail" class="aspect.bean.ProductDetailSB" scope="request"/>
    <jsp:setProperty name="detail" property="prodid" value="<%=s%>"/>
    <jsp:setProperty name="detail" property="recommSet" value="<%=myR%>"/>

    <%
        ArrayList<Productdetail> d = detail.retrieveDetail();
    %>  

    <%
        Productdetail pdqp = d.get(0);
    %>

    <jsp:useBean id="aspectScore" class="aspect.bean.AspectScoreSB" scope="request"/>
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

        <div class="row"  >

        </div>
        <jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/>
        <%--jsp:getProperty name="category" property="catSet"/--%>

        <%
            ArrayList<CategorySB> c = category.getCatSet();

        %>
        <div class="thumbnail text-center" style="background: rgb(10,50,50)">
            <span style="color:white;margin-bottom:20px;display:block">Welcome, <%=pageContext.getAttribute("user", PageContext.SESSION_SCOPE)%></span>
            <!--span style="color:white"><%=PageContext.SESSION_SCOPE%></span-->
            <div class="thumbnail">
                <h3>Explanation Facility for Social Recommender Systems</h3>
                <h4>Management Console</h4>
            </div>
        </div>
        <jsp:useBean id="dbupdate" class="aspect.db_connection.DBUpdate" scope="request"/>
        <%--jsp:getProperty name="category" property="catSet"/--%>

        <%
            ArrayList<String> t = dbupdate.retrieveTableNames();

        %>
        <div class="">
            <h4>ADMIN:  <span style="color:black;margin-bottom:20px;"><%=pageContext.getAttribute("user", PageContext.SESSION_SCOPE)%></span></h4>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">

                    <div class="btn-group-vertical">

                        <%for (int r = 0; r < t.size(); r++) {%> 
                        <%if (!t.get(r).equalsIgnoreCase("queryproductandrecommendation")) {%>
                        <button type="button" class="btn btn-primary" style="background: rgb(10,50,50)"><%=t.get(r)%></button> 
                        <%}%>
                        <%}%>

                    </div>

                </div>
                <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    <div class="well">
                        <div class="thumbnail">
                            <div class="well">
                                <form name="dbForm" action="product-edit.jsp">
                                    <input type="file" name="path" value="" width="100" />
                                    <input type="submit" value="mySubmit" />
                                </form>
                                <%
                                    String value = request.getParameter("path");
                                %>
                                <%if(value==null){%>
                                <p>Empty</P>
                                <%}else{%>
                                <p>Path: <%=value%></p>
                                <%}%>
                                <%
                                    File folder = new File("C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product reviews\\Product reviews\\B003VWDSJO\\");
                                    File[] listOfFiles = folder.listFiles();

                                    for (int i = 0; i < listOfFiles.length; i++) {
                                        File file = listOfFiles[i];
                                        if (file.isFile() && file.getName().endsWith(".txt")) {
                                            
                                            /* do somthing with content */
                                        }
                                    }

                                %>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



</div>
</div>
<!-- /.container -->
<div class="container">

    <hr>

    <%@include file="../footer/footer.jsp" %>