<html>
<head>
<title>php test</title>
</head>
<body>
<h1>{{ grains.id }}</h1>
</br>
<h2>mysql data</h2>
<?php
$dbhost = 'mysql1';
$dbuser = 'efhapp';
$dbpass = 'somepass';
$db = 'efhapp';
$conn = mysql_connect($dbhost, $dbuser, $dbpass);

if(! $conn )
{
  die('Could not connect: ' . mysql_error());
}

mysql_select_db($db, $conn);
$sql = "SELECT name FROM animals";
$result = mysql_query($sql, $conn);

if (mysql_num_rows($result) > 0) {
    while($row = mysql_fetch_assoc($result)) {
        echo "animal: " . $row["name"] . "<br>";
    }
} else {
    echo "0 results";
}
mysql_close($conn);
?>

</body>
</html>
