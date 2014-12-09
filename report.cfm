<!DOCTYPE html>
<head>
    <title>Pusher Test</title>
    <script src="//js.pusher.com/2.2/pusher.min.js" type="text/javascript"></script>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script type="text/javascript">
    // Enable pusher logging - don't include this in production
    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };

    var pusher = new Pusher('7af9fad3df855a1968e5');
    var channel = pusher.subscribe('product-report');
    channel.bind('message', function(data) {
        //alert(data.text);
        if (data.text == 'reload') {
            $.ajax({
                type:"POST",
                url: "http://127.0.0.1:8600/mysql-push/push.cfc?method=getReport"
            })
            .done(function ( res ) {
                 $("#report").html(res);
            });
        }

    });


            $.ajax({
                type:"POST",
                url: "http://127.0.0.1:8600/mysql-push/push.cfc?method=getReport"
            })
            .done(function ( res ) {
                $("#report").html(res);
            });



  </script>
</head>
<body>

<div id="report"></div>

</body>
</html>
