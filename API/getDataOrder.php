<?php

include 'conn.php';

$loja = $_GET['loja'];


$sql = $conn->query("SELECT * FROM encomenda_clientes WHERE loja = $loja ORDER BY data DESC");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>