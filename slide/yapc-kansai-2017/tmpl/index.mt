? my $title = shift;
? my $content = shift;
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title><?= $title ?></title>
<link rel="stylesheet" href="static/css/style.css" />
<link rel="stylesheet" href="static/css/pretty.css" />
<link rel="stylesheet" href="static/css/custom.css" />
<meta name="viewport" content="width=devide-width,initial-scale=0.8,user-scalable=no" />
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
<script type="text/javascript" src="static/google-code-prettify/prettify.js"></script>
<script type="text/javascript" src="static/js/prettify.js"></script>
</body>
<html>
