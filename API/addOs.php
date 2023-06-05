<?php

include 'conn.php';
$loja = $_POST['loja'];
$data = $_POST['data'];
$produto = $_POST['produto'];
$number = $_POST['os_number'];
$seller = $_POST['vendedor'];
$status = $_POST['status'];


$conn->query("INSERT INTO ordem_servico(loja,data,produto,os_number,vendedor,status) values('".$loja."','".$data."','".$produto."','".$number."','".$seller."','".$status."')")
?>

