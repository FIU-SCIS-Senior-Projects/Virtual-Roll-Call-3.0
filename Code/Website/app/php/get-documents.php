<?php
session_start();
require_once('DBHandler.php');
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
$type = $request->type;
$user_id = $request->user_id;
$connection = new DBHandler();
$result = $connection->getDocuments($type, $user_id);
$_SESSION["active"] = $user_id;
die(json_encode($result));