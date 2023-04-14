#!/usr/perl/bash -w
use strict;

die "$0 <INPUT><OUTPUT>\n" if $#ARGV+1 != 2;
die "Error input file: $ARGV[0]\n" if !open(IN,"<", $ARGV[0]);
die "Error input file: $ARGV[1]\n" if !open(OUT,">", $ARGV[1]);

my @array = <IN>;
my $count = 0;
my %tabela;

foreach my $i (@array)
{
	$count++;
	chomp($i);
	#print "IP: $i\n" if $i =~ m/(\d{1,3}\.){3}\d{1,3}/;
	$tabela{'IP'}++ && print OUT "$count IP: $i\n" if $i =~ m/(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})/ && $1 <= 255 && $2 <= 255 && $3 <= 255 &&  $4 <= 255;
	$tabela{'MAC'}++ && print OUT "$count MAC $i \n" if $i =~ m/([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}/;
	$tabela{'Postal'}++ && print OUT "$count Postal $i\n" if $i =~ m/(\d{4})\-(\d{3})/ && $1 >= 1000 && $2 <=10000 ;
	$tabela{'Telefone'}++ && print OUT "$count Telefone $i\n" if $i  =~ m/\(351\)(\d{2})\d{7}/ && ($1 == 91 || $1 == 92 || $1 == 93 || $1 == 96) ;
	$tabela{'Telefone'}++ && print OUT "$count Telefone $i\n" if $i  =~ m/\+351(\d{2})\d{7}/ && ($1 == 91 || $1 == 92 || $1 == 93 || $1 == 96) ;
	$tabela{'Telefone'}++ && print OUT "$count Telefone $i\n" if $i  =~ m/00351(\d{2})\d{7}/ && ($1 == 91 || $1 == 92 || $1 == 93 || $1 == 96) ;
	$tabela{'Mail'}++ && print OUT "$count Mail $i\n" if $i  =~ m/[0-9A-Za-z\.\-_]{1,}@[0-9A-Za-z\.\-_]{1,}\.pt/;
	$tabela{'URL'}++ && print OUT "$count URL $i\n" if $i  =~ m/http:\/\//;
}


foreach (sort keys %tabela)
{
	print OUT $_." -->> ".$tabela{$_}."\n";
}


close(IN);
close(OUT);
exit(0);




