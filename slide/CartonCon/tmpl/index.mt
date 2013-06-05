? my $title = shift;
? my $content = shift;
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title><?= $title ?></title>
<link rel="stylesheet" href="static/css/style.css" />
<link rel="stylesheet" href="static/css/pretty.css" />
</head>
<body>
<?= $content ?>
<div id="dummy"></div>
<div id="date"></div>
<div id="page"></div>
<div id="help">
<p>j or &rarr;: next</p>
<p>k or &larr;: prev</p>
<p>h or &uarr;: list</p>
<p>l or &darr;: return</p>
<p>o or &crarr;: open</p>
<p>? or /: toggle this help</p>
</div>
<script type="text/javascript" src="static/js/slide.js"></script>
<script type="text/javascript" src="http://google-code-prettify.googlecode.com/svn/trunk/src/prettify.js"></script>
<script type="text/javascript" src="static/js/prettify.js"></script>
</body>
<html>
