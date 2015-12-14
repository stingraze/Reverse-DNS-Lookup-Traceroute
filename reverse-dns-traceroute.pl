use Socket;
use Net::Traceroute::PurePerl;
#Text file containing IP addresses. One IP address per line.
$dbfile = "ip.txt";
print "Starting Trace!\n";
open (I, "$dbfile") or die "Unable to open: $dbfile";
my @lines = <I>;
close I;

$counter = 1;
foreach (@lines){
	print "Tracing $counter";
	$counter++;

	chomp;
	$ip = $_;
	$ipinfo = gethostbyaddr(pack('C4',split('\.', $ip)), AF_INET);
	print gethostbyaddr(pack('C4',split('\.', $ip)), AF_INET);
	
	print "\n";

	 my $t = new Net::Traceroute::PurePerl(
         backend        => 'PurePerl', 
         host           => $ip,
         debug          => 0,
         max_ttl        => 12,
         query_timeout  => 2,
         packetlen      => 40,
         protocol       => 'udp', # Or icmp
    );
    $t->traceroute;
    $t->pretty_print;
    
	
	
	if ($ipinfo eq ""){
	$ipinfo = "No address";
	}

	
	open(OUT,">> ip-output.txt");
	print OUT "$ip	$ipinfo\n";
	close(OUT); 

	

}