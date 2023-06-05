<?php

include 'conn.php';
$nome = $_POST['nome'];
$nomePText = $_POST['nome_p'];
$date = $_POST['data'];
$status = $_POST['status'];

$conn->query("INSERT INTO sugestion_produtos(nome_p,data,nome,status) values('".$nomePText."','".$date."','".$nome."','".$status."')")
?>

