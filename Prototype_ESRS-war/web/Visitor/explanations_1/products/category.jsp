<%-- 
    Document   : category
    Created on : Jul 16, 2015, 2:22:20 PM
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

<%
    session.setAttribute("category",request.getParameter("category"));
%>


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
    <body id="body">

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
                        <!--li>
                            <a href="#">Products</a>
                        </li>
                        <li>
                            <a href="#">Concept</a>
                        </li>
                        <li>
                            <a href="#" onclick="">About</a>
                        </li-->
                    </ul>
                    <!--span class="pull-right" style="color:rgb(255,247,217)"><%=dd%></span-->
                    <p style="color:goldenrod" class="text-right"><strong>EXPLANATIONS IN SOCIAL RECOMMENDER SYSTEMS</strong><br>
                        <span style="color:whitesmoke"><em>Aspect Style Explanation</em></span></p>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

        <div class="row"  >

        </div>

        <%--jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/--%>
        <%--jsp:getProperty name="category" property="catSet"/--%>
        <%--
            ArrayList<CategorySB> c = category.getCatSet();

        --%>

        <div class="col-md-2 col-sm-2 col-xs-12 well aspect">            
            <%@include file="../sidebar/sidebar.jsp" %>
        </div>


        <div class="col-md-10 col-sm-10 col-xs-12">


            <div class="well text-center">   
                 <form id='prod'>
                    <input type="button" class='pull-right' form='prod' value="compare" onclick= 'return checkSelection(this.form)'>
                <div class="caption">
                    <h3 class="text-uppercase" style="color:rgb(10,50,50)"><%=request.getParameter("category")%></h3>
                </div>
               
                    <%Productdetail pdr = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%int o = 0;%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr = d.get(m);%>
                    <%

                        if (m % 2 == 1) {
                            o++;
                        }

                    %>
                    <%--if (m == 1 || m == 5 || m == 9) {--%>
                    <%if (m % 4 == 1) {%>
                    <div class="row text-center">
                        <%}%>

                        <div class="col-md-3 col-sm-6 col-xs-12 hero-feature">

                            <div class="thumbnail">
                                <p><span class="pull-right" style="color: goldenrod"><%--=m--%></span></p>
                                <a href="product-recommendation-detail.jsp?product=<%=pdr.getProdid()%>"><img src="../../../img/<%=pdr.getProdid()%>.jpg" alt="image of <%=pdr.getProdid()%>" class="img-thumbnail" title="click to view recommendations" style="height:100px;width:50%" onclick='selectF()'></a>
                                
                                <div class="caption">
                                    <!--h3>Canon E0S 60D 18MP</h3-->
                                    <div style="height: 20px;overflow: hidden"><h6><%=pdr.getName()%></h6></div>
                                    
                                     <input type="checkbox" name="s" form="prod" value="<%=pdr.getProdid()%>" class="productComp" onclick="productSelect(this)">
                                    <br>
                                     <span class="text-primary" title="select 2 - 3 products to compare">Compare</span>
                                     <!--p>Canon E0S 60D 18MP</p-->
                                    <p>
                                        
                                    </p>
                                </div>
                            </div>
                        </div>
                        <%--if (m == 4 || m == 8) {--%>
                        <%if (m % 4 == 0) {%>
                    </div>
                    <%}%>
                    
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <h4 style="color:red">Sorry No Products Currently Available</h4>
                    <%}%>
                </form>
            </div>
        </div>
</div>
</div>
<!-- /.container -->
<div class="container">

    <hr>

    <%@include file="../footer/footer.jsp" %>
