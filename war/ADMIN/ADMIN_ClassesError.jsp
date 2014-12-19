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
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../assets/favicon.ico">

    <title>UWM - Courses</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

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
                        <li><a href="ADMIN_MyProfile.jsp?pID=<%= currentUser.getProperty("pantherID")%>">My Profile</a></li>
                        <li class="divider"></li>
                        <li><a href="javascript: logout()">Logout<span class="glyphicon glyphicon-off"></span></a></li>
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
                <li><a class="nav_item" href="ADMIN_Landing.jsp">Dashboard</a></li>
                <li class="active"><a class="nav_item" href="ADMIN_Classes.jsp">Courses</a></li>
                <li><a class="nav_item" href="ADMIN_Contacts.jsp">Contacts</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="table-responsive">
                    <div class="panel-heading">
                        <h1>Courses</h1>
                    </div>
                    <table class="table table-striped sortable">
                        <thead>
                        <tr>
                            <th>Course</th>
                            <th>Section</th>
                            <th>Times</th>
                            <th>Days</th>
                            <th>Instructor</th>
                            <th>Room</th>
                            <th>Course Number</th>
                            <% if(Integer.parseInt(currentUser.getProperty("accessLevel").toString()) == 0) { %>
                            <th>Edit</th>
                            <th>Delete</th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                        	gaeQuery = new Query("course");
							pq = datastore.prepare(gaeQuery);
							list = pq.asList(FetchOptions.Builder.withDefaults());
							for(Entity x : list){
                                String className = (String)x.getProperty("className");
                                String section = (String)x.getProperty("section");
                                String hours = (String)x.getProperty("hours");
                                String days = (String)x.getProperty("days");
                                String instructor = (String)x.getProperty("instructor");
                                String room = (String)x.getProperty("room");
                                String courseNumber = (String)x.getProperty("courseNumber");
							
                                %>
                                <tr><td> <%= className%>
                                </td>
                                <td> <%= section%>
                                </td>
                                <td> <%= hours%>
                                </td>
                                <td> <%= days%>
                                </td>
                                <td> <%= instructor%>
                                </td>
                                <td> <%= room%>
                                </td>
                                <td> <%= courseNumber%>
                                </td>
                                <!-- Edit/Delete Buttons -->
                                    <% if(Integer.parseInt(currentUser.getProperty("accessLevel").toString()) == 0) { %>
                                <td><p><button class="btn btn-primary btn-xs" id='<%= courseNumber + "EDIT"%>' data-title="Edit" data-toggle="modal" data-target="#editCourse" data-placement="top" rel="tooltip"><span class="glyphicon glyphicon-pencil"></span></button></p></td>
                                <td><p><button class="btn btn-danger btn-xs" id='<%= courseNumber + "DELETE"%>' data-title="Delete" data-toggle="modal" data-target="#delete" data-placement="top" rel="tooltip"><span class="glyphicon glyphicon-trash"></span></button></p></td>
                                    <% } %>
                          <%  }
						%>
                       <!-- NOT SUPPORTED IN SPRINT 2
                       <tr class="add_class">
                            <td><a href="#" class="add_class" data-toggle="modal" data-target="#myModal">ADD CLASS <span class="glyphicon glyphicon-plus"></span> </a></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- EDIT Class Modal -->
<div class="modal fade" id="editCourse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Course</h4>
            </div>
            <div class='panel-heading'>
                There was an error<br>
                <div class='alert alert-danger'><span class='glyphicon glyphicon-exclamation-sign'></span> Course Number Does Not Exist </div>
            </div>
            <div class="modal-body">
                <form role="form" method="POST" action="/doEditCourse">
                    <div class="form-group">
                        <label for="assignClassName">Course Name</label>
                        <input type="text" class="form-control" name="assignClassName" id="assignClassName" placeholder="COMPSCI-361: Intro to Software Engineering">
                    </div>
                    <div class="form-group">
                        <label for="assignSection">Section</label>
                        <input type="text" class="form-control" name="assignSection" id="assignSection" placeholder="401">
                    </div>
                    <div class="form-group">
                        <label for="assignTime">Time</label>
                        <input type="text" class="form-control" name="assignTime" id="assignTime" placeholder="1:00 PM-2:50 PM">
                    </div>
                    <div class="form-group">
                        <label for="assignDays">Days</label>
                        <input type="text" class="form-control" name="assignDays" id="assignDays" placeholder="TWR">
                    </div>
                    <div class="form-group">
                        <label for="assignInstructor">Instructor</label>
                        <input type="text" class="form-control" name="assignInstructor" id="assignInstructor" placeholder="Jayson Rock"/>
                    </div>
                    <div class="form-group">
                        <label for="assignRoom">Room</label>
                        <input type="text" class="form-control" name="assignRoom" id="assignRoom" placeholder="EMS E160">
                    </div>
                    <div class="form-group">
                        <label for="assignUnits">Units</label>
                        <input type="text" class="form-control" name="assignUnits" id="assignUnits" placeholder="3">
                    </div>
                    <div class="form-group">
                        <label for="assignCourseNumber">Course Number</label>
                        <input type="text" class="form-control" name="assignNumber" id="assignNumber" placeholder="40581">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close <span class="fa-close"></span></button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!--Delete Modal -->
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
            </div>
            <form method="post" action='ADMIN_Classes.jsp'>
                <div class='form-group'>
                    This action <b>CANNOT</b> be undone. This will permanently delete the course.
                    <br/>
                    Please type in the name of the repository to confirm.
                    <input type='text' class="form-control" name="confirmDelete" id="confirmDelete" placeholder="Course Number">
                </div>
                <div class="modal-footer"></div>
                <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-ok-sign"></span>Yes</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
        </div>
        </form>
    </div>
</div>
</div>
<form action="/logout" method="POST" name="logout"></form>


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
<script src="../../assets/js/docs.min.js"></script>
<script>
    function logout()
    {
        document.logout.submit();
    }
</script>
<script type="text/javascript">
    $(window).load(function(){
        $('#editCourse').modal('show');
    });
</script>
<!-- Sortable JS -->
<script src="../js/sorttable.js"></script>
</body>
</html>
