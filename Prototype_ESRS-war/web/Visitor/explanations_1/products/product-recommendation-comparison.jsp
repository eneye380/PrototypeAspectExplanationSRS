<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
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
<!-- Page Content -->
<script>


</script>
<style>
    table td,th{

    }
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
        position:relative;
        top:-70px;        
    }
    .top_m8{
        position:relative;
        top:-70px; 
        margin-bottom: -70px;
    }
    .desc{
        color:sienna;    
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
    /**colors: ['#7cb5ec', '#434348', '#90ed7d', '#f7a35c', '#8085e9', 
   '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1']*/
    .queryRi{
        border-right: solid 1px #7cb5ec;
    }
    .recommRi{
        border-right: solid 1px #434348;
    }
</style>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<!--script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script-->
<script src="https://cdn.jsdelivr.net/jquery.flot.tooltip/0.8.4/jquery.flot.tooltip.min.js" type="text/javascript" ></script>
<script src="http://code.highcharts.com/highcharts.js" type="text/javascript" ></script>

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

<%----%>
<jsp:useBean id="recommend" class="aspect.controller_bean.ProductSetSB" scope="request"/>
<jsp:setProperty name="recommend" property="queryProduct" param="product" />
<%
%>

<%    String s = recommend.getQueryProduct();    //fetch query Product
    /**
     * getting Recommendation Set
     */
    ArrayList<ProductSetSB> p = recommend.getSet(); //ArrayList of type ProductSetSB
    ArrayList<String> myR = new ArrayList();   //ArrayList of type String
    if (p.size() > 1) {
        for (int i = 0; i < p.size(); i++) {
            ProductSetSB l = p.get(i);  //ProductSetSB Object
            myR.add(l.getProduct());    //Populating ArrayList myR with recommended products
        }
    }

%>
<jsp:useBean id="detail" class="aspect.controller_bean.ProductDetailSB" scope="request"/>
<jsp:setProperty name="detail" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="detail" property="recommSet" value="<%=myR%>"/>

<%
    ArrayList<Productdetail> d = detail.retrieveDetail(); //ArrayList of type Productdetail
%>  

<%
    Productdetail pdqp = d.get(0); //declaration and initialization of entity class Productdetail object representing the details of the query product
%>

<jsp:useBean id="aspectScore" class="aspect.controller_bean.AspectScoreSB" scope="request"/>
<jsp:setProperty name="aspectScore" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="aspectScore" property="recommSet" value="<%=myR%>"/>

<%
    Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap(); //declares and instantiate a Map object productScoresMap
    productScoresMap = aspectScore.retrieveAspectScores();  //initialise the Map object productScoresMap
%>

<jsp:useBean id="reviewDetail" class="aspect.controller_bean.ProductReviewSB" scope="request"/>
<jsp:setProperty name="reviewDetail" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="reviewDetail" property="recommSet" value="<%=myR%>"/>

<%
    Map<String, Map<String, Map<String, String>>> productReviewMap = new HashMap(); //declares and instantiate a Map object productReviewMap
    productReviewMap = reviewDetail.retrieveProductReview();    //initialise the Map object productReviewMap
%>

<%
    String rating = ""; //declaration and initialization
    int freq1 = 0, freq2 = 0, freq3 = 0, freq4 = 0, freq5 = 0, totalratings = 0, totalcomments = 0; //declaration and initialization
%>

<%if (productReviewMap.containsKey(s)) {%>
<%Map<String, Map<String, String>> productReviews = productReviewMap.get(s);// returns a map of the product reviews details associated with a productid
    Set keyset = productReviews.keySet(); //retrieves the set of keys representing a particular author
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

        rating = value.get("rating");

        double val = Double.parseDouble(rating);
        totalcomments++;
        if (val != 0.0) {
            totalratings++;
        }
        if (val == 5.0) {
            freq5++;
        } else if (val == 4.0) {
            freq4++;
        } else if (val == 3.0) {
            freq3++;
        } else if (val == 2.0) {
            freq2++;
        } else if (val == 1.0) {
            freq1++;
        }

%>
<%}%>
<%}%>
<!--saving star rating value-->
<form  class="starsfreq">
    <input type="hidden" value="<%=s%>" name="prodid">
    <input type="hidden" value="<%=freq5%>" name="star5">
    <input type="hidden" value="<%=freq4%>" name="star4">
    <input type="hidden" value="<%=freq3%>" name="star3">
    <input type="hidden" value="<%=freq2%>" name="star2">
    <input type="hidden" value="<%=freq1%>" name="star1">
    <input type="hidden" value="<%=totalcomments%>" name="tot">
</form>
<!--/saving-->
<!--getting sum of recommendation star rating-->
<%Productdetail pdr_cr = null;%>
<%if ((d.size() > 1)) {%>
<%--for (int m = 0; m < d.size(); m++) {--%>
<%for (int m = 0; m < d.size(); m++) {%>
<%if (m != 0) {%>
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
<%}%>
<%} else {%>                    

<%}%>
<!--/getting-->

<body id="body" onload="retrievePRJSONDetail('<%=s%>', '1', 'compare', 'star')">

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


    <!--div class="container-fluid" id="pbody">
        <div class="btn-group" style="margin-top: 5px;">
            <button type="button" class="btn btn-primary btn-xs" id="button_aas">Category</button>
        </div>
        <ul class="category_aas" style="margin-top: 5px;display:inline">
            <li>enene</li>
            <li>aa</li>

<!--a href="product-recommendation-comparison_1.jsp?product=<%=pdqp.getProdid()%>" style="background: black" class="btn btn-success btn-xs btn- pull-right">Change View</a-->
</ul-->
<div class="row">

    <!--div class="col-md-2 col-sm-2 col-xs-12 well aspect">
    <%@include file="../sidebar/sidebar.jsp" %>
</div-->

    <!--Side Bar Start><-->


    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 well aspect">
        <jsp:useBean id="category_1" class="aspect.controller_bean.CategorySB" scope="request"/>
        <%--jsp:getProperty name="category" property="catSet"/--%>
        <%
            ArrayList<CategorySB> cc = category_1.getCatSet();

        %>
        <div class="row">
            <div class="col-lg-12 text-center">                                
                <h5 style="color: whitesmoke"><strong>Recommended Product Comparison</strong></h5>
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
            <!--a href="product-recommendation-comparison_1.jsp?product=<%=pdqp.getProdid()%>" style="background: black" class="btn btn-success btn-xs btn- pull-right">Change View</a-->
        </div>
        <!-- Algorithm to finds common aspects-->
        <% ArrayList<Double> l = new ArrayList();%>
        <%
            //array storing common aspects
            ArrayList<String> e = new ArrayList();
            boolean importance = true;
        %>
        <%
            Map<String, Map<String, Number>> qPS = productScoresMap.get(s);
            Set k = qPS.keySet();
            Iterator i = k.iterator();
            int count = 0;
            for (int u = 0; u < aspImp.size(); u++) {
                //String key = (String) i.next();
                String key = aspImp.get(u);
                //Map<String, Number> value = (Map) qPS.get(key);
                int sent = d.size();
                //int sent1 = d.size();
                for (int b = 0; b < d.size(); b++) {
                    Map<String, Map<String, Number>> rPS = productScoresMap.get(d.get(b).getProdid());
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
                    int sent = d.size() - 1;
                    //int sent1 = d.size();
                    for (int b = 1; b < d.size(); b++) {
                        Map<String, Map<String, Number>> rPS = productScoresMap.get(d.get(b).getProdid());
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

        %>
        <!---start of aspect selection->
        <!--div class="btn-group" style="margin-top: 10px">
            <button type="button" class="btn btn-primary btn-xs" id="button_aspect">Shared Aspects</button>
            <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset</button>
        </div>
        <div class="aspect_selection" style="display1:none;height:300px;overflow: auto">

            <form>
        <%if (myR.size() != 0) {%>
        <%for (int r = 0; r < e.size(); r++) {%>
        <%String key = e.get(r);%>
        <div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '1')"><%=key%></label></div>                            
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
        <!--div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '2')"><%=key%></label></div-->                            
        <!--li><%=key%></li-->
        <%--}--%>
        <%}%>
        <%}%>

        <!--/form-->

        <!--/div-->
        <!--/end of aspect selection-->
    </div>
    <%--=e--%>
    <!--Side Bar End><-->

    <!--Main Content Start><-->
    <%--=d.size()--%>
    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">


        <div class="well" style="width: auto;height: auto">

            <!--name container of query product-->

            <!--/name-->

            <!--explantion interface-->


            <div class="thumbnail" style="">
                <h4 style="color:rgb(10,50,50)">Aspect Sentiment Graph</h4>
                <div id="<%=s%>" class="explanationbar" style="height:300px"></div>  
            </div>
            <!--aspect selection-->

            <div class="thumbnail">
                <div class="">

                </div>
                <h5 style="color:rgb(10,50,50)">Aspect Selection</h5>

                <div class="" style="margin-top: 10px">
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect">view/hide Aspects</button>
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset Graph</button>
                    <%if (myR.size() != 0) {%>  
                    <span class="pull-right" style="color:black"><%=count%> common aspects</span>
                    <%} else {%>
                    <span class="pull-right" style="color:black"><%=count%> aspects</span>
                    <%}%>
                </div>
                <p class='text-primary'> choose aspects to display, maximum of 10 allowed <span class='text-danger '></span></p>
                <%if (importance == true) {%>
                    <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on importance ranking</span>
                    <%} else {%>
                    <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on commonality</span>
                    <%}%>
                <div class="aspect_selection">

                    <form style='color: rgb(50,50,10)'>
                        <%if (myR.size() != 0) {%>
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
                        <input type="hidden" value="<%=key%>" class="comparisonaspects">    
                        <%}%>
                        <%}%>

                    </form>

                </div>

            </div>
        </div>
        <!--/aspect-->

        <!--/explanation-->

        <!--Table of product comparison-->

        <table class="table text-center table_1">
            <thead>
                <tr>
                    <th class="text-center" style="border-right:1px solid <%=colors[0]%>;color:rgb(10,50,50)">
                        <em>Query Product</em>
                    </th>
                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdrr = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdrr = d.get(m);%>
                    <!--td-->

                    <!--/td-->
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <th colspan="<%=d.size() - 1%>" class="text-center" style="color:rgb(10,50,50)">
                        <em>Recommended Products</em>
                    </th> 
                    <%} else {%>                    
                    <th><h4 style="color:red">Sorry No Recommended Product</h4></th>
                    <%}%>                                                
            <!--/div-->
            </tr>
            </thead>
            <tbody style="">
                <!--product image and name-->
                <tr class="text-center">
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>;border-right:1px solid <%=colors[0]%>">
                        <span class="pull-left" style="color:<%=colors[0]%>">1</span>
                        <a href="product-recommendation-detail.jsp?product=<%=pdqp.getProdid()%>"><img class="img-responsive " title="click to view recommendations" onmouseover="showDes(this)" name="<%=pdqp.getProdid()%>" src="../../../img/<%=pdqp.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:85px"></a>
                        <div class="caption"> 
                            <div style=""><h6><%=pdqp.getName()%></h6></div>                                                                                                          
                        </div>
                        <span class="pull-left" style="color:white"></span>
                    </td>
                    <!--/td-->

                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr = d.get(m);%>
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[m]%>;border-right:1px solid <%=colors[m]%>">
                        <span class="pull-left" style="color:<%=colors[m]%>"><%=(m + 1)%></span>
                        <a href="product-recommendation-detail.jsp?product=<%=pdr.getProdid()%>"><img class="img-responsive " onmouseover="showDes(this)" name="<%=pdr.getProdid()%>" src="../../../img/<%=pdr.getProdid()%>.jpg" title="click to view recommendations" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:85px"></a>
                        <div class="caption">
                            <div style=""><h6><%=pdr.getName()%></h6></div>                                                                                                            
                        </div>
                        <span class="pull-left" style="color:white"></span>
                    </td> 
                    <!--/td-->
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Name</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product image and name-->


                <!--product rating-->
                <!--tr-->
                <tr class="">
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>;  border-right:1px solid <%=colors[0]%>" >            
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Star Rating</em></h6><hr>
                        <div class="caption">                                                         
                            <!--product rating-->        
                            <%//star rating
                                String vv = pdqp.getRating();
                                double sr = 0.0;
                                if (vv != null) {
                                    if (!vv.equalsIgnoreCase("null")) {
                                        sr = Double.parseDouble(vv);
                                    }
                                }
                            %>
                            <div style="position: relative;top: 5px; margin: auto;width: 80px;"><span class="stars"><%=sr%></span></div>
                            <!--/product-->                                                        
                        </div>
                        <span class="" style="color:black"><%=pdqp.getRating()%>/5.0</span>
                    </td>
                    <!--/td-->
                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr_1 = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
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
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Rating</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product rating-->

                <!--product aspect graph-->
                <!--tr-->
                <tr class="text-center">
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>; border-right:1px solid <%=colors[0]%>" >   
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Aspect Sentiment Graph</em></h6><hr>
                        <div class="caption">                                                         
                            <!--product aspect graph-->        

                            <div id="<%=s%>_comp" id1="container" style="height:200px;background:white"></div>
                            <!--/product-->                                                        
                        </div>
                        <span class="" style="color:black"></span>
                    </td>
                    <!--/td-->
                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr_3 = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr_3 = d.get(m);%>
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >           
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Aspect Sentiment Graph</em></h6><hr>
                        <div class="caption">                                                         
                            <!--product aspect graph-->        

                            <!--/td-->                                                        
                            <div id="<%=pdr_3.getProdid()%>_comp" id1="container" style="height:200px;background:white"></div>                            
                            <!--/td-->
                            <!--/product-->                                                    
                        </div>
                        <span class="" style="color:black"></span>
                    </td> 
                    <!--/td-->
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Aspect Graph</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product aspect graph-->
                <!--product aspect graph-->
                <!--tr-->
                <tr class="text-center">
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>; border-right:1px solid <%=colors[0]%>" >   
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Rating Distribution Graph</em></h6><hr>
                        <div class="caption">                                                         
                            <!--product aspect graph-->        

                            <div id="<%=s%>_r_comp" id1="container" style="height:200px;background:white"></div>
                            <!--/product-->                                                        
                        </div>
                        <span class="" style="color:black"></span>
                    </td>
                    <!--/td-->
                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr_x = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr_x = d.get(m);%>
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >           
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Rating Distribution Graph</em></h6><hr>
                        <div class="caption">                                                         
                            <!--product aspect graph-->        

                            <!--/td-->                                                        
                            <div id="<%=pdr_x.getProdid()%>_r_comp" id1="container" style="height:200px;background:white"></div>                            
                            <!--/td-->
                            <!--/product-->                                                    
                        </div>
                        <span class="" style="color:black"></span>
                    </td> 
                    <!--/td-->
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Aspect Graph</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product aspect graph-->
                <!--product detail-->
                <tr class="text-center" >
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>; border-right:1px solid <%=colors[0]%>" >
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Product Details</em></h6><hr>
                        <p class="top_m1"><span class="desc">Price: </span>&pound;<%=pdqp.getPrice()%></p>
                        <p class="top_m2"><span class="desc">Rank: </span><%=pdqp.getRank()%></p>
                        <p class="top_m3"><span class="desc">Date: </span><%=pdqp.getDate()%></p>
                        <p class="top_m4"><span class="desc">Category: </span><%=pdqp.getCategory()%></p>
                        <p class="top_m5"><span class="desc">No. of Questions: </span><%=pdqp.getNquestions()%></p> 
                        <p class="top_m6"><span class="desc">No. of Comments: </span><%=pdqp.getNcomments()%></p>                                                
                        <p class="top_m7"><span class="desc">No. of Reviews: </span><%=pdqp.getNreviews()%></p>
                        <p style="margin-bottom: -70px"></p>
                        <span class="pull-left" style="color:white"></span>
                    </td>
                    <!--/td-->

                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr_4 = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr_4 = d.get(m);%>
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[m]%>; border-right:1px solid <%=colors[m]%>" >
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Product Details</em></h6><hr>
                        <p class="top_m1"><span class="desc">Price: </span>&pound;<%=pdr_4.getPrice()%></p>
                        <p class="top_m2"><span class="desc">Rank: </span><%=pdr_4.getRank()%></p>
                        <p class="top_m3"><span class="desc">Date: </span><%=pdr_4.getDate()%></p>
                        <p class="top_m4"><span class="desc">Category: </span><%=pdr_4.getCategory()%></p>
                        <p class="top_m5"><span class="desc">No. of Questions: </span><%=pdr_4.getNquestions()%></p> 
                        <p class="top_m6"><span class="desc">No. of Comments: </span><%=pdr_4.getNcomments()%></p>                                                
                        <p class="top_m7"><span class="desc">No. of Reviews: </span><%=pdr_4.getNreviews()%></p>
                        <p style="margin-bottom: -70px"></p>
                        <span class="pull-left" style="color:white"></span>
                    </td> 
                    <!--/td-->
                    <!--hr-->
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Name</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product image and name-->
                <!--product aspect graph-->
                <!--tr-->
                <tr class="text-center">
                    <!--td-->
                    <td style="border-bottom:1px solid <%=colors[0]%>; border-right:1px solid <%=colors[0]%>" >  
                        <em><span id="no_r_1" style="color:rgb(10,50,50)"></span></em>
                        <h6 class="text-uppercase label_2" style="color:rgb(10,50,50)"><em>Product Reviews</em></h6><hr>
                        <div class="caption" style="height:300px;overflow: scroll">                                                         
                            <%
                                //String[] data11 = null;
                                double srr = 0.0;
                                String author1, productid1, badges1, helpfulranking1, title1, date1, rating1, npeopleuseful1, npeoplevoted1, ncomments1, comment1;
                            %>
                            <%if (productReviewMap.containsKey(s)) {%>
                            <%Map<String, Map<String, String>> productReviews = productReviewMap.get(s);
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
                                    author1 = value.get("author");
                                    productid1 = value.get("productid");
                                    badges1 = value.get("badges");
                                    helpfulranking1 = value.get("helpfulranking");
                                    title1 = value.get("title");
                                    date1 = value.get("date");
                                    rating1 = value.get("rating");
                                    npeopleuseful1 = value.get("npeopleuseful");
                                    npeoplevoted1 = value.get("npeoplevoted");
                                    ncomments1 = value.get("ncomments");
                                    comment1 = value.get("comment");

                                    srr = Double.parseDouble(rating1);
                                    sentinel++;
                                    if (sentinel == 20) {
                                        break;
                                    }


                            %>
                            <div class='thumbnail'>
                                <!--star rating of query product-->
                                <div style="position: relative;top: 5px;"><span class="stars"><%=srr%></span></div>
                                <!--/star-->
                                <p style='color:rosybrown'><span class="">Author: <%=author1%></span></p>

                                <p><span class="desc"></span></p>
                                <p class="top_m1"><span class="desc">Badges: </span><%=badges1%></p>
                                <p class="top_m2"><span class="desc">Helpfulranking: </span><%=helpfulranking1%></p>
                                <p class="top_m3"><span class="desc">Title: </span><%=title1%></p>
                                <p class="top_m4"><span class="desc">Date: </span><%=date1%></p>
                                <p class="top_m5"><span class="desc">No. of People Useful: </span><%=npeopleuseful1%></p> 
                                <p class="top_m6"><span class="desc">No. of People Voted: </span><%=npeoplevoted1%></p>                                                
                                <p class="top_m7"><span class="desc">No. of Comments: </span><%=ncomments1%></p>
                                <p class='top_m8' style='color:rgb(10,50,50)'><%=comment1%></p>
                            </div>
                            <%}%>
                            <%}%>                                                      
                        </div>
                        <span class="" style="color:black"></span>
                    </td>
                    <!--/td-->
                    <!--td-->
                    <!--div class="row text-center "-->
                    <%Productdetail pdr_5 = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%--for (int m = 0; m < d.size(); m++) {--%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr_5 = d.get(m);%>
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
                            <%if (productReviewMap.containsKey(pdr_5.getProdid())) {%>
                            <%Map<String, Map<String, String>> productReviews = productReviewMap.get(pdr_5.getProdid());
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
                    <%}%>
                    <%} else {%>                    
                    <td><h6 style="color:red">Sorry No Recommended Product Review</h6></td>
                    <%}%>
                    <!--/div-->

                    <!--/td-->
                </tr>
                <!--/product aspect graph-->



            </tbody>
        </table>


        <!--/table-->







    </div>

    <!--Main Content End><-->

</div>
<!-- /.container -->
<!--div class="container"-->

<hr>

<%@include file="../footer/footer.jsp" %>
