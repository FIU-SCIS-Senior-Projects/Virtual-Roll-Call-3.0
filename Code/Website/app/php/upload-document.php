<?php
require_once('DBHandler.php');

$document_name = $_FILES['document']['name'];
$tmp_doc_name = $_FILES['document']['tmp_name'];
$new_name = $_POST['document_name'];
$document_description = $_POST['document_description'] == '' ? $new_name : $_POST['document_description'];
$doc_extension = pathinfo($document_name,PATHINFO_EXTENSION);
$category_id = $_POST['category_id'];
$uploaded_by = $_POST['uploaded_by'];
if(isset($_POST['pinned']) && $_POST['pinned'] == '1'){
    $pinned = 1;
}else{
    $pinned = 0;
}
date_default_timezone_set('America/New_York');
$upload_date = date('Y-m-d');

$ds = DIRECTORY_SEPARATOR;
$target_path = __DIR__.$ds.'uploads'.$ds.$document_name;

echo $tmp_doc_name;
echo "\n";
echo $target_path;
echo "\n";
echo  $_FILES['document']['error'];

if (move_uploaded_file($tmp_doc_name, $target_path)){
echo " This should mean that the file was upload ";
}else{
echo "This will mean that the file could not be able to move to the place ---------- ";
}


if(file_exists($target_path)){
        echo "file Exist";
}else{
        echo "File does not exist";
}

$connection = new DBHandler();

$result = $connection->addDocument($new_name, $category_id, $upload_date, $pinned, $uploaded_by, $document_name, $document_description);
//convert the response to a json object
die(json_encode($result));
//!!!!!IMPORTANT CHANGE TO RELEVANT URL !!!!!!
//header("Location: http://localhost:8888/Virtual-Roll-Call-Ver-1.0/app/php/supervisor-profile.php#/upload",TRUE,303);
