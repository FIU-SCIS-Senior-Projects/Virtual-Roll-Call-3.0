<?php
require_once('DBHandler.php');
$postdata = @file_get_contents("php://input");
$request = @json_decode($postdata);

$messageBy = $_POST['message_by'];
$message = $_POST['freeMsg'];
$title = $_POST['freeTitle'];

var_dump($_POST);

if ( $message && $title )
{
	$connection = new DBHandler();
	$result = $connection->uploadMessage($title, $message, $messageBy);
	//convert the response to a json object
	unset($_POST);
	$message = null;
	$title = null;
	die(json_encode($result));
}