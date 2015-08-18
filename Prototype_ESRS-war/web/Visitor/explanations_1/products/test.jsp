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
            <input type="checkbox" value="B003VWDSJO" name="s">
                <input type="checkbox" value="B00427Z7N2" name="s">
                <input type="checkbox" value="B009W7WW26" name="s">
                <input type="submit" value="add">
                </form>
                <form method="post">
                    <fieldset>
                        <legend>What is Your Favorite Pet?</legend>
                        <input type="checkbox" name="product" value="B003VWDSJO" />B003VWDSJO <br />
                        <input type="checkbox" name="product" value="B00427Z7N2" />B00427Z7N2<br />
                        <input type="checkbox" name="product" value="B009W7WW26" />B009W7WW26<br />
                        <input type="button" value="add" />
                    </fieldset>
                </form>
                <dialog id="window">
                    <h3>Hello World</h3>
                    <p>hekkshhs hdhdh lslls hdggfgf</p>
                    <button id="exit">Exit</button>>
                </dialog>
                <button id="show">show dialog</button>

                <!-- Trigger the modal with a button -->
                <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

                <!-- Modal -->
                <div id="myModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Modal Header</h4>
                            </div>
                            <div class="modal-body">
                                <p>Some text in the modal.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>

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
