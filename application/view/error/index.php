<h1>Error</h1>
<p><?php
	if (!empty($message)) {
		echo $message;
	} else { ?>
		There was a problem fetching that page.
		<?php }
?></p>
