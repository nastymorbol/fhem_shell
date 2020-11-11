##############################################
# $Id: 98_dummy.pm 16965 2018-07-09 07:59:58Z rudolfkoenig $
package main;

use strict;
use warnings;
use SetExtensions;
use Scalar::Util qw(looks_like_number);

sub
ShellExecute_Initialize($)
{
  my ($hash) = @_;

  $hash->{GetFn}     = "ShellExecute_Get";
  $hash->{SetFn}     = "ShellExecute_Set";
  $hash->{DefFn}     = "ShellExecute_Define";
  $hash->{AttrList}  = "readingList " .
                       "disable disabledForIntervals " .
                       $readingFnAttributes;
}

###################################
sub
ShellExecute_Get($$$)
{
  my ( $hash, $name, $opt, @args ) = @_;

	return "\"get $name\" needs at least one argument" unless(defined($opt));

  # CMD: Get Notification Classes
  if($opt eq "AllProperties")
  {    
    $hash->{DriverReq} = "CMD:Get$opt";
    DoTrigger($name, "DriverReq: " . $hash->{DriverReq});
    return undef;
  }

  return "unknown argument choose one of AllProperties:noArg";
}

###################################
sub
ShellExecute_Set($$)
{
  my ($hash, @a) = @_;
  my $name = shift @a;

  return "no set value specified" if(int(@a) < 1);
  
  my $cmd = shift @a;  

  my @setList = ();

  return join ' ', @setList;
  
  return undef;
}

sub
ShellExecute_Define($$)
{
  my ($hash, $def) = @_;
  my @a = split("[ \t][ \t]*", $def);
  
  return "Wrong syntax: use define <name> ShellExecute" if(int(@a) < 1);

  my $name = shift @a;
  my $type = shift @a;

  readingsSingleUpdate($hash,"state", "defined",1);
    
  return undef;
}

1;

=pod
=item BACnet
=item summary    ShellExecute
=item summary_DE ShellExecute Ger&auml;t
=begin html

<a name="ShellExecute"></a>
<h3>ShellExecute</h3>
<ul>

  Define a ShellExecute. A ShellExecute can take via <a href="#set">set</a> any values.
  Used for programming.
  <br><br>

  <a name="dummydefine"></a>
  <b>Define</b>
  <ul>
    <code>define &lt;name&gt; dummy</code>
    <br><br>

    Example:
    <ul>
      <code>define myvar ShellExecute BACnetDevice ObjectId</code><br>
      <code>set myvar 7</code><br>
    </ul>
  </ul>
  <br>

  <a name="dummyset"></a>
  <b>Set</b>
  <ul>
    <code>set &lt;name&gt; &lt;value&gt</code><br>
    Set any value.
  </ul>
  <br>

  <a name="dummyget"></a>
  <b>Get</b> <ul>N/A</ul><br>

  <a name="dummyattr"></a>
  <b>Attributes</b>
  <ul>
    <li><a href="#disable">disable</a></li>
    <li><a href="#disabledForIntervals">disabledForIntervals</a></li>
    <li><a name="readingList">readingList</a><br>
      Space separated list of readings, which will be set, if the first
      argument of the set command matches one of them.</li>

    <li><a name="setList">setList</a><br>
      Space separated list of commands, which will be returned upon "set name
      ?", so the FHEMWEB frontend can construct a dropdown and offer on/off
      switches. Example: attr dummyName setList on off </li>

    <li><a name="useSetExtensions">useSetExtensions</a><br>
      If set, and setList contains on and off, then the
      <a href="#setExtensions">set extensions</a> are supported.
      In this case no arbitrary set commands are accepted, only the setList and
      the set exensions commands.</li>

    <li><a href="#readingFnAttributes">readingFnAttributes</a></li>
  </ul>
  <br>

</ul>

=end html

=begin html_DE

<a name="ShellExecute"></a>
<h3>ShellExecute</h3>
<ul>

  Definiert eine ShellExecute Instanz
  <br><br>

  <a name="ShellExecutedefine"></a>
  <b>Define</b>
  <ul>
    <code>define &lt;name&gt; ShellExecute BACnetDevice ObjectId;</code>
    <br><br>

    Beispiel:
    <ul>
      <code>define myDp ShellExecute myBACnetDevice AV:10</code><br>
      <code></code><br>
    </ul>
  </ul>
  <br>

  <a name="ShellExecuteset"></a>
  <b>Set</b>
  <ul>
    <code>set &lt;name&gt; &lt;Register_For_NCO&gt; &lt;64&gt;</code><br>
    Regsitriert sich bei der NCO 64 als Empfänger <br>
    Diese Set Befehle werden erst angezeigt, wenn die vorhandenen NCO ermittelt werden konnten <br>
    Hierfür den Befehl get notificationClasses ausführen.
  </ul>
  <br>

  <a name="ShellExecuteget"></a>
  <b>Get</b> 
    <ul>
      <li><a href="#notificationClasses">notificationClasses</a><br>
      Liest alle vorhandenen NCO aus dem Device aus</li>
      <li><a href="#alarmSummary">alarmSummary</a><br>
      Liest alle anliegenden Meldungen aus dem Gerät aus und aktualisiert die entsprechenden Readings</li>

    </ul>
    <br>

  <a name="dummyattr"></a>
  <b>Attributes</b>
  <ul>
    <li><a href="#disable">disable</a></li>
    <li><a href="#disabledForIntervals">disabledForIntervals</a></li>
    <li><a name="readingList">readingList</a><br>
      Leerzeichen getrennte Liste mit Readings, die mit "set" gesetzt werden
      k&ouml;nnen.</li>

    <li><a name="setList">setList</a><br>
      Liste mit Werten durch Leerzeichen getrennt. Diese Liste wird mit "set
      name ?" ausgegeben.  Damit kann das FHEMWEB-Frontend Auswahl-Men&uuml;s
      oder Schalter erzeugen.<br> Beispiel: attr dummyName setList on off </li>

    <li><a name="useSetExtensions">useSetExtensions</a><br>
      Falls gesetzt, und setList enth&auml;lt on und off, dann die <a
      href="#setExtensions">set extensions</a> Befehle sind auch aktiv.  In
      diesem Fall werden nur die Befehle aus setList und die set exensions
      akzeptiert.</li>

    <li><a href="#readingFnAttributes">readingFnAttributes</a></li>
  </ul>
  <br>

</ul>

=end html_DE

=cut
