<?php

/*
|--------------------------------------------------------------------------
| Database Configuration
|--------------------------------------------------------------------------
| Works with both:
| 1. Local XAMPP
| 2. Railway MySQL
|--------------------------------------------------------------------------
*/

// Railway environment variables
$db_host = getenv('MYSQLHOST');
$db_port = getenv('MYSQLPORT');
$db_user = getenv('MYSQLUSER');
$db_pass = getenv('MYSQLPASSWORD');
$db_name = getenv('MYSQLDATABASE');

// If Railway variables are not available, use local XAMPP settings
if (!$db_host) {
    $db_host = 'localhost';
}

if (!$db_port) {
    $db_port = '3306';
}

if (!$db_user) {
    $db_user = 'root';
}

if ($db_pass === false) {
    $db_pass = '';
}

if (!$db_name) {
    $db_name = 'appkarkhana';
}


// Create database connection
$conn = new mysqli(
    $db_host,
    $db_user,
    $db_pass,
    $db_name,
    (int) $db_port
);


// Check connection
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}


// Set UTF-8
$conn->set_charset("utf8mb4");