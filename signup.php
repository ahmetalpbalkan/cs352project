<?php
require_once 'inc.php';

if ($_SESSION['login'])
	header('Location: index.php');

require_once 'view_top.php';

if ($_POST){
	// customer signup
	$username =  $_POST['username'];
	$password = md5($_POST['password']);
	$phone = $_POST['phone'];
	
	
	$count_query = mysql_query("SELECT COUNT(*) FROM customer where name='$username'", $mysql) or die(mysql_error());
	$count = intval(mysql_result($count_query,0,0));
	
	if ($count>0){
		$error = 'Username in use.';
	} else {
		$insert_query = "INSERT INTO customer (name,password,phone) VALUES ('$username', '$password', '$phone');";
		mysql_query($insert_query, $mysql) or die(mysql_error());
		$success = 'Registration completed.';
	}
}

require 'view_signup.php';

require_once 'view_bottom.php';