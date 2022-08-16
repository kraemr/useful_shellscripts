#!/bin/usr/perl
use 5.010;
use strict;
use warnings;

use LWP::Simple qw(get);
use Config::Tiny;
use Cpanel::JSON::XS qw(decode_json);
use Data::Dumper qw(Dumper);
 
sub get_api_key {
    my $config = Config::Tiny->read('config.ini');
    return $config->{openweathermap}{api};
}
 
sub get_weather {
    my ($api_key, $location) = @_;
 
    my $url = "https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$api_key";
    my $json_str = get $url;
    return decode_json $json_str;
}
sub print_weather {
    my ($weather) = @_; #get the passed parameter
    use Term::ANSIColor qw(:constants);
    print BOLD RED "temp: $weather->{main}{temp} Celsius\n";
    print BOLD GREEN "humidity: $weather->{main}{humidity}%\n";
    print BOLD YELLOW "feels like: $weather->{main}{feels_like} Celsius\n";
    print BOLD BLUE "pressure: $weather->{main}{pressure} bar\n";

}
 
sub main {
    my $location = shift @ARGV or die "Usage: $0 LOCATION\n";
    my $api_key = get_api_key();
    my $weather = get_weather($api_key, $location);
    use Term::ANSIColor qw(:constants); 
 #   say $weather->{main}{temp};
#    say $weather->{main}{humidity};
   # print BOLD BLUE "Blue text\n"; 
    print_weather($weather);      
    
}
 
main();
