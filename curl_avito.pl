#!perl
## about: this is example of the curl usage ##
## example: get data from curl, clear the data and write into XML ##


print("Test\n");
#-- list the processes running on your system
my $url="https://m.avito.ru";
open(CL,"curl.exe $url |") || die "Failed: $!\n";
while ( <CL> )
{
  #-- do something here
  print ;	#stdout куда-нибудь записать
}
print "\nxxxENDxxx";
#-- send an email to user@localhost
#open(MAIL, "| /bin/mailx -s test user\@localhost ") || die "mailx failed: $!\n";
#print MAIL "This is a test message";