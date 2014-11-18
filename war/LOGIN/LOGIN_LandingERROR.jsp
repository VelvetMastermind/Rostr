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

</head>
<body>
<div class='container' style='margin-top:180px'>
    <h1 class='sub-header text-center rostrHeader'>Rostr</h1>
    <div class='col-md-4 col-md-offset-4'>
        <div class='panel panel-default'>
            <div class='panel-heading'>
                Please login<br>
                <div class='alert alert-danger'><span class='glyphicon glyphicon-exclamation-sign'></span> Username/Password is Incorrect </div>
            </div>
            <div class='panel-body'>
                <form role='form' action='/doLogin' method='POST'>
                    <div class='form-group'>
                        <label for='email' class='sr-only'>Email address</label>
                        <div class='input-group'>
                            <span class='input-group-addon'><span class='glyphicon glyphicon-user'></span></span>
                            <input type='username' class='form-control' id='username' name='username'
                                   placeholder='ePantherID' required>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='password' class='sr-only'>Password</label>
                        <div class='input-group'>
                            <span class='input-group-addon'><span class='glyphicon glyphicon-lock'></span> </span>
                            <input type='password' class='form-control' id='password' name='password'
                                   placeholder='Password' required>
                        </div>
                        <!-- Forgot Password is not supported for Sprint 1
                        <a href='#' class='pull-right small'>Forgot password?</a>
                        -->
                    </div>
                    <!--  Remember me is not supported for Sprint 1
                    <div class='checkbox'>
                        <label>
                            <input type='checkbox'> Remember Me
                        </label>
                    </div>
                    -->
                    <input type='submit' class='btn btn-success btn-sm' value='Login'/>
                </form>
            </div>
        </div>
    </div>
</div>
</div>


</body>
</html>