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
        <style>
            table.tab td{
                width:33%;
            }
            .a,.b,.c{

            }
            .c{

            }
            table td,th{
                width:25%; 
                text-align: left;
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
                /**background: #204d74;*/
                color:orange;
            }

            .top_m1{
                position:relative;
                top:-10px;        
            }
            .top_m2{
                position:relative;
                top:-20px;        
            }
            .top_m3{
                position:relative;
                top:-30px;        
            }
            .top_m4{
                position:relative;
                top:-40px;        
            }
            .top_m5{
                position:relative;
                top:-50px;        
            }
            .top_m6{
                position:relative;
                top:-60px;        
            }
            .top_m7{
                position: relative;
                top:-70px;
            }
            .desc{
                color:black;    
                text-align: center;
            }
            span.stars, span.stars span {
                display: block;
                background: url(../../../img/stars.png) 0 -16px repeat-x;
                width: 80px;
                height: 16px;        
            }

            span.stars span {
                background-position: 0 0;
            }
        </style>
    </head>

    <%
        String[] colors = {"#7cb5ec", "#434348", "#90ed7d", "#f7a35c", "#8085e9",
            "#f15c80", "#e4d354", "#2b908f", "#f45b5b", "#91e8e1"};
    %>

    <jsp:useBean id="aspectImport" class="aspect.controller_bean.AspectImportance" scope="request"/>
    <%
        String catss = (String) session.getAttribute("category");
        aspectImport.setRankedCategory(catss);

        ArrayList<String> aspImp = aspectImport.getRankedAspects();
    %>

    <%--=aspImp--%>

    <%
        //String s1 = request.getParameter("s1");
        //String s2 = request.getParameter("s2");
        //String s3 = request.getParameter("s3");
        String[] s = request.getParameterValues("s");
        ArrayList<String> products = new ArrayList(3);
        if (s.length > 0) {
            if (s.length <= 3) {
                for (int t = 0; t < s.length; t++) {
                    products.add(s[t]);
                }
                session.setAttribute("comparison", products);
            }
        }

        //products.add(s1);
        //products.add(s2);
        //products.add(s3);

    %>
    <%--=s.length--%>
    <jsp:useBean id="detail" class="aspect.controller_bean.ProductDetailSB" scope="request"/>
    <jsp:setProperty name="detail" property="recommSet" value="<%=products%>"/> 

    <%
        ArrayList<Productdetail> d = detail.retrieveDetail(); //ArrayList of type Productdetail
%>  


    <jsp:useBean id="aspectScore" class="aspect.controller_bean.AspectScoreSB" scope="request"/>
    <jsp:setProperty name="aspectScore" property="recommSet" value="<%=products%>"/>

    <%
        Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap(); //declares and instantiate a Map object productScoresMap
        productScoresMap = aspectScore.retrieveAspectScores();  //initialise the Map object productScoresMap
