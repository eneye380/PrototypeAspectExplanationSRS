<%-- 
    Document   : test
    Created on : Aug 16, 2015, 8:26:26 PM
    Author     : eneye380
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        
        <form action="product-comparison.jsp">
                <input type="hidden" value="B003VWDSJO" name="s1">
                <input type="hidden" value="B003VWDSJO" name="s2">
                <input type="hidden" value="B003VWDSJO" name="s3">
                <input type="submit" value="add">
        </form>
        <dialog id="window">
            <h3>Hello World</h3>
            <p>hekkshhs hdhdh lslls hdggfgf</p>
            <button id="exit">Exit</button>>
        </dialog>
    <button id="show">show dialog</button>
        <script>
            (function(){
                
                var dialog = document.getElementById('window');
                document.getElementById('show').onclick() = function(){
                    dialog.show();
                };
                document.getElementById('exit').onclick() = function(){
                    dialog.close();
                };
                
                
            })();
            </script>
    </body>
</html>
