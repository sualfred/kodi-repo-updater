<!DOCTYPE html>
<html lang="en" >
<head>
	<meta charset="UTF-8">
	<title>Repo Updater</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<form id="upload_form" enctype="multipart/form-data" method="post">
		<h1><strong>Upload Zip</strong> Kodi Repo Generator</h1>
		<div class="form-group">
			<label for="caption">Min. Kodi version / Target Directory</label>
			<select id="repodir" name="repodir" class="formstyle">
			<?php
			$dirs = file("dirs.conf");
			foreach($dirs as $dir) {
				echo "<option value=" . $dir . ">" . $dir . "</option>";
			}
			?>
			</select>
		</div>
		<div class="form-group file-area">
			<label for="images">File</label>
			<input type="file" name="file1" id="file1" required="required" accept=".zip" onchange="uploadFile()"/>
			<div class="file-dummy" id="file-dummy">
				<p id="filename">Select file</p>
				<p id="loaded_n_total"></p>
				<p id="progressStatus"></p>
			</div>
		</div>
		<div class="form-group file-area">
			<button id="update-repo" type="button" class="formstyle" onclick="generate()">Update repo now</button>
		</div>
	</form>
	<script  src="js/index.js"></script>
</body>
</html>
