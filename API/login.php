<?php
include 'conn.php';

$email = $_POST["user"];
$password = $_POST["pass"];

$sql = "SELECT * FROM login WHERE user = '$email' AND pass = '$password'";
$result = mysqli_query($conn, $sql);

$response = array();

if (mysqli_num_rows($result) > 0) {
  // Login successful, return success message
  $response["success"] = 1;
   $userSql = "SELECT loja,latitude,longitude FROM login WHERE user = '$email'";
  $userResult = mysqli_query($conn, $userSql);
  $userData = mysqli_fetch_assoc($userResult);

  // Add user data to response
  $response["loja"] = $userData["loja"];
  $response["latitude"] = $userData["latitude"];
  $response["longitude"] = $userData["longitude"];

  
} else {
  // Login failed, return error message
  $response["success"] = 0;
  
 
 
}

echo json_encode($response);

mysqli_close($conn);
?>
