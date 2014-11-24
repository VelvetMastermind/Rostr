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
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="../assests/favicon.ico">

  <title>UWM - Pending Users</title>

  <!-- Bootstrap core CSS -->
  <link href="../css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="../css/dashboard.css" rel="stylesheet">
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

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
            <!-- My Profile not supported in Sprint 2
            <li><a href="#">My Profile</a></li>
            <li class="divider"></li>
            -->
            <li><a href="../LOGIN/LOGIN_Landing.jsp">Logout <span class="glyphicon glyphicon-off"></span></a></li>
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
        <li><a class="nav_item" href="ADMIN_Classes.jsp">Courses</a></li>
        <li><a class="nav_item" href="ADMIN_Contacts.jsp">Contacts</a></li>
      </ul>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <div class="panel panel-default">
        <div class="table-responsive">
          <div class="panel-heading">
            <h1>Pending Users</h1>
          </div>
          <table class="table table-striped sortable">
            <thead>
            <tr>
              <th>Name</th>
              <th>PantherID</th>
              <th>Room Number</th>
              <th>Phone Number</th>
              <th>Email</th>
              <th>Approve</th>
              <th>Deny</th>
            </tr>
            </thead>
            <tbody>
            <%
              DatastoreService datastore = rostrUtilities.getDatastore();
              Query gaeQuery = new Query("user");
              PreparedQuery pq = datastore.prepare(gaeQuery);
              List<Entity> list = pq.asList(FetchOptions.Builder.withDefaults());
              ArrayList<Entity> visible = new ArrayList<Entity>();
              for(Entity x : list)
              {
                if(x.getProperty("accessLevel").toString().equals("-1"))
                  visible.add(x);
              }
              for(Entity x : visible){
                String fullName = (String)x.getProperty("fullName");
                String pantherID = (String)x.getProperty("pantherID");
                String roomNumber = (String)x.getProperty("roomNumber");
                String phoneNumber = (String)x.getProperty("phoneNumber");
                String email = (String)x.getProperty("email");
            %>
            <tr><td> <%= fullName%>
            </td>
              <td> <%= pantherID%>
              </td>
              <td> <%= roomNumber%>
              </td>
              <td> <%= phoneNumber%>
              </td>
              <td> <%= email%>
              </td>
              <!-- Approve/Deny Buttons -->
              <td><p><button class="btn btn-success btn-xs" data-title="approve" data-toggle="modal" data-target="#approveUser" data-placement="top" rel="tooltip"><span class="glyphicon glyphicon-ok"></span></button></p></td>
              <td><p><button class="btn btn-danger btn-xs" data-title="deny" data-toggle="modal" data-target="#denyUser" data-placement="top" rel="tooltip"><span class="glyphicon glyphicon-remove"></span></button></p></td>
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

<!-- Approve User Modal -->
<div class="modal fade" id="approveUser" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                class="sr-only">Close</span></button>
        <h4 class="modal-title custom_align">Deny User</h4>
      </div>
      <div class="modal-body">
        <form role="form" method="post" action='/doApproveUser'>
          <div class="alert alert-warning">
            <span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to approve this user?
          </div>

          <div class='form-group'>
            This action <b>CANNOT</b> be undone.
            <b>Access Level</b>
            <br/>
            <input type="radio" name="newAccessLevel" value="0" checked> Admin
            <input type="radio" name="newAccessLevel" value="1"> Instructor
            <input type="radio" name="newAccessLevel" value="2"> TA
            <br/>
            <input type="text" class="form-control" name="confirmApprove" id="confirmApprove" placeholder="PantherID">
          </div>
          <div class="modal-footer"></div>
          <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-ok-sign"></span>Yes
          </button>
          <button type="button" class="btn btn-warning" data-dismiss="modal"><span
                  class="glyphicon glyphicon-remove"></span> No
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<!--Deny Modal -->
<div class="modal fade" id="denyUser" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                class="sr-only">Close</span></button>
        <h4 class="modal-title custom_align">Deny User</h4>
      </div>
      <div class="modal-body">
        <form role="form" method="post" action='/doDenyUser'>
          <div class="alert alert-warning">
            <span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to deny this user?
          </div>

          <div class='form-group'>
            This action <b>CANNOT</b> be undone. This will permanently delete the user.
            <br/>
            The user will have to sign up again to create a new account request.
            <br/>
            Please type in the user's PantherID to confirm.
            <br/>
            <br/>
            <input type="text" class="form-control" name="confirmDeny" id="confirmDeny" placeholder="PantherID">
          </div>
          <div class="modal-footer"></div>
          <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-ok-sign"></span>
            Yes
          </button>
          <button type="button" class="btn btn-warning" data-dismiss="modal"><span
                  class="glyphicon glyphicon-remove"></span> No
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade bs-example-modal-sm" id="editContactSuccess" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="alert alert-success">
        <br/>
        <span class="glyphicon glyphicon glyphicon-ok"></span> Success!
        <br/>
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
<script src="../../assets/js/docs.min.js"></script>
<script type="text/javascript">
  $(window).load(function(){
    $('#editContactSuccess').modal('show');
  });
</script>
<!-- Sortable JS -->
<script src="../js/sorttable.js"></script>
</body>
</html>
