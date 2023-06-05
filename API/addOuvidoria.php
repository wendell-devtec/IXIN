<?php

include 'conn.php';
$nome = $_POST['nome'];
$sacText = $_POST['sac_text'];
$date = $_POST['data'];

$conn->query("INSERT INTO ouvidoria(nome,sac_text,data) values('".$nome."','".$sacText."','".$date."')")
?>

