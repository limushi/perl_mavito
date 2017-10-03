#!/usr/local/bin/perl
# 2017-09-29, Max L.
# программа для получения данных из Avito
# парсинг HTML: https://dev.w3.org/html5/spec-preview/parsing.html 

use warnings;
use LWP::UserAgent;
use utf8;
use XML::Simple;	#типа, самое простое, что есть?, http://www.techrepublic.com/article/parsing-xml-documents-with-perls-xmlsimple/
		# http://search.cpan.org/~grantm/XML-Simple-2.24/lib/XML/Simple.pm
#use XML::DOM;	#https://www.xml.com/pub/a/2001/05/16/perlxml.html
#use XML::LibXML; #https://docstore.mik.ua/orelly/perl4/cook/ch22_07.htm	- наиболее часто используемый пример
use Data::Dumper;

my $pid=1;	#этот pid было бы хорошо получать до 5 штук примерно
my $end_cnt=2;	#предел для количества страниц одновременно

while ( $pid <= $end_cnt ) {

	my $sbase="https://m.avito.ru/moskva/gotoviy_biznes/internet-magazin\?p=$pid";
	my $ua = LWP::UserAgent->new( ssl_opts => {verify_hostname => 0} );
	my $resp = $ua->get($sbase);

	if ( $resp->is_success ) {
		my $content = $resp->decoded_content ;
			
				# доки по работе с файлами: http://eax.me/perl-basics-part-4/, 
				# http://www.codenet.ru/webmast/perl/files.php
			open FL, ">output$pid.html"	
				or die "Can't open file output$pid.html";
			#попробовать избавить $content от скриптов
			#одна из рекомендаций - использовать XPath для DOM дерева html
			# доки: https://www.w3schools.com/xml/xpath_intro.asp
			# доки2: https://habrahabr.ru/post/114772/
			# пример с готовой либой: https://grantm.github.io/perl-libxml-by-example/xpath.html
			# http://archive.oreilly.com/oreilly/perl/excerpts/index.csp
			# http://archive.oreilly.com/pub/a/perl/excerpts/system-admin-with-perl/ten-minute-xpath-utorial.html#working_with_configuration_files
			
			$content =~ s/script//g;
			#
			print FL $content;
			close FL;
			#print $resp->decoded_content ;	#собственно, здесь получаем контент, который было бы хорошо очищать
	}
	else {
		die $resp->status_line ;
	}

	$pid = $pid + 1;
}

#getprint($sbase) or die "Can't get data from $sbase\n";

