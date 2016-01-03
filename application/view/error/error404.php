<h1>404 Error: page not found</h1>
<p><?php
	if (!empty($message)) {
		echo $message;
	} else { ?>
		Sorry, but I couldn&rsquo;t find that page.
		<?php }
?></p>
