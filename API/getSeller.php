<?php

include 'conn.php';

$loja = $_GET['loja'];



$sql = $conn->query("SELECT * FROM vendedor");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>