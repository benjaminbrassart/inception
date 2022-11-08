<?php

// https://www.adminer.org/plugins/#use
function adminer_object()
{
	include_once "./plugins/plugin.php";

	foreach (glob("plugins/*.php") as $filename)
	{
		include_once "./$filename";
	}

	$plugins = [
		new AdminerLoginServers([
			"MariaDB" => [
				"server" => "mariadb",
				"driver" => "server",
			]
		]),
	];

	return new AdminerPlugin($plugins);
}

include "./adminer.php";

?>
