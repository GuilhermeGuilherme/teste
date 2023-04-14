#!/usr/bin/perl -w
use strict;
use warnings;

die "$0 <INPUT>\n" if $#ARGV+1 != 2;
die "Error input file: $ARGV[0]\n" if !open(IN,"<",$ARGV[0]);
die "Error input file: $ARGV[1]\n" if !open(OUT,">",$ARGV[1]);

my @array = <IN>; #

my %hash;
my $conta = 0;

print OUT "Linha\tTipo\tOcorrencia\n";

foreach my $i (@array)
{
	$conta++;
	chomp($i); # Retira o \n
	#print "IP: $i\n" if $i =~ m/([0-9]{1,3}\.){3}[0-9]{1,3}/;
	#print "IP: $i\n" if $i =~ m/(\d{1,3}\.){3}\d{1,3}/;
	if ($i =~ m/(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})/ && $1 <= 255 && $2 <= 255 && $3 <= 255 && $4 <= 255)
	{
		$hash{'IP'}++;
		print OUT $conta."\tIP\t$i\n";
	
	}
	if ($i =~ m/([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}/)
        {
                $hash{'MAC'}++;
                print OUT $conta."\tMAC\t$i\n";
        }
	if ($i =~ m/(\d{4})\-(\d{3})/ && $1 >= 1000 && $1 <= 9000)
        {
                $hash{'Código Postal'}++;
                print OUT $conta."\tCódigo Postal\t$i\n";
        }
	if (($i =~ m/\(351\)(\d{2})\d{7}/ && ($1==91 || $1==93 || $1==96 || $1==92)) || ($i =~ m/^\+351(\d{2})\d{7}$/ && ($1==91 || $1==93 || $1==96 || $1==92)))
        {
                $hash{'Phone'}++;
                print OUT $conta."\tPhone\t$i\n";
        }
	if ($i =~ m/[0-9A-Za-z\.\-_]{1,}@[0-9A-Za-z\.\-_]{1,}\./)
        {
                $hash{'MAIL'}++;
                print OUT $conta."\tMAIL\t$i\n";
        }
	if ($i =~ m/http:\/\/[0-9A-Za-z\.\-_]{1,}:\d{1,5}\/*/)
        {
                $hash{'URL'}++;
                print OUT $conta."\tURL\t$i\n";
        } 
	##$hash{'MAC'}++ && print OUT $conta."\tMAC\t$i\n" if $i =~ m/^([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}$/;
	#print "Código Postal $i\n" if $i =~ m/~(\d){4}\-\d{3}$/;
	##$hash{'Código Postal'}++ && print OUT $conta."\tCódigo Postal\t$i\n" if $i =~ m/^(\d{4})\-(\d{3})$/ && $1 >= 1000 && $1 <= 9000;
	#$hash{'Phone'}++ && print OUT $conta."\tPhone\t$i\n" if $i =~ m/^\(351\)(\d{2})\d{7}$/ && ($1==91 || $1==93 || $1==96 || $1==92);
	#$hash{'Phone'}++ && print OUT $conta."\tPhone\t$i\n" if $i =~ m/^\+351(\d{2})\d{7}$/ && ($1==91 || $1==93 || $1==96 || $1==92);
	#$hash{'MAIL'}++ && print OUT $conta."\tMAIL\t$i\n" if $i =~ m/^[0-9A-Za-z\.\-_]{1,}@[0-9A-Za-z\.\-_]{1,}\.pt$/;	



}

print OUT "---------------------\n";

foreach (sort keys %hash)
{
	print OUT $_." ---> ".$hash{$_}."\n"
}

close(IN);
exit(0);
