<?php

include 'conn.php';

$id=$_POST['id'];
$status = $_POST['status'];



$conn->query("UPDATE encomenda_clientes SET status='$status' WHERE id ='".$id."'");
 

?>