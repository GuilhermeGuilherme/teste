#!/usr/bin/perl -w
use strict;

die "$0 <FILE_IN> <FILE_OUT>\n" if $#ARGV+1 != 2;
die "ERROR: file $ARGV[0]\n" if !open(IN, "<", $ARGV[0]);
die "ERROR: file $ARGV[1]\n" if !open(OUT, ">", $ARGV[1]);


my @dados = <IN>;

foreach (@dados)
{
	chomp($_);
	my @tmp = split(/#/,$_);
	print "@tmp \n";

	#print "$tmp[0]\n";
	#print "$tmp[1]\n";	
	
	printf("ERROR: Missing values @tmp\n") if $#tmp+1 != 4;
	next if $#tmp+1 != 4;
	
	my $password = `pwgen -N 1`;
	my $pwd = (getpwuid($<))[1];
	my $crypt = crypt($password,$pwd);
	
	

	system("useradd -c \"$tmp[3]\" -m -d$tmp[1] -p$crypt -s$tmp[2] $tmp[0]");

	system("chage -d 0 -M 0 $tmp[0]");
}






close(IN);
close(OUT);
exit(0);
