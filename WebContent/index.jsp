
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    

    <title>Signin Page</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">
 <SCRIPT type="text/javascript">
    window.history.forward(1);
    browser.cache.offline.enable = false; 
    function noBack() { window.history.forward(); }
</SCRIPT>
  
  </head>

  <body  onload="noBack();"
   onpageshow="if (event.persisted) noBack();" onunload="">
  
  
  <div class="container">
      <div class="header">
        
        <h3 class="text-muted">Welcome to Oil Transaction Management System(OTMS)</h3>
        <br>
        <h4>This demo is part of CS6360 Database Design Course</h4>
      </div>
	 </div>
    <div class="container">

      <form class="form-signin" action="login" role="form">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">User id</label>
        <input type="text" name="user" id="inputUserid" class="form-control" placeholder="User ID" required autofocus>
        
        <label for="inputPassword"   class="sr-only">Password</label>
        <input type="password" name="pwd" id="inputPassword" class="form-control" placeholder="Password" required>
        
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->


    
  </body>
</html>
