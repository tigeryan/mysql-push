<!DOCTYPE html>
<head>
  <title>Pusher Test</title>
  <script src="//js.pusher.com/2.2/pusher.min.js" type="text/javascript"></script>
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
      alert(data.text);
    });
  </script>
</head>
<body>

<cfquery name="getData" datasource="#application.datasource#">
    SELECT *
    FROM products
    ORDER BY product_id
</cfquery>


<cfdump var="#getData#">

</body>
</html>
