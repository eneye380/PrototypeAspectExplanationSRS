<%-- 
    Document   : product-comparison
    Created on : Aug 16, 2015, 7:36:27 PM
    Author     : eneye380
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%--Visitor/explanations/products/products.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.controller_bean.CategorySB"%>
<%@page import="aspect.controller_bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.controller_bean.ProductReviewSB" %>
<%@page import="aspect.model.Productreview"%>
<%@page import="aspect.controller_bean.ProductSB"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.controller_bean.ProductSBLocal"%>
<%@include file="../header/headerproductview.jsp" %>

<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<!--script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script-->
<script src="https://cdn.jsdelivr.net/jquery.flot.tooltip/0.8.4/jquery.flot.tooltip.min.js" type="text/javascript" ></script>
<script src="http://code.highcharts.com/highcharts.js" type="text/javascript" ></script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>

    <%
        String[] colors = {"#7cb5ec", "#434348", "#90ed7d", "#f7a35c", "#8085e9",
            "#f15c80", "#e4d354", "#2b908f", "#f45b5b", "#91e8e1"};
    %>

    <%
        String s1 = request.getParameter("s1");
        String s2 = request.getParameter("s2");
        String s3 = request.getParameter("s3");
        ArrayList<String> products = new ArrayList();
        products.add(s1);
        products.add(s2);
        products.add(s3);


    %>

    <jsp:useBean id="detail" class="aspect.controller_bean.ProductDetailSB" scope="request"/>
    <jsp:setProperty name="detail" property="recommSet" value="<%=products%>"/>

    <%
        ArrayList<Productdetail> d = detail.retrieveDetail(); //ArrayList of type Productdetail
    %>  


    <body>
        <%Productdetail pd = null;%>
        <%if ((d.size() > 1)) {%>
        <%--for (int m = 0; m < d.size(); m++) {--%>
        <%for (int m = 0; m < 4; m++) {%>
        <%if (m != 0) {%>
        <%pd = d.get(m);%>
        <!--td-->
    <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >
        <h6 class="text-uppercase" style="color:rgb(10,50,50)"><em>Product Details</em></h6><hr>
        <p class="top_m1"><span class="desc">Price: </span><%=pd.getPrice()%></p>
        <p class="top_m2"><span class="desc">Rank: </span><%=pd.getRank()%></p>
        <p class="top_m3"><span class="desc">Date: </span><%=pd.getDate()%></p>
        <p class="top_m4"><span class="desc">Category: </span><%=pd.getCategory()%></p>
        <p class="top_m5"><span class="desc">No. of Questions: </span><%=pd.getNquestions()%></p> 
        <p class="top_m6"><span class="desc">No. of Comments: </span><%=pd.getNcomments()%></p>                                                
        <p class="top_m7"><span class="desc">No. of Reviews: </span><%=pd.getNreviews()%></p>
        <p style="margin-bottom: -70px"></p>
        <span class="pull-left" style="color:white"></span>
    </td> 
    <!--/td-->
    <!--hr-->
    <%}%>
    <%}%>
    <%} else {%>                    
    <td><h6 style="color:red">No Information</h6></td>
    <%}%> 
</body>
</html>
