<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.velvetmastermind.rostr.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<!DOCTYPE html>
<html lang="en">
<head>
<<<<<<< Updated upstream
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../assets/favicon.ico">
=======
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" type="image/png" href="/../assests/favicon.ico">
>>>>>>> Stashed changes

    <title>UWM - My Profile</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom styles for calendar -->
    <link href="../css/fullcalendar.css" rel="stylesheet">
    <link href="../css/fullcalendar.print.css" rel="stylesheet">

    <!-- Custom styles for Large Nav buttons -->
    <link href="../css/largeNav.css" rel="stylesheet">

    <!-- Custom font for Rostr logo -->
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>

</head>

<body>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="ADMIN_Landing.jsp">Rostr</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="ADMIN_Landing.jsp">Dashboard</a></li>
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Profile<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="ADMIN_MyProfile.jsp">My Profile</a></li>
                        <li class="divider"></li>
                        <li><a href="../LOGIN/LOGIN_Landing.jsp">Logout <span
                                class="glyphicon glyphicon-off"></span></a></li>
                    </ul>
                </li>
            </ul>
            <!-- Search not supported in Sprint 2
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
            -->
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="nav_item"><a class="nav_item" href="ADMIN_Landing.jsp">Dashboard</a></li>
                <li><a class="nav_item" href="ADMIN_Classes.jsp">Courses</a></li>
                <li><a class="nav_item" href="ADMIN_Contacts.jsp">Contacts</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="text-center">
                <div class="row">

                </div>
            </div>
        </div>

        <!-- Processing Modal -->
        <div class="modal fade" id="sendEmail" tabindex="-1" role="dialog" aria-labelledby="sendEmail"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span
                                class='sr-only'>Close</span></button>
                        <h4>Send Email</h4>
                    </div>
                    <form action="/doSendEmail" method="POST" class="form-group" id="doSendEmail">
                        <div class="modal-body form-group">
                            <div class="form-group">
                                <label for="emailRecipients">Recipients</label>
                                <input type="text" class="form-control" id="emailRecipients" name="emailRecipients"
                                       placeholder="Recipients"/>
                            </div>
                            <div class="form-group">
                                All <input type="radio" id="sendAll" name="groupRecipients" value="0">
                                &nbsp;&nbsp;&nbsp;&nbsp; Instructors <input type="radio" id="sendInstructors"
                                                                            name="groupRecipients" value="1">
                                &nbsp;&nbsp;&nbsp;&nbsp; TAs <input type="radio" id="sendTAs" name="groupRecipients"
                                                                    value="2">
                            </div>
                            <div class="form-group">
                                <label for="sendMessage">Message:</label>
                                <textarea class="form-control" id="sendMessage" name="sendMessage" placeholder="Message"
                                          rows="5"></textarea>
                            </div>
                            <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
<script src="../js/docs.min.js"></script>
<!-- Sortable JS -->
<script src="../js/sorttable.js"></script>
<!-- Calendar JS -->
<script src="../jquery/fullcalendar.js"></script>
<script src="../jquery/jquery-1.10.2.js"></script>
<script src="../jquery/jquery-ui.custom.min.js"></script>
</body>
</html>