%>

    <%--=productScoresMap--%>

    <jsp:useBean id="reviewDetail" class="aspect.controller_bean.ProductReviewSB" scope="request"/>
    <jsp:setProperty name="reviewDetail" property="recommSet" value="<%=products%>"/>

    <%
        Map<String, Map<String, Map<String, String>>> productReviewMap = new HashMap(); //declares and instantiate a Map object productReviewMap
        productReviewMap = reviewDetail.retrieveProductReview();    //initialise the Map object productReviewMap
    %>

    <%
        String rating = ""; //declaration and initialization
        int freq1 = 0, freq2 = 0, freq3 = 0, freq4 = 0, freq5 = 0, totalratings = 0, totalcomments = 0; //declaration and initialization
    %>


    <%Productdetail pdr_cr = null;%>
    <%if ((d.size() > 1)) {%>
    <%--for (int m = 0; m < d.size(); m++) {--%>
    <%for (int m = 0; m < d.size(); m++) {%>

    <%pdr_cr = d.get(m);%>

    <%
        String rating2 = "";
        int freq11 = 0, freq21 = 0, freq31 = 0, freq41 = 0, freq51 = 0, totalratings1 = 0, totalcomments1 = 0;
    %>
    <%if (productReviewMap.containsKey(pdr_cr.getProdid())) {%>
    <%Map<String, Map<String, String>> productReviews = productReviewMap.get(pdr_cr.getProdid());   // returns a map of the product reviews details associated with a productid
        Set keyset = productReviews.keySet();   //retrieves the set of keys representing a particular author
        Iterator ite = keyset.iterator();
        Iterator it = keyset.iterator();
        int w = 0;
        while (it.hasNext()) {
            it.next();
            w++;
        }

        while (ite.hasNext()) {
            String key = (String) ite.next();   //sets the authors name
            Map<String, String> value = (Map) productReviews.get(key);  //returns a authors reviews detail

            rating2 = value.get("rating");

            double val = Double.parseDouble(rating2);
            totalcomments1++;
            if (val != 0.0) {
                totalratings1++;
            }
            if (val == 5.0) {
                freq51++;
            } else if (val == 4.0) {
                freq41++;
            } else if (val == 3.0) {
                freq31++;
            } else if (val == 2.0) {
                freq21++;
            } else if (val == 1.0) {
                freq11++;
            }

    %>

    <%}%>

    <form  class="starsfreq">
        <input type="hidden" value="<%=pdr_cr.getProdid()%>" name="prodid">
        <input type="hidden" value="<%=freq51%>" name="star5">
        <input type="hidden" value="<%=freq41%>" name="star4">
        <input type="hidden" value="<%=freq31%>" name="star3">
        <input type="hidden" value="<%=freq21%>" name="star2">
        <input type="hidden" value="<%=freq11%>" name="star1">
        <input type="hidden" value="<%=totalcomments1%>" name="tot">
    </form>
    <%freq51 = 0;
        freq41 = 0;
        freq31 = 0;
        freq21 = 0;
        freq11 = 0;
        totalcomments1 = 0;
        totalratings1 = 0;
    %>
    <%}%> 

    <%}%>
    <%} else {%>                    

    <%}%>
    <!--/getting-->


    <body onload="compare()">


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
            <!-- /.container-fluid -->
        </nav>




        <div class="row">
            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 well aspect">
                <jsp:useBean id="category_1" class="aspect.controller_bean.CategorySB" scope="request"/>
                <%--jsp:getProperty name="category" property="catSet"/--%>
                <%
                    ArrayList<CategorySB> cc = category_1.getCatSet();

                %>
                <div class="row">
                    <div class="col-lg-12 text-center">                                
                        <h5 style="color: whitesmoke"><strong>Product Comparison</strong></h5>
                        <h6 class="text-uppercase" style="color:rgb(230,240,250)"><%=session.getAttribute("category")%></h6>
                    </div>
                </div>

                <div class="btn-group" style="margin-top: 5px;">
                    <button type="button" class="btn btn-primary btn-sm" id="button_category">Category</button>
                </div>
                <div class="category_selection" style="margin-top: 5px;display1:none">
                    <div class="list-group ">
                        <%for (int r = 0; r < cc.size(); r++) {%>
                        <%CategorySB ct = cc.get(r);%>


                        <a href="../products/category.jsp?category=<%=ct.getCategory()%>" class="list-group-item "><%=ct.getCategory()%></a>                    
                        <%}%>
                    </div>
                    <!--a href="product-recommendation-comparison_1.jsp?product=<%--=pdqp.getProdid()--%>" style="background: black" class="btn btn-success btn-xs btn- pull-right">Change View</a-->
                </div>
                <!-- Algorithm to finds common aspects-->
                <% ArrayList<Double> l = new ArrayList();%>
                <%
                    //array storing common aspects
                    ArrayList<String> e = new ArrayList();
                    int count = 0;
                    boolean importance = true;
                %>

                <%
                    if (products.size() > 0) {
                        for (int c = 0; c < products.size(); c++) {
                            Map<String, Map<String, Number>> qPS = productScoresMap.get(products.get(0));
                            Set k = qPS.keySet();
                            Iterator i = k.iterator();
                            //count = 0;
                            for (int u = 0; u < aspImp.size(); u++) {
                                //String key = (String) i.next();
                                String key = aspImp.get(u);
                                //Map<String, Number> value = (Map) qPS.get(key);
                                int sent = products.size();
                                //int sent1 = d.size();
                                for (int b = 0; b < products.size(); b++) {
                                    Map<String, Map<String, Number>> rPS = productScoresMap.get(products.get(b));
                                    if (rPS.containsKey(key)) {
                                        sent--;
                                    }
                                    if (sent == 0) {
                                        if (!e.contains(key)) {
                                            e.add(key);
                                            count++;
                                        }
                                    }
                                }
                            }
                            if (e.size() < 1) {
                                importance = false;
                                while (i.hasNext()) {
                                    //for (int u = 0; u < aspImp.size(); u++) {
                                    String key = (String) i.next();
                                    //String key = aspImp.get(u);
                                    //Map<String, Number> value = (Map) qPS.get(key);
                                    int sent = products.size() - 1;
                                    //int sent1 = d.size();
                                    for (int b = 1; b < products.size(); b++) {
                                        Map<String, Map<String, Number>> rPS = productScoresMap.get(products.get(b));
                                        if (rPS.containsKey(key)) {
                                            sent--;
                                        }
                                        if (sent == 0) {
                                            if (!e.contains(key)) {
                                                e.add(key);
                                                count++;
                                            }
                                        }
                                    }
                                }
                            }
                            break;
                        }
                    }

                %>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                <div class="well aspect">
                    <div class="thumbnail">
                        <%if (d.size() > 0) {%>
                        <h4 style="color:rgb(10,50,50)" >Aspect Sentiment Graph</h4>
                        <div id="<%=d.get(0).getProdid()%>" class="explanationbar" style="height:200px"></div>  
                        <%}%>

                        <%for (int g = 0; g < d.size(); g++) {%>
                        <input type="hidden" value="<%=d.get(g).getProdid()%>" class="productsid">
                        <%}%>
                    </div>
                    <div class="thumbnail">
                        <div class="text-info">

                        </div>
                        <div class="">
                            <div class="" style="margin-top: 10px">
                                <button type="button" class="btn btn-primary btn-xs" id="button_aspect">view/hide Aspects</button>
                                <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset Graph</button>
                                <span class="pull-right" style="color:black"><%=count%> common aspects</span>
                            </div>
                            <p class='text-primary'> choose aspects to display, maximum of 10 allowed <span class='text-danger '></span></p>
                            <%if (importance == true) {%>
                            <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on importance ranking</span>
                            <%} else {%>
                            <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on commonality</span>
                            <%}%>
                            <div class="aspect_selection" style="height:50px;overflow: auto">

                                <form style='color: rgb(50,50,10)'>
                                    <%if (products.size() != 0) {%>
                                    <%for (int r = 0; r < e.size(); r++) {%>
                                    <%String key = e.get(r);%>
                                    <!--div class="checkbox"--><label class='checkbox-inline' ><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '1')"><%=key%></label><!--/div-->                            
                                    <input type="hidden" value="<%=key%>" class="comparisonaspects">    
                                    <%}%>

                                    <%} else if (productScoresMap.containsKey(s)) {%>
                                    <%
                                        Map<String, Map<String, Number>> productScores = productScoresMap.get(s);
                                        Set keyset = productScores.keySet();
                                        Iterator ite = keyset.iterator();

                                    %>
                                    <%while (ite.hasNext()) {%>
                                    <%
                                        String key = (String) ite.next();
                                        Map<String, Number> value = (Map) productScores.get(key);
                                        Number a = value.get("score");
                                        double val = a.doubleValue();
                                        double absVal = Math.abs(val);
                                        double ii = val / absVal;
                                        l.add(val);

                                    %>
                                    <%--if (ii == 1.0) {--%>
                                    <!--li><%=key%> : <%=a%></li-->
                                    <!--label class='checkbox-inline'><input type="checkbox" value="<%=key%>"><%=key%></label-->
                                    <!--div class="checkbox"--><label class='checkbox-inline'><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '2')"><%=key%></label><!--/div-->                            

<!--li><%=key%></li-->
                                    <%--}--%>
                                    <%}%>
                                    <%}%>

                                </form>

                            </div>
                        </div>
                    </div>
                    <div class="thumbnail">
                        <table class="table tab text-center">

                            <tr><!--td-->
                                <!--div class="row text-center "-->
                                <%Productdetail pdd = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pdd = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>;border-right:1px solid <%=colors[m]%>">
                                    <span class="pull-left" style="color:<%=colors[m]%>"><%=(m + 1)%></span>
                                    <a href="product-recommendation-detail.jsp?product=<%=pdd.getProdid()%>"><img class="img-responsive " onmouseover="showDes(this)" name="<%=pdd.getProdid()%>" src="../../../img/<%=pdd.getProdid()%>.jpg" alt="image of <%=pdd.getProdid()%>" id="query_prod_img" style="height:85px"></a>
                                    <div class="caption">
                                        <div style=""><h6><%=pdd.getName()%></h6></div>                                                                                                            
                                    </div>
                                    <span class="pull-left" style="color:white"></span>
                                </td> 
                                <!--/td-->
                                <!--hr-->

                                <%}%>
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%>
                                <!--/div-->

                                <!--/td-->
                            </tr>
                            <!--/product image and name-->
                            <tr>
                                <%Productdetail pdr_1 = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pdr_1 = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>;border-right:1px solid <%=colors[m]%>" >        
                                    <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Star Rating</em></h6><hr>
                                    <div class="caption">                                                         
                                        <!--product rating-->        
                                        <%//star rating
                                            String v = pdr_1.getRating();
                                            double rPsr = 0.0;
                                            if (v != null) {
                                                if (!v.equalsIgnoreCase("null")) {
                                                    rPsr = Double.parseDouble(v);
                                                }
                                            }
                                        %>
                                        <!--/td-->                                                        
                                        <div style="position: relative;top: 5px; margin: auto;width: 80px;"><span class="stars"><%=rPsr%></span></div>                                                        
                                        <!--/td-->
                                        <!--/product-->                                                    
                                    </div>
                                    <span class="" style="color:black"><%=pdr_1.getRating()%>/5.0</span>
                                </td> 
                                <!--/td-->
                                <!--hr-->

                                <%}%>
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%>
                                <!--/div-->


                            </tr>
                            <tr class="text-center">
                                <!--td-->

                                <!--/td-->
                                <!--td-->
                                <!--div class="row text-center "-->
                                <%Productdetail pdr_3 = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pdr_3 = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >           
                                    <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Aspect Sentiment Graph</em></h6><hr>
                                    <div class="caption">                                                         
                                        <!--product aspect graph-->        

                                        <!--/td-->                                                        
                                        <div id="<%=pdr_3.getProdid()%>_comp" id1="container" style="height:150px;background:white"></div>                            
                                        <!--/td-->
                                        <!--/product-->                                                    
                                    </div>
                                    <span class="" style="color:black"></span>
                                </td> 
                                <!--/td-->
                                <!--hr-->

                                <%}%>
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%>
                                <!--/div-->

                                <!--/td-->
                            </tr>
                            <!--/product aspect graph-->
                            <!--product aspect graph-->
                            <!--tr-->
                            <tr class="text-center">
                                <!--td-->

                                <!--/td-->
                                <!--td-->
                                <!--div class="row text-center "-->
                                <%Productdetail pdr_x = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pdr_x = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >           
                                    <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Rating Distribution Graph</em></h6><hr>
                                    <div class="caption">                                                         
                                        <!--product aspect graph-->        

                                        <!--/td-->                                                        
                                        <div id="<%=pdr_x.getProdid()%>_r_comp" id1="container" style="height:150px;background:white"></div>                            
                                        <!--/td-->
                                        <!--/product-->                                                    
                                    </div>
                                    <span class="" style="color:black"></span>
                                </td> 
                                <!--/td-->
                                <!--hr-->

                                <%}%>
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%>
                                <!--/div-->

                                <!--/td-->
                            </tr>
                            <tr>
                                <%Productdetail pd = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pd = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >
                                    <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Product Details</em></h6><hr>
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
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%> 
                            </tr>
                            <tr>
                                <%Productdetail pd1 = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>

                                <%pd1 = d.get(m);%>
                                <!--td-->
                                <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >   
                                    <em><span id="no_r_<%=m + 1%>" style="color:rgb(10,50,50)"></span></em>
                                    <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Product Reviews</em></h6><hr>
                                    <div class="caption" style="height:300px;overflow: scroll">                                                         
                                        <%
                                            //String[] data11 = null;
                                            double srr2 = 0.0;
                                            String author2, productid2, badges2, helpfulranking2, title2, date2, rating2, npeopleuseful2, npeoplevoted2, ncomments2, comment2;
                                        %>
                                        <%if (productReviewMap.containsKey(pd1.getProdid())) {%>
                                        <%Map<String, Map<String, String>> productReviews = productReviewMap.get(pd1.getProdid());
                                            Set keyset = productReviews.keySet();
                                            Iterator ite = keyset.iterator();
                                            Iterator it = keyset.iterator();
                                            int w = 0, sentinel = 0;
                                            while (it.hasNext()) {
                                                it.next();
                                                w++;
                                            }

                                            while (ite.hasNext()) {
                                                String key = (String) ite.next();
                                                Map<String, String> value = (Map) productReviews.get(key);
                                                author2 = value.get("author");
                                                productid2 = value.get("productid");
                                                badges2 = value.get("badges");
                                                helpfulranking2 = value.get("helpfulranking");
                                                title2 = value.get("title");
                                                date2 = value.get("date");
                                                rating2 = value.get("rating");
                                                npeopleuseful2 = value.get("npeopleuseful");
                                                npeoplevoted2 = value.get("npeoplevoted");
                                                ncomments2 = value.get("ncomments");
                                                comment2 = value.get("comment");

                                                srr2 = Double.parseDouble(rating2);
                                                sentinel++;
                                                if (sentinel == 20) {
                                                    break;
                                                }

                                        %>
                                        <div class='thumbnail'>
                                            <!--star rating of query product-->
                                            <div style="position: relative;top: 5px;"><span class="stars"><%=srr2%></span></div>
                                            <!--/star-->
                                            <p style='color:rosybrown'><span class="">Author: <%=author2%></span></p>

                                            <p><span class="desc"></span></p>
                                            <p class="top_m1"><span class="desc">Badges: </span><%=badges2%></p>
                                            <p class="top_m2"><span class="desc">Helpfulranking: </span><%=helpfulranking2%></p>
                                            <p class="top_m3"><span class="desc">Title: </span><%=title2%></p>
                                            <p class="top_m4"><span class="desc">Date: </span><%=date2%></p>
                                            <p class="top_m5"><span class="desc">No. of People Useful: </span><%=npeopleuseful2%></p> 
                                            <p class="top_m6"><span class="desc">No. of People Voted: </span><%=npeoplevoted2%></p>                                                
                                            <p class="top_m7"><span class="desc">No. of Comments: </span><%=ncomments2%></p>
                                            <p class='top_m8' style='color:rgb(10,50,50)'><%=comment2%></p>
                                        </div>
                                        <%}%>
                                        <%}%> 
                                    </div>
                                    <span class="" style="color:black"></span>
                                </td> 
                                <!--/td-->
                                <!--hr-->

                                <%}%>
                                <%} else {%>                    
                                <td><h6 style="color:red">no products to compare</h6></td>
                                <%}%>
                            </tr>
                        </table>
                    </div>

                    <%Productdetail pd_1 = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>

                    <!--div class="row" id="aspects_table" style="display:">
                        <div class="col-lg-12">                                
                            <h4 style="color:grey">Table of Aspects</h4>  

                    <%for (int n = 0; n < d.size(); n++) {%>

                    <%}%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%pd_1 = d.get(m);%>
                    
                    <h5><%=pd_1.getName()%></h5>
                    <table class="table">
                        <thead>                                        
                            <tr>
                                <th>Aspect</th>
                                <th>Score</th>
                                <th>Frequency</th>
                                <th>Gini</th>
                            </tr>
                        </thead>
                        <tbody style="">
                    <%if (productScoresMap.containsKey(pd_1.getProdid())) {%>
                    <%
                        Map<String, Map<String, Number>> productScores = productScoresMap.get(pd_1.getProdid());
                        Set keyset = productScores.keySet();
                        Iterator ite = keyset.iterator();
                    %>
                    <%while (ite.hasNext()) {%>
                    <%
                        String key = (String) ite.next();
                        Map<String, Number> value = (Map) productScores.get(key);
                        Number a = value.get("score");
                        double val = a.doubleValue();
                        double absVal = Math.abs(val);
                        double ii = val / absVal;
                    %>

                    <tr>
                        <td><%=key%></td>
                        <td><%=value.get("score")%></td>
                        <td><%=value.get("freq")%></td>
                        <td><%=value.get("gini")%></td>
                    </tr>

                    <%}%>
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                <td><h6 style="color:red">no products to compare</h6></td>
                    <%}%> 
                    </tbody>
                </table>

            </div>
        </div-->
                </div>                        
            </div>
        </div>

    </div>
</div>

</body>
</html>
