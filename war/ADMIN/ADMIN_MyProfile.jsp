<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="com.velvetmastermind.rostr.rostrUtilities" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../assets/favicon.ico">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" href="../assets/favicon.ico">

    <title>UWM - My Profile</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">

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

<%
    DatastoreService datastore = rostrUtilities.getDatastore();
    Query gaeQuery = new Query("user");
    PreparedQuery pq = datastore.prepare(gaeQuery);
    List<Entity> list = pq.asList(FetchOptions.Builder.withDefaults());
    Entity currentUser = null;
    String name = "";
    Cookie userCookie = null;

    Cookie[] cookies = request.getCookies();
    ArrayList<Cookie> cooks = new ArrayList<Cookie>(Arrays.asList(cookies));

    for(Cookie c: cooks)
    {
        if(c != null) {
            if (c.getName().equals("Rostr")) {
                userCookie = c;
                break;
            }
        }
    }
    if(userCookie != null) {
        for (Entity user : list) {
            if (user.getProperty("username").toString().equals(userCookie.getValue())) {
                name = user.getProperty("fullName").toString();
                currentUser = user;
                break;
            }
        }
    }
    else{
        name = "Rostr'r";
    }
%>

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
        <!-- PROFILE -->
        <%
            Entity myProfileUser = null;
            String myProfileID = request.getParameter("pID");
            if(myProfileID != null)
            {
            for (Entity user : list)
                if (user.getProperty("username").toString().equals(myProfileID)) {
                    myProfileUser = user;
                }
            }
            else
                myProfileUser = currentUser;

        %>
        <div class="container">
            <div class="row">
                <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="well profile">
                        <div class="col-sm-12">
                            <div class="col-xs-12 col-sm-8">
                                <h2><%= myProfileUser.getProperty("fullName")%></h2>
                                <p><strong>Email: </strong> <%= myProfileUser.getProperty("email")%> </p>
                                <p><strong>Office Hours: </strong> <%= myProfileUser.getProperty("officeHours")%></p>
                                <p><strong>Phone Number: </strong> <%= myProfileUser.getProperty("phoneNumber")%> </p>
                                <p><strong>Room Number: </strong> <%= myProfileUser.getProperty("roomNumber")%></p>
                                <p><strong>Skills: </strong>
                                    <span class="tags">html5</span>
                                </p>
                            </div>
                            <div class="col-xs-12 col-sm-4 text-center">
                                <figure>

                                    <img src="http://www.localcrimenews.com/wp-content/uploads/2013/07/default-user-icon-profile.png" alt="" class="img-circle img-responsive">
                                </figure>
                            </div>
                        </div>
                        <div class="col-xs-12 divider text-center">
                            <div class="col-xs-12 col-sm-4 emphasis">
                                <h2><strong> 20,7K </strong></h2>
                                <p><small>Followers</small></p>
                                <button class="btn btn-success btn-block"><span class="fa fa-plus-circle"></span> Follow </button>
                            </div>
                            <div class="col-xs-12 col-sm-4 emphasis">
                                <h2><strong>245</strong></h2>
                                <p><small>Following</small></p>
                                <button class="btn btn-info btn-block"><span class="fa fa-user"></span> View Profile </button>
                            </div>
                            <div class="col-xs-12 col-sm-4 emphasis">
                                <h2><strong>43</strong></h2>
                                <p><small>Snippets</small></p>
                                <div class="btn-group dropup btn-block">
                                    <button type="button" class="btn btn-primary"><span class="fa fa-gear"></span> Options </button>
                                    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu text-left" role="menu">
                                        <li><a href="#"><span class="fa fa-envelope pull-right"></span> Send an email </a></li>
                                        <li><a href="#"><span class="fa fa-list pull-right"></span> Add or remove from a list  </a></li>
                                        <li class="divider"></li>
                                        <li><a href="#"><span class="fa fa-warning pull-right"></span>Report this user for spam</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#" class="btn disabled" role="button"> Unfollow </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Profile -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="text-center">
                <div class="row">
                    <div id="wrap">
                        <!-- CALENDAR -->
                        <div id="calendar" class="fc fc-ltr">
                            <table class="fc-header" style="width:100%">
                                <tbody>
                                <tr>
                                    <td class="fc-header-left"><span class="fc-header-title"><h2>December
                                        2014</h2></span></td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="fc-content" style="position: relative;">
                                <div class="fc-view fc-view-month fc-grid" style="position:relative" unselectable="on">
                                    <div class="fc-event-container" style="position:absolute;z-index:8;top:0;left:0">
                                        <%--<div class="fc-event fc-event-hori fc-event-draggable fc-event-start fc-event-end ui-draggable"
                                             style="position: absolute; left: 2px; width: 122px; top: 66px;"
                                             unselectable="on">
                                            <div class="fc-event-inner"><span
                                                    class="fc-event-title">All Day Event</span></div>
                                            <div class="ui-resizable-handle ui-resizable-e">&nbsp;&nbsp;&nbsp;</div>
                                        </div>--%>
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
                                            <div class="fc-event-inner"><span
                                                    class="fc-event-title">Click for Google</span></div>
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
                                            <th class="fc-day-header fc-tue fc-widget-header" style="width: 128px;">
                                                Tue
                                            </th>
                                            <th class="fc-day-header fc-wed fc-widget-header" style="width: 128px;">
                                                Wed
                                            </th>
                                            <th class="fc-day-header fc-thu fc-widget-header" style="width: 128px;">
                                                Thu
                                            </th>
                                            <th class="fc-day-header fc-fri fc-widget-header" style="width: 128px;">
                                                Fri
                                            </th>
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
                                            <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2014-12-02">
                                                <div>
                                                    <div class="fc-day-number">2</div>
                                                    <div class="fc-day-content">
                                                        <div style="position: relative; height: 18px;">&nbsp;</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2014-12-03">
                                                <div>
                                                    <div class="fc-day-number">3</div>
                                                    <div class="fc-day-content">
                                                        <div style="position: relative; height: 18px;">&nbsp;</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2014-12-04">
                                                <div>
                                                    <div class="fc-day-number">4</div>
                                                    <div class="fc-day-content">
                                                        <div style="position: relative; height: 18px;">&nbsp;</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2014-12-05">
                                                <div>
                                                    <div class="fc-day-number">5</div>
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
                        </div>
                        <div style="clear:both"></div>
                    </div>
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
