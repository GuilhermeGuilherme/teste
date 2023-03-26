#!/usr/bin/perl -w
use strict;

die "$0 <FILEIN> <FILEOUT> \n" if $#ARGV+1 != 2;
open(IN, '<', $ARGV[0]) || die "Erro ao abrir o ficheiro: $! \n";
open(OUT, '>', $ARGV[1]) || die "Erro ao abrir o ficheiro: $! \n";

my @ficheiro = <IN>;
my ($linhaa, @linha, $teste, $cmd);


foreach $linhaa (@ficheiro)
{
	chomp ($linhaa);
	@linha = split (/\|/,$linhaa);
	chomp(@linha);
		
	$cmd = `userdel -r $linha[0];`
}


close(IN);
close(OUT);
exit(0);
