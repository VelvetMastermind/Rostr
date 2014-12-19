<%@ page import='com.google.appengine.api.datastore.DatastoreService' %>
<%@ page import='com.google.appengine.api.datastore.DatastoreServiceFactory' %>
<%@ page import='com.google.appengine.api.datastore.Entity' %>
<%@ page import='com.google.appengine.api.datastore.FetchOptions' %>
<%@ page import='com.google.appengine.api.datastore.Key' %>
<%@ page import='com.google.appengine.api.datastore.KeyFactory' %>
<%@ page import='com.google.appengine.api.datastore.Query' %>
<%@ page import='com.velvetmastermind.rostr.*' %>
<%@ page import='java.util.List' %>
<%@ page import='com.google.appengine.api.datastore.PreparedQuery' %>
<!DOCTYPE html>
<html>
<head lang='en'>
    <meta charset='UTF-8'>
    <title>Rostr</title>
    <link rel='icon' href='../assests/favicon.ico'>
    <link href='../css/bootstrap.min.css' rel='stylesheet'>
    <link href='../css/login.css' rel='stylesheet'>

    <!-- Custom font for Rostr logo -->
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <!-- Font Awesome -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

</head>
<body>
<div class='container' style='margin-top:180px'>
    <h1 class='sub-header text-center rostrHeader'>Rostr</h1>
    <div class='col-md-4 col-md-offset-4'>
        <div class='panel panel-default'>
            <div class='panel-heading'>
                Please login
            </div>
            <div class='panel-body'>
                <!-- CREATE ADMIN
                <form role='form' action='/doAddAdmin' method='POST'>
                    <div class='btn-group'>
                        <input type='submit' class='btn btn-success btn-sm' value='ADD ADMIN'/>
                    </div>
                </form>
                <br>
                -->
                <form role='form' action='/doLogin' method='POST'>
                    <div class='form-group'>
                        <label for='email' class='sr-only'>Email address</label>
                        <div class='input-group'>
                            <span class='input-group-addon'><span class='glyphicon glyphicon-user'></span></span>
                            <input type='text' class='form-control' id='username' name='username'
                                   placeholder='ePantherID' required autocomplete='on'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='password' class='sr-only'>Password</label>
                        <div class='input-group'>
                            <span class='input-group-addon'><span class='glyphicon glyphicon-lock'></span> </span>
                            <input type='password' class='form-control' id='password' name='password'
                                   placeholder='Password' required autocomplete='on'>
                        </div>
                        <!-- Forgot Password is not supported for Sprint 2
                        <a href='#' class='pull-right small'>Forgot password?</a>
                        -->
                    </div>
                    <!--  Remember me is not supported for Sprint 2
                    <div class='checkbox'>
                        <label>
                            <input type='checkbox'> Remember Me
                        </label>
                    </div>
                    -->
                    <input type='submit' class='btn btn-success btn-sm' value='Login'/>
                    <br/>
                </form>
                <br/>
                <form>
                    <button class='btn btn-primary btn-xs' data-title='New User' data-toggle='modal' data-target='#addUser' data-placement='top' rel='tooltip'>New User</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<!-- New User Modal -->
<div class='modal fade' id='addUser' tabindex='-1' role='dialog' aria-labelledby='addUser' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span
                        class='sr-only'>Close</span></button>
                <h4 class='modal-title' id='myModalLabel'>Create an Account</h4>
            </div>
            <div class='modal-body'>
                <form role='form' method='POST' action='/doAddNewUser'>
                    <div class='form-group'>
                        <label for='fullName'>Full Name</label>
                        <input type='text' class='form-control' name='fullName' id='fullName' placeholder='Full Name'
                               required>
                    </div>
                    <div class='form-group'>
                        <label for='pantherID'>PantherID <label class='small'>(This will be your
                            username)</label></label>
                        <input type='text' class='form-control' name='pantherID' id='pantherID' placeholder='PantherID'
                               required>
                    </div>
                    <div class="form-group">
                        <label for="skills">Skills</label>
                        <input type="text" class="form-control" name="skills" id="skills" placeholder="Skills (Separate with semi-colon)" required>
                    </div>
                    <div class='form-group'>
                        <label for='email'>Email</label>
                        <input type='email' class='form-control' name='email' id='email'
                               placeholder='Email' required>
                    </div>
                    <div class='form-group'>
                        <label for='newPassword'>Password</label>
                        <input type='password' class='form-control' name='newPassword' id='newPassword'
                               placeholder='Password' required>
                    </div>
                    <div class='form-group'>
                        <label for='roomNumber'>Office Number</label>
                        <input type='text' class='form-control' name='roomNumber' id='roomNumber'
                               placeholder='Room Number' required>
                    </div>
                    <div class='form-group'>
                        <label for='phoneNumber'>Phone Number</label>
                        <input type='tel' class='form-control' name='phoneNumber' id='phoneNumber'
                               placeholder='Phone Number' pattern="^(?:\(\d{3}\)|\d{3})[- ]?\d{3}[- ]?\d{4}$" required>
                    </div>
                    <div class='form-group'>
                        <label for='officeHours'>Office Hours</label>
                        <input type='text' class='form-control' name='officeHours' id='officeHours'
                               placeholder='Office Hours (separate by semi-colon)' required>
                        <label>
                            <small>In format of : 2:00PM-3:00PM MWF;9:00AM-10:00AM TR</small>
                        </label>
                    </div>
                    <input type='submit' class='btn btn-success btn-sm' value='Submit'/>
                </form>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
        ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script src='http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js'></script>
<script src='../../dist/js/bootstrap.min.js'></script>
<script src='../../assets/js/docs.min.js'></script>
<!-- Sortable JS -->
<script src='../js/sorttable.js'></script>

</body>
</html>