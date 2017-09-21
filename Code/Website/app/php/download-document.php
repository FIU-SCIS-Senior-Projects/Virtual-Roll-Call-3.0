<?php
$fileName = $_GET['upload_name'];

if(strtolower(substr($fileName, -4)) == ".pdf")
{
    header('Content-Type: application/pdf');
    header('Content-Disposition: inline; filename="' . $filename . '"');
    header('Content-Transfer-Encoding: binary');
    header('Accept-Ranges: bytes');
    readfile('uploads/' . $fileName);
}
else{
    header('Content-Type: force-download');
    header('Content-Disposition: attachment; filename="' . $fileName . '"');
    header('Content-Disposition: inline; filename="' . $fileName . '"');
    header('HTTP/1.0 200 OK', true, 200);
    readfile('uploads/' . $fileName);
}
