<%-- 
    Document   : sidebar
    Created on : Jul 16, 2015, 7:45:37 PM
    Author     : eneye380
--%>

<%@page import="aspect.bean.CategorySB"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/>
<%--jsp:getProperty name="category" property="catSet"/--%>
<%
    ArrayList<CategorySB> c = category.getCatSet();

%>


<div class="btn-group" style="margin-top: 5px;">
    <button type="button" class="btn btn-primary" id="button_category">Category</button>
</div>
<div class="category_selection" style="margin-top: 5px;display1:none">
    <div class="list-group ">
        <%for (int r = 0; r < c.size(); r++) {%>
        <%CategorySB ct = c.get(r);%>


        <a href="../products/category.jsp?category=<%=ct.getCategory()%>" class="list-group-item "><%=ct.getCategory()%></a>                    
        <%}%>
    </div>

</div>
<!--div class="btn-group" style="margin-top: 10px">
    <button type="button" class="btn btn-primary" id="button_aspect">Aspects</button>
</div>
<div class="aspect_selection">
    <form onclick1="showMe()">
        <div class="checkbox"><label><input type="checkbox" value="style" name="aspect" class=" ">Style</label></div>
        <div class="checkbox"><label><input type="checkbox" value="performance" name="aspect" class="asp_sel">Performance</label></div>
        <div class="checkbox"><label><input type="checkbox" value="range" name="aspect" class="asp_sel">Range</label></div>
        <div class="checkbox"><label><input type="checkbox" value="sense" name="aspect" class="asp_sel">Sense</label></div>
        <div class="checkbox"><label><input type="checkbox" value="advantage" name="aspect" class="asp_sel">Advantage</label></div>
        <div class="checkbox"><label><input type="checkbox" value="result" name="aspect" class="asp_sel">Result</label></div>
        <div class="checkbox"><label><input type="checkbox" value="capability" name="aspect" class="asp_sel">Capabilty</label></div>
        <div class="checkbox"><label><input type="checkbox" value="color" name="aspect" class="asp_sel">Color</label></div>
        <div class="checkbox"><label><input type="checkbox" value="processing" name="aspect" class="asp_sel">Processing</label></div>
        <div class="checkbox"><label><input type="checkbox" value="notice" name="aspect" class="asp_sel">Notice</label></div>
    </form>

</div-->