<?php

include 'conn.php';

$sql = $conn->query("SELECT * FROM loja");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>