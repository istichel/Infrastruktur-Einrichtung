<!DOCTYPE html>
<html>
<head>
  <title>Deployment</title>
  <meta charset="utf-8">
   <link href="/static/style.css" rel="stylesheet" type="text/css">
</head>
<body>

  <h1>Moin Moin!</h1>
  <h2>Euer Projekt: {{p}}</h2>

  <form action="/action" method="post">
    <input type="hidden" name="projekt" value="{{p}}">
    <input type="submit" name="action" value="redeploy">
    <input type="submit" name="action" value="stoppen">
    <input type="submit" name="action" value="starten">
  </form>

</body>
</html>
