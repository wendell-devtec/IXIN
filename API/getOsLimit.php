<?php

include 'conn.php';

$loja = $_GET['loja'];



$sql = $conn->query("SELECT * FROM ordem_servico WHERE loja = $loja ORDER BY data DESC LIMIT 1");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
    }

echo json_encode($res);


?>