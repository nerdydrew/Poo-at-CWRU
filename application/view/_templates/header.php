<?php
	if (Helper::isLoggedIn()) {
		$gender = $this->model->getGender(phpCAS::getUser());
	}
?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8" />
                                          <!--o/-
                                         +dyyyhhds:`
                                          ydyyyyyhhds:`
                                         +dhyyyyyyyhhdh/`
                                       `sdhyyyyyyyyyyyhdh-
                                       /dhhyyyhhyyhhyyhhhd+
                                       +dhyyhhhhyyhhhyyyyhd/
                                    .+shhyyyyyyyyyyyhyyyhydh
                                  :yhyssssyyyyyhyyyyyyyyhhdh/-`
                                 odysyyyyyyyhyyyyyyyyyyhyyyyhhdy/`
                                +dyyyyyyyyyyyyyyyyyhhhyyssyyyyhhdy.
                                ydyyhhhhhhhhhyyyhhyyyssyyyyyhhhhhds
                                odhhy+/:::/shyyyysssyyys+/:::+syydh
                              -+sdh+-..-:...:sssyyyyyy+-..::...:yhhs/`
                            :yhyss/.`-dNNN+``-yyyyyyh/.`-dNNm/`.-ssyhdo.
                           odyssss-` yNNNNN.`.ohyyhyy.``hNNNNm``.ossyyhh-
                          :dhyyyyy.` ymmmmm. `ohhhhhy.` hmmmmm` `oyyyyydy
                          sdhyyhhh/` -dmmm+  .yhhhyyy:` -dmmm/  .yyyyyhhd`
                          odhhhhhhh/` `-:.  .syyssssss:` `-:`  -syhyyyhdh`
                        `-oddhhhhyyys:.```-/ssssssssssso:.``.:ohyhhyyhhds-
                      :shhyssssssssssssssssssssssssssyyyyyyhhyhhhhhhhyyyhdho-
                    `sdysssssssssssssss/////////////////////yhhhhhhyyyyyyyhhdo`
                    ydssssssssssssssssys:.````````````````-ohhhhhyyyyyyyyyyhhdo
                   .dhyyyyyyyyyyyyyyyyyyyy+-`          ./shhhhyyyyyyyyhyyyyyyhd`
                   -dhyyyyyyyyyyyyyyhhhhhhhhhs+/////+oyhhhhyyyyyyyhhhhhhhhhhhhd`
                   `hdhhyyyyyhyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhd+
                    -hdhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdds-
                     `/yddhhhhhddddhysoooosyyhddddddddddddddddddddddddhys+-`
                        `.-:///:-.`            ``..--:::://////::-->


	<title><?php if (isset($title) && $title != null && $title != "")
	echo $title . ' &mdash; ';

	?>Poo at CWRU</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<?php echo ANALYTICS; ?>
</head>

<body>

<header id="header"<?php
	if (Helper::isLoggedIn()) {
		echo 'class="double" ';
	} ?>><nav>
		<h1><a href="<?php echo URL; ?>"><img src="/img/Logo.svg" />Poo at CWRU</a></h1>

		<ul>
			<li><a href="<?php echo URL; ?>">Find</a></li>


<?php if (Helper::isLoggedIn()) { ?>
	<li><a href="?logout">Log out</a></li>
	<li class="genders">
		<a href="?male" class="male<?php
		if ($gender == "male") {
			echo " selected";
		} ?>" title="View men&rsquo;s restrooms">&#9794;</a>
		/
		<a href="?female" class="female<?php
		if ($gender == "female") {
			echo " selected";
		} ?>" title="View women&rsquo;s restrooms">&#9792;</a>
		/
		<a href="?all" class="all<?php
		if ($gender != 'male' && $gender != 'female') {
			echo " selected";
		} ?>" title="View all restrooms, regardless of gender">All</a></li>


<?php } else { ?>
	<li><a href="?login">Log In</a></li>
<?php } ?>

</ul></nav>

</header>

<article>
