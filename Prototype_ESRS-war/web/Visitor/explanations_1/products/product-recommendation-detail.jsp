<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
    Author     : eneye380
--%>
<%@taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%--Visitor/explanations/products/product-recommendation-detail.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.controller_bean.CategorySB"%>
<%@page import="aspect.controller_bean.ProductSetSB"%>
<%@page import="aspect.controller_bean.AspectImportance"%>
<%@page import="aspect.controller_bean.AspectScoreJSONSB"%>
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


<jsp:useBean id="recommend" class="aspect.controller_bean.ProductSetSB" scope="request"/>
<jsp:setProperty name="recommend" property="queryProduct" param="product" />
<%
%>

<%    String s = recommend.getQueryProduct();
    //String r1,r2,r3;
    //r1 = recommend.getProduct1();
    //r2 = recommend.getProduct2();
    //r3 = recommend.getProduct3();
    ArrayList<ProductSetSB> p = recommend.getSet();
    ArrayList<String> myR = new ArrayList();
    if (p.size() > 1) {
        for (int i = 0; i < p.size(); i++) {
            ProductSetSB l = p.get(i);
            //out.println(l.getProduct());
            myR.add(l.getProduct());
        }
    }

%>
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
<%--
    Map<String, Map<String, Map<String, Number>>> scores = new HashMap();
    scores = aspectScore.retrieveAspectScores();
--%>
<%
    Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap();
    productScoresMap = aspectScore.retrieveAspectScores();
%>
<!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
<!--%=scores%-->

<!--jsp:useBean id="aspectScoreJSON" class="aspect.controller_bean.AspectScoreJSONSB" scope="request"/-->
<!--jsp:setProperty name="aspectScoreJSON" property="queryProdID" value="<%=s%>"/-->

<%

    JSONObject aspectJSONDetail = aspectScore.fetchAspectJSON();

%>
<!--em><%=aspectJSONDetail%></em-->


<jsp:useBean id="reviewDetail" class="aspect.controller_bean.ProductReviewSB" scope="request"/>
<jsp:setProperty name="reviewDetail" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="reviewDetail" property="recommSet" value="<%=myR%>"/>
<%
    Map<String, Map<String, Map<String, String>>> productReviewMap = new HashMap();
    productReviewMap = reviewDetail.retrieveProductReview();
%>
<!--finding star rating distributions-->
<%
    String rating1 = "";
    int freq1 = 0, freq2 = 0, freq3 = 0, freq4 = 0, freq5 = 0, totalratings = 0, totalcomments = 0;
