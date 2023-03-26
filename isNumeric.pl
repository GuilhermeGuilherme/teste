#!/usr/bin/perl -w
use strict;

die "Tem de especificar um parametro de entrada!\n" if $#ARGV+1 != 1;

my $a = $ARGV[0];

sub isNumeric
{
if($a =~ m/[A-z]+/){ return 0;}
return 1;
}

sub isNumeric2
{
if (isNumeric)
{	
	if($a =~ m/-{1}[0-9]+.{0}/){ return "Inteiro negativo! ";}
	if($a =~ m/\+?[0-9]+.{0}/){ return "Inteiro positivo! ";}
}
return "Nao e um numero inteiro! ";
}

sub isNumeric3
{
if(isNumeric)
{
	if($a =~ m/-{1}[0-9]+[.,]{1}[0-9]/){ return "real negativo! ";}
	if($a =~ m/\+?[0-9]+[.,]{1}[0-9]/){ return "real positivo! ";}

}
return "0";
}


sub isNumeric4
{
if (isNumeric3)
{
	$ARGV[0] =~ m/.*[.,](\d+)/;
	return $1;
}
return 0;
}



print isNumeric."\n";
print isNumeric2."\n";
print isNumeric3."\n";
print isNumeric4."\n";

exit(0);
