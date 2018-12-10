<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="width=device-width"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="/.fancyindex/style.css" type="text/css"/>

    <title>Fred's Repo</title>
</head>
<body>
<br>
<?php
$output = shell_exec('./update.sh');
echo "<pre style=\"font-size:1.5em; line-height: 1em;text-align: center;\">$output</pre>";
?>
<br><br>
</body>