%>
<%if (productReviewMap.containsKey(s)) {%>
<%Map<String, Map<String, String>> productReviews = productReviewMap.get(s);
    Set keyset = productReviews.keySet();
    Iterator ite = keyset.iterator();
    Iterator it = keyset.iterator();
    int w = 0;
    while (it.hasNext()) {
        it.next();
        w++;
    }

    while (ite.hasNext()) {
        String key = (String) ite.next();
        Map<String, String> value = (Map) productReviews.get(key);

        rating1 = value.get("rating");

        double val = Double.parseDouble(rating1);
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

<body id="body" onload="retrievePRJSONDetail('<%=s%>', '2', 'detail')">
    <!--JSON OBJECT>
    
    <form enctype="application/json">
        <input type="hidden"  id="json" value='<%=aspectJSONDetail%>'/>
    </form>
    <div data-object="<%=aspectJSONDetail%> " id='js'/>
    <!--/-->
    <!--saving star rating value-->
    <form  class="starsfreq">
        <input type="hidden" value="<%=s%>" name="prodid">
        <input type="hidden" value="<%=freq5%>" name="star5">
        <input type="hidden" value="<%=freq4%>" name="star4">
        <input type="hidden" value="<%=freq3%>" name="star3">
        <input type="hidden" value="<%=freq2%>" name="star2">
        <input type="hidden" value="<%=freq1%>" name="star1">
        <input type="hidden" value="<%=totalratings%>">
    </form>
    <!--/saving-->
    <!--getting sum of recommendation star rating-->
    <%Productdetail pdr_5 = null;%>
    <%if ((d.size() > 1)) {%>
    <%--for (int m = 0; m < d.size(); m++) {--%>
    <%for (int m = 0; m < d.size(); m++) {%>
    <%if (m != 0) {%>
    <%pdr_5 = d.get(m);%>

    <%
        String rating2 = "";
        int freq11 = 0, freq21 = 0, freq31 = 0, freq41 = 0, freq51 = 0, totalratings1 = 0, totalcomments1 = 0;
    %>
    <%if (productReviewMap.containsKey(pdr_5.getProdid())) {%>
    <%Map<String, Map<String, String>> productReviews = productReviewMap.get(pdr_5.getProdid());
        Set keyset = productReviews.keySet();
        Iterator ite = keyset.iterator();
        Iterator it = keyset.iterator();
        int w = 0;
        while (it.hasNext()) {
            it.next();
            w++;
        }

        while (ite.hasNext()) {
            String key = (String) ite.next();
            Map<String, String> value = (Map) productReviews.get(key);

            rating2 = value.get("rating");

            double val = Double.parseDouble(rating2);
            totalcomments++;
            if (val != 0.0) {
                totalratings++;
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
        <input type="hidden" value="<%=pdr_5.getProdid()%>" name="prodid">
        <input type="hidden" value="<%=freq51%>" name="star5">
        <input type="hidden" value="<%=freq41%>" name="star4">
        <input type="hidden" value="<%=freq31%>" name="star3">
        <input type="hidden" value="<%=freq21%>" name="star2">
        <input type="hidden" value="<%=freq11%>" name="star1">
        <input type="hidden" value="<%=totalratings1%>" name="tot">
    </form>
    <%freq51 = 0;
        freq41 = 0;
        freq31 = 0;
        freq21 = 0;
        freq11 = 0;%>
    <%}%> 

    <%}%>
    <%}%>
    <%} else {%>                    

    <%}%>
    <!--/getting-->




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
                    <span style="color:whitesmoke" class="label_1"><em>Aspect Style Explanation</em></span></p>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>


    <div class="container-fluid" id="pbody">
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
                        <h5 style="color: whitesmoke"><strong>Product Recommendations</strong></h5>
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
                    //while (i.hasNext()) {
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


                <form>
                    <%if (myR.size() != 0) {%>
                    <%for (int r = 0; r < e.size(); r++) {%>
                    <%String key = e.get(r);%>
                    <!--div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '1')"><%=key%></label></div-->                            
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
                    <!--div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '2')"><%=key%></label></div-->                            
                    <input type="hidden" value="<%=key%>" class="comparisonaspects">    
   <!--li><%=key%></li-->
                    <%--}--%>
                    <%}%>
                    <%}%>

                </form>

                </div-->
            </div>
            <%--=e--%>
            <!--Side Bar End><-->

            <!--Main Content Start><-->

            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">



                <div class="well">
                    <!--name container of query product-->

                    <!--/name-->
                    <div class="row thumbnail">
                        <div class="row">
                            <div class="col-lg-12 text-center">
                                <h5 style="color:sienna"><em><%=pdqp.getName()%></em></h5>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">                                 
                            <div class="well" style="height:1000px;overflow:scroll;background: white" >
                                <p style="color:rgb(10,50,50)"><strong>QUERY PRODUCT</strong></p>
                                <!--detail of query product-->
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="border:1px solid <%=colors[0]%>" >
                                        <!--image container for query product-->
                                        <div>
                                            <span class="pull-left" style="color:<%=colors[0]%>">1</span>
                                            <a href="product-detail.jsp?product=<%=pdqp.getProdid()%>"><img class="img-responsive " id="productimage" src="../../../img/<%=pdqp.getProdid()%>.jpg" title="click to view details" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="heighth:90px"></a>
                                        </div>
                                        <!--/image-->
                                        <%//star rating
                                            String r = pdqp.getRating();
                                            double sr = 0.0;
                                            if (r != null) {
                                                if (!r.equalsIgnoreCase("null")) {
                                                    sr = Double.parseDouble(r);
                                                }
                                            }
                                        %>
                                        <!--star rating of query product-->
                                        <div style="position: relative;top: 1px;"><span class="stars"><%=sr%></span></div>
                                        <!--/star-->
                                    </div>
                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                                        <!--description of query product-->
                                        <table class="table text-center text-info" style="font-size: small;background: white">
                                            <tr><th><span class="desc">Price</span></th>
                                                <th><span class="desc">Rating</span></th>
                                                <th><span class="desc">Rank</span></th>
                                                <!--th><span class="desc">Date</span></th-->
                                                <th><span class="desc">Category</span></th>
                                            </tr>
                                            <tr>
                                                <td>&pound;<%=pdqp.getPrice()%></td>
                                                <td><%=pdqp.getRating()%>/5</td>
                                                <td><%=pdqp.getRank()%></td>
                                                <!--td><%=pdqp.getDate()%></td-->
                                                <td><%=pdqp.getCategory()%></td>
                                            </tr> 
                                            <!--tr>
                                                <th><span class="desc">Category</span></th>
                                                <th><span class="desc">No. of Questions</span></th>
                                                <th><span class="desc">No. of Comments</span></th>
                                                <th><span class="desc">No. of Reviews</span></th>
                                            </tr>
                                            <tr>
                                                <td><%=pdqp.getCategory()%></td>
                                                <td><%=pdqp.getNquestions()%></td>
                                                <td><%=pdqp.getNcomments()%></td>
                                                <td><%=pdqp.getNreviews()%></td>
                                            </tr--> 
                                        </table> 
                                        <!--/description-->                                                                          
                                    </div>
                                </div>
                                <!--/detail-->
                                <!-- qp_graph of query product-->                               


                                <hr>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <span id = "graphtitle" style="color:black" class="label_1">Aspect Graph</span>

                                        <div id="<%=s%>" id1="container" title="click to view comparison" style="height:195px;background:white" onclick="showMult(this, '1')"></div>  
                                        <div id="<%=s%>_mult_sentiment"  style="height:195px;display:none" class="product_graph_d" ></div> 
                                        <div id="<%=s%>_r_mult_rating"  style="height:195px;display:none" class="product_gragh_d"></div>                            

                                    </div>
                                    <!--changes not permanent-->
                                    <div class="col-lg-6 col-md-6 col-sm-2 col-xs-2">
                                        <div id="rss" class="btn btn-primary btn-xs btn- pull-right" style="display:none" onclick="show(this, '<%=s%>')">close</div>
                                        <!--p style="color:black;font-weight: bold" class="text-uppercase" id="msgrss">
                                            Hover Over the 
                                            Graph to Compare Product Aspects Sentiment
                                        </p-->
                                        <span id = "graphtitler" style="color:black" class="label_1">Frequency Distribution Graph</span>
                                        <div id="<%=s%>_r" id1="container" title="click to view comparison" style="height:195px;background:white" onclick="showMult(this, '2')"></div> 
                                        <!--div id="<%=s%>_r_mult_rating"  style="height:195px;display:none" class="product_gragh_d"></div-->                            
                                    </div>
                                </div>

                                <!--/qp_graph-->
                                <div>
                                    <!--div id="<%=s%>_mult_sentiment"  style="height:195px;display:none" class="product_graph_d" ></div-->                                          
                                </div>
                                <div class="text-info">

                                    <%if (importance == true) {%>
                                    <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on importance ranking</span>
                                    <%} else {%>
                                    <span id = "graphtitle" style="color:black" class="label_1">Aspects selected based on commonality</span>
                                    <%}%>

                                </div>
                                <hr>
                                <!--recommended products-->
                                <div class="row text-left">
                                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                                        <%if (myR.size() != 0) {%>  
                                        <p class="" style="position: relative;top: -20px;color:rgb(10,50,50)"><strong>RECOMMENDED PRODUCTS</strong><span class="pull-right"><%=count%> common aspects</span></p>
                                        <%} else {%>
                                        <p class="" style="position: relative;top: -20px;color:rgb(10,50,50)"><strong>RECOMMENDED PRODUCTS</strong><span class="pull-right"><%=count%> aspects</span></p>
                                        <%}%>

<!--p style="position: relative;top: -20px">(<%=count%>) common aspects</p-->                                            
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                        <p class="" style="position: relative;top: -20px"><a href="product-recommendation-comparison.jsp?product=<%=pdqp.getProdid()%>" class="btn btn-success btn-xs btn- pull-right">Compare</a></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row" style="position: relative;top: -20px">                            
                                    <div class="col-md-12 col-sm-12 col-xs-12">  


                                        <%Productdetail pdr = null;%>
                                        <%if ((d.size() > 1)) {%>
                                        <%--for (int m = 0; m < d.size(); m++) {--%>
                                        <%for (int m = 0; m < d.size(); m++) {%>
                                        <%if (m != 0) {%>
                                        <%pdr = d.get(m);%>
                                        <%if (m % 4 == 1) {%>
                                        <div class="row text-center">
                                            <%}%>

                                            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 thumbnail"  id="23" style="border:1px solid <%=colors[m]%>">
                                                <!--img src="../../../img/<%=pdr.getProdid()%>.jpg" alt="" class="img-thumbnail" style="height:80px"-->
                                                <span class="pull-left" style="color:<%=colors[m]%>"><%=(m + 1)%></span> 
                                                <a href="product-recommendation-detail.jsp?product=<%=pdr.getProdid()%>"><img class="img-responsive " onmouseover="showDes(this)" title="click to view recommendations" name="<%=pdr.getProdid()%>" src="../../../img/<%=pdr.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:85px"></a>
                                                <div class="caption">     

                                                    <div style="height: 20px;overflow: hidden"><h6><%=pdr.getName()%></h6></div>
                                                    <!--product rating-->        
                                                    <%//star rating
                                                        String vv = pdr.getRating();
                                                        double rPsr = 0.0;
                                                        if (vv != null) {
                                                            if (!vv.equalsIgnoreCase("null")) {
                                                                rPsr = Double.parseDouble(vv);
                                                            }
                                                        }
                                                    %>
                                                    <div style="position: relative;top: 5px;"><span class="stars"><%=rPsr%></span></div>
                                                    <!--/product-->
                                                    <p>

                                                    <form action="product-recommendation-detail.jsp" style="display:inline">
                                                        <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                        <input type="submit" value="View" class="btn btn-primary btn-xs" >
                                                    </form>
                                                    <form action="product-detail.jsp" style="display:inline">
                                                        <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                        <input type="submit" value="Detail" class="btn btn-primary btn-xs" >
                                                    </form>
                                                    </p>
                                                </div>
                                                <span class="pull-left" style="color:white"></span>
                                            </div> 
                                            <%if (m % 4 == 0) {%>
                                        </div>
                                        <%}%>         



                                        <!--hr-->
                                        <%}%>
                                        <%}%>
                                        <%} else {%>                    
                                        <h5 style="color:red">Sorry No Available Recommendations</h5>
                                        <%}%>

                                    </div>
                                </div>
                                <!--recommended-->
                            </div>                               
                        </div>
                        <!--div class="col-md-4 col-sm-4 col-xs-4"-->
                        <div class="well">

                            <!--div class="thumbnail" style="height:195px;overflow:auto">
                                <div class="product_graph_d text-center">
                                    <p style="color:black;font-weight: bold" class="text-uppercase">
                                        Display of Multi Bar
                                        Chart by Hovering Over
                                        the chart on the left
                                    </p>
                                </div>
                                <div id="<%=s%>_mult_sentiment"  style="height:195px;display:none" class="product_graph_d"></div>  
                                <div id="<%=s%>_r_mult_rating"  style="height:195px;display:none" class="product_gragh_d"><p>hello</p></div>                            
                            </div-->
                            <!--div class='thumbnail'>
                                <span id = "" style="color:black">Aspect Graph (Query Product)</span>
                                 <div id="<%=s%>" id1="container" title="click to view comparison" style="height:200px;background:white" onclick="showMult(this, '1')"></div>  
                            </div>
                            <div class='thumbnail'>
                                <span id = "" style="color:black">Rating Distribution (Query Product)</span>
                                 <div id="<%=s%>_r" id1="container" title="click to view comparison" style="height:200px;background:white" onclick="showMult(this, '2')"></div> 
                            </div-->

                            <div class="thumbnail" style="height:410px;overflow: hidden">
                                <h5 style="color:yellowgreen;background: black;text-align: center">Recommended Product Details</h5>
                                <div class="product_desc_d text-center">
                                    <p style="color:black;font-weight: bold" class="text-uppercase">
                                        Hover Over the 
                                        Recommended product to view details
                                    </p>
                                </div>

                                <%Productdetail pdr_1 = null;%>
                                <%if ((d.size() > 1)) {%>
                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                <%for (int m = 0; m < d.size(); m++) {%>
                                <%if (m != 0) {%>
                                <%pdr_1 = d.get(m);%>

                                <div style="display:none" id="i_<%=pdr_1.getProdid()%>" class="product_desc_d">

                                    <div style="border:1px solid <%=colors[m]%>">
                                        <h6 style="color: green"><%=pdr_1.getName()%></h6>
                                        <!--p><span class="desc">Rating: </span><%=pdr_1.getRating()%></p>
                                        <p class="top_m1"><span class="desc">Price: </span><%=pdr_1.getPrice()%></p>
                                        <p class="top_m2"><span class="desc">Rank: </span><%=pdr_1.getRank()%></p>
                                        <p class="top_m3"><span class="desc">Date: </span><%=pdr_1.getDate()%></p>
                                        <p class="top_m4"><span class="desc">Category: </span><%=pdr_1.getCategory()%></p>
                                        <p class="top_m5"><span class="desc">No. of Questions: </span><%=pdr_1.getNquestions()%></p> 
                                        <p class="top_m6"><span class="desc">No. of Comments: </span><%=pdr_1.getNcomments()%></p>                                                
                                        <p class="top_m7"><span class="desc">No. of Reviews: </span><%=pdr_1.getNreviews()%></p-->
                                        <table class="table text-center text-info" style="font-size: small;background: white">
                                            <tr><th><span class="desc">Price</span></th>
                                                <th><span class="desc">Rating</span></th>
                                                <th><span class="desc">Rank</span></th>
                                                <!--th><span class="desc">Date</span></th-->
                                                <th><span class="desc">Category</span></th>
                                            </tr>
                                            <tr>
                                                <td>&pound;<%=pdr_1.getPrice()%></td>
                                                <td><%=pdr_1.getRating()%>/5</td>
                                                <td><%=pdr_1.getRank()%></td>
                                                <!--td><%=pdr_1.getDate()%></td-->
                                                <td><%=pdr_1.getCategory()%></td>
                                            </tr> 
                                            <!--tr>
                                                <th><span class="desc">Category</span></th>
                                                <th><span class="desc">No. of Questions</span></th>
                                                <th><span class="desc">No. of Comments</span></th>
                                                <th><span class="desc">No. of Reviews</span></th>
                                            </tr>
                                            <tr>
                                                <td><%=pdqp.getCategory()%></td>
                                                <td><%=pdqp.getNquestions()%></td>
                                                <td><%=pdqp.getNcomments()%></td>
                                                <td><%=pdqp.getNreviews()%></td>
                                            </tr--> 
                                        </table> 
                                    </div>
                                </div>

                                <%}%>
                                <%}%>
                                <%} else {%>                    
                                <h5 style="color:red">Sorry No Information</h5>
                                <%}%>

                            </div>
                        </div>
                        <!--/div-->
                    </div>
                </div>



            </div>

            <!--Main Content End><-->

        </div>
        <!-- /.container -->
        <!--div class="container"-->

        <hr>

        <%@include file="../footer/footer.jsp" %>
