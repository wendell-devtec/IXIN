<?php

include 'conn.php';

$id=$_POST['id'];
$status = $_POST['status'];



$conn->query("UPDATE solicitacao_produtos SET status='$status' WHERE id ='".$id."'");
 

?>