



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<!-- ViewVC :: http://www.viewvc.org/ -->
<head>
<title>[ruby] Log of /trunk/misc/rb_optparse.bash</title>
<meta name="generator" content="ViewVC 1.1.5" />
<link rel="shortcut icon" href="/viewvc/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/viewvc/styles.css" type="text/css" />

</head>
<body>
<div class="vc_navheader">
<table><tr>
<td><strong><a href="/cgi-bin/viewvc.cgi?view=roots"><span class="pathdiv">/</span></a><a href="/cgi-bin/viewvc.cgi/">[ruby]</a><span class="pathdiv">/</span><a href="/cgi-bin/viewvc.cgi/trunk/">trunk</a><span class="pathdiv">/</span><a href="/cgi-bin/viewvc.cgi/trunk/misc/">misc</a><span class="pathdiv">/</span>rb_optparse.bash</strong></td>
<td style="text-align: right;"></td>
</tr></table>
</div>
<div style="float: right; padding: 5px;"><a href="http://www.viewvc.org/" title="ViewVC Home"><img src="/viewvc/images/viewvc-logo.png" alt="ViewVC logotype" width="240" height="70" /></a></div>
<h1>Log of /trunk/misc/rb_optparse.bash</h1>

<p style="margin:0;">

<a href="/cgi-bin/viewvc.cgi/trunk/misc/"><img src="/viewvc/images/back_small.png" class="vc_icon" alt="Parent Directory" /> Parent Directory</a>

| <a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?view=log"><img src="/viewvc/images/log.png" class="vc_icon" alt="Revision Log" /> Revision Log</a>




</p>

<hr />
<table class="auto">



<tr>
<td>Links to HEAD:</td>
<td>
(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?view=markup">view</a>)


(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?view=annotate">annotate</a>)
</td>
</tr>



<tr>
<td>Sticky Revision:</td>
<td><form method="get" action="/cgi-bin/viewvc.cgi" style="display: inline">
<div style="display: inline">
<input type="hidden" name="orig_pathtype" value="FILE"/><input type="hidden" name="orig_view" value="log"/><input type="hidden" name="orig_path" value="trunk/misc/rb_optparse.bash"/><input type="hidden" name="view" value="redirect_pathrev"/>

<input type="text" name="pathrev" value="" size="6"/>

<input type="submit" value="Set" />
</div>
</form>

</td>
</tr>
</table>
 







<div>
<hr />

<a name="rev30121"></a>


Revision <a href="/cgi-bin/viewvc.cgi?view=revision&amp;revision=30121"><strong>30121</strong></a> -


(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?revision=30121&amp;view=markup">view</a>)




(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?annotate=30121">annotate</a>)



- <a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?r1=30121&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Tue Dec  7 13:31:11 2010 UTC</em>
(8 months, 4 weeks ago)
by <em>nobu</em>









<br />File length: 457 byte(s)







<br />Diff to <a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?r1=29832&amp;r2=30121">previous 29832</a>

(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?r1=29832&amp;r2=30121&amp;diff_format=h">colored</a>)






<pre class="vc_log">* lib/optparse.rb (OptionParser::Officious): separate completion
  options from --help.  [ruby-dev:42690]</pre>
</div>



<div>
<hr />

<a name="rev29832"></a>


Revision <a href="/cgi-bin/viewvc.cgi?view=revision&amp;revision=29832"><strong>29832</strong></a> -


(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?revision=29832&amp;view=markup">view</a>)




(<a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?annotate=29832">annotate</a>)



- <a href="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash?r1=29832&amp;view=log">[select for diffs]</a>




<br />

Added

<em>Fri Nov 19 11:26:54 2010 UTC</em>
(9 months, 2 weeks ago)
by <em>nobu</em>







<br />File length: 453 byte(s)











<pre class="vc_log">* lib/optparse.rb: shell completion support for bash.</pre>
</div>

 


 <hr />
<p><a name="diff"></a>
This form allows you to request diffs between any two revisions of this file.
For each of the two "sides" of the diff,

enter a numeric revision.

</p>
<form method="get" action="/cgi-bin/viewvc.cgi/trunk/misc/rb_optparse.bash" id="diff_select">
<table cellpadding="2" cellspacing="0" class="auto">
<tr>
<td>&nbsp;</td>
<td>
<input type="hidden" name="view" value="diff"/>
Diffs between

<input type="text" size="12" name="r1"
value="30121" />

and

<input type="text" size="12" name="r2" value="29832" />

</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
Type of Diff should be a
<select name="diff_format" onchange="submit()">
<option value="h" >Colored Diff</option>
<option value="l" >Long Colored Diff</option>
<option value="f" >Full Colored Diff</option>
<option value="u" selected="selected">Unidiff</option>
<option value="c" >Context Diff</option>
<option value="s" >Side by Side</option>
</select>
<input type="submit" value=" Get Diffs " />
</td>
</tr>
</table>
</form>





<hr />
<table>
<tr>
<td>&nbsp;</td>
<td style="text-align: right;"><strong><a href="/viewvc/help_log.html">ViewVC Help</a></strong></td>
</tr>
<tr>
<td>Powered by <a href="http://viewvc.tigris.org/">ViewVC 1.1.5</a></td>
<td style="text-align: right;">&nbsp;</td>
</tr>
</table>
</body>
</html>


