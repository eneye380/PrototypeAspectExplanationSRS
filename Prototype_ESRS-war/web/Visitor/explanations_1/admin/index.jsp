<%-- 
    Document   : index
    Created on : Aug 7, 2015, 10:15:27 PM
    Author     : eneye380
--%>

<%@page import="aspect.bean.CategoryChoiceSB"%>
<%--Visitor/explanations/products/products.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.bean.CategorySB"%>
<%@page import="aspect.bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.bean.ProductSB"%>
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

        <%--jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/--%>
        <%--jsp:getProperty name="category" property="catSet"/--%>
        <%--
            ArrayList<CategorySB> c = category.getCatSet();

        --%>

        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            ArrayList<String> psswords = new ArrayList();
            psswords.add("pxstar");
            psswords.add("root");
            if (username == null) {
                username = "default";
            }
            
            if(psswords.contains(password)){
                pageContext.setAttribute("username", username);
            }
            if (username != null) {
                pageContext.setAttribute("user", username,PageContext.SESSION_SCOPE);
        %>
<js>
        <p>Hello, (You can
            <a href="<%= request.getRequestURI()%>">sign out</a>.)</p>
        <p><%=username%></p>
        <p><%=password%></p>
        <p><%=pageContext.getAttribute("user",PageContext.SESSION_SCOPE)%></p>
        <jsp:forward page="adminconsole.jsp?category=digital slr" />
            <%
            } else {
            %>
        <p>Hello!
            <a href="<%=request.getRequestURI()%>">Sign in</a>
            to include your name with greetings you post.</p>
            <%
                }
            %>

        <div class="jumbotron" style="background: rgb(10,50,50);color: #2e6da4">
            <div style="margin: 100px">
                <form action="index.jsp" method="post">
                    <table style="margin: auto;text-align: center;" class="text-capitalize">
                        <tr>
                            <td>Username</td>
                            <td><input type="text" name="username" placeholder="username"></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input type="password" name="password" placeholder="password"></td>
                        </tr>
                        <tr>

                            <td colspan="2"><input type="submit" value="LOGIN"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>



</div>
</div>
<!-- /.container -->
<div class="container">

    <hr>

    <%@include file="../footer/footer.jsp" %>

