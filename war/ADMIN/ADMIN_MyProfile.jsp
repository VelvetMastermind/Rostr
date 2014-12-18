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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../assets/favicon.ico">

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
                    <!-- CONTENT GOES HERE! -->
                    <div id="calendar" class="fc fc-ltr">
                        <table class="fc-header" style="width:100%">
                            <tbody>
                            <tr>
                                <td class="fc-header-left">
                                    <span class="fc-header-title"><h2>December 2014</h2></span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="fc-content" style="position: relative;">
                            <div class="fc-view fc-view-month fc-grid" style="position:relative" unselectable="on">
                                <div class="fc-event-container" style="position:absolute;z-index:8;top:0;left:0">
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end"
                                         style="position: absolute; left: 2px; width: 122px; top: 66px;">
                                        <div class="fc-event-inner"><span class="fc-event-title">All Day Event</span>
                                        </div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end info"
                                         style="position: absolute; left: 2px; width: 122px; top: 279px;">
                                        <div class="fc-event-inner"><span class="fc-event-time">4p</span><span
                                                class="fc-event-title">Repeating Event</span></div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end info"
                                         style="position: absolute; left: 2px; width: 122px; top: 385px;">
                                        <div class="fc-event-inner"><span class="fc-event-time">4p</span><span
                                                class="fc-event-title">Repeating Event</span></div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end important"
                                         style="position: absolute; left: 387px; width: 121px; top: 279px;">
                                        <div class="fc-event-inner"><span class="fc-event-time">10:30a</span><span
                                                class="fc-event-title">Meeting</span></div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end important"
                                         style="position: absolute; left: 387px; width: 121px; top: 298px;">
                                        <div class="fc-event-inner"><span class="fc-event-time">12p</span><span
                                                class="fc-event-title">Lunch</span></div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end"
                                         style="position: absolute; left: 515px; width: 121px; top: 279px;">
                                        <div class="fc-event-inner"><span class="fc-event-time">7p</span><span
                                                class="fc-event-title">Birthday Party</span></div>
                                        <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                    <a href="http://google.com/"
                                       class="fc-event fc-event-hori fc-event-draggable fc-event-start success"
                                       style="position: absolute; left: 771px; width: 128px; top: 385px;">
                                        <div class="fc-event-inner"><span class="fc-event-title">Click for Google</span>
                                        </div>
                                    </a><a href="http://google.com/"
                                           class="fc-event fc-event-hori fc-event-draggable fc-event-end success"
                                           style="position: absolute; left: 0px; width: 125px; top: 491px;">
                                    <div class="fc-event-inner"><span class="fc-event-title">Click for Google</span>
                                    </div>
                                    <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                </a></div>
                                <table class="fc-border-separate" style="width:100%" cellspacing="0">
                                    <thead>
                                    <tr class="fc-first fc-last">
                                        <th class="fc-day-header fc-mon fc-widget-header fc-first"
                                            style="width: 128px;">Mon
                                        </th>
                                        <th class="fc-day-header fc-tue fc-widget-header" style="width: 128px;">Tue</th>
                                        <th class="fc-day-header fc-wed fc-widget-header" style="width: 128px;">Wed</th>
                                        <th class="fc-day-header fc-thu fc-widget-header" style="width: 128px;">Thu</th>
                                        <th class="fc-day-header fc-fri fc-widget-header" style="width: 128px;">Fri</th>
                                        <th class="fc-day-header fc-sat fc-widget-header" style="width: 128px;">Sat</th>
                                        <th class="fc-day-header fc-sun fc-widget-header fc-last">Sun</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="fc-week fc-first">
                                        <td class="fc-day fc-mon fc-widget-content fc-past fc-first"
                                            data-date="2014-12-01">
                                            <div style="min-height: 106px;">
                                                <div class="fc-day-number">1</div>
                                                <div class="fc-day-content">
                                                    <div style="position: relative; height: 18px;">&nbsp;</div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div> <!-- End calendar -->
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
