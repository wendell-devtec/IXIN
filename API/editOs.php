<?php

include 'conn.php';

$id=$_POST['id'];
$status = $_POST['status'];



$conn->query("UPDATE ordem_servico SET status='$status' WHERE id ='".$id."'");
 

?>