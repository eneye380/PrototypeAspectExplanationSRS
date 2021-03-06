<%-- 
    Document   : header
    Created on : Jul 5, 2015, 1:45:58 PM
    Author     : eneye380
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.util.Date"%>
<!DOCTYPE html>
<%Date dd = new Date(); %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>  
        <!--script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script-->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> 
        <link rel="stylesheet" href="../../../css/style.css">        
         
        <script type="text/javascript" src="../../../js/main.js"></script>
        <script type="text/javascript" language="javascript" src="../../../js/explanationPlot.js"></script> 
        
        <style>
            body{
                
                padding-top: 70px;
            }
            footer{
                margin: 50px 0;
            }
            .aspect_selection{
                
                /**display: none;*/
            }
        </style>

        <!-- Bootstrap Core CSS -->
        <!--link href="../css/bootstrap.min.css" rel="stylesheet"-->

        <!-- Custom CSS -->
        <!--link href="../css/heroic-features.css" rel="stylesheet"-->

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <title>Explanations in SRS</title>
    </head>
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
                        <li>
                            <!--a href="#" hdref="../admin/">Management Console</a-->
                        </li>                        
                        <li>
                            <a href="../welcome/about.jsp">About</a>
                        </li>
                    </ul>
                    <span class="pull-right" style="color:rgb(255,247,217)"><%=dd%></span>
                    <p style="color:goldenrod" class="text-center"><strong>EXPLANATIONS IN SOCIAL RECOMMENDER SYSTEMS</strong><br>
                    <span style="color:whitesmoke"><em>Aspect Style Explanation</em></span></p>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>
