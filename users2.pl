#!/usr/bin/perl -w
use strict;

die "$0 <FILEIN> <FILEOUT> \n" if $#ARGV+1 != 2;
open(IN, '<', $ARGV[0]) || die "Erro ao abrir o ficheiro: $! \n";
open(OUT, '>', $ARGV[1]) || die "Erro ao abrir o ficheiro: $! \n";

my @ficheiro = <IN>;
my ($linhaa, @linha, $password, $cmd);


foreach $linhaa (@ficheiro)
{
	chomp ($linhaa);
	@linha = split (/\|/,$linhaa);
	chomp(@linha);

	print ("Error missing vaules \n") if $#linha+1 != 4;

	$password = `pwgen -N 1`;
	print ("$linha[0] password: $password ");
	crypt($password, (getpwuid($<))[1]);
	
	$cmd = `useradd \"$linha[0]\" -m -d \"$linha[1]\" -c \"$linha[3]\" -k \"$linha[2]\" -p $password`;
	system ("chage -d 0 -M 0 $linha[0]");

}















close(IN);
close(OUT);
exit(0);
