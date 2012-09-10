package Test::Class::Selenium::TestCases::TestCasesWAP::BaseTest;

use strict;
use warnings;
use Time::HiRes qw(sleep);
use Test::WWW::Selenium;
use Test::Most;
use Test::Exception;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::PageObjects::BasePage;

use Test::WWW::Selenium;
use Config::Tiny;
use Test::More;

use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

BaseTest - setup and teardown methods for Test::Class-derived Selenium tests.

=head1 SYNOPSIS

use base ( BaseTest) ;

=head1 DESCRIPTION

Tests based upon Test::Class may invoke methods to set up and tear down test fixtures.

=head1 TESTCASES

=cut


=head3 setup()

Reads configuration, creates a BasePage object, and starts up the Selenium RC server.

=cut
sub setup : Test( setup ) {

    my ($self) = @_;
    my $arg = shift;
    
    my $cfg = Config::Tiny->new;
    
	$cfg = Config::Tiny->read($arg->{config_file});    
    
    #print "\n".$arg->{config_file}."\n";
    
    #renter username
    $self->{renter_username} = $cfg->{_}->{renter_username};

    #renter password
    $self->{renter_password} = $cfg->{_}->{renter_password};
    #browser type
    $self->{browser_type} = $cfg->{_}->{browser};
   
    # property name
    $self->{property_name} = $cfg->{_}->{propname};
    
    #xml_path
    $self->{xml_path} = $cfg->{_}->{xml_path};

	#screenshot
    $self->{screenshot} = $cfg->{_}->{screenshot};    

	#database
    $self->{database} = $cfg->{_}->{database};

    #db_username
    $self->{db_username} = $cfg->{_}->{db_username};

    #db_password
    $self->{db_password} = $cfg->{_}->{db_password}; 
   	
    $self->{host} = $cfg->{_}->{host};
    $self->{port} = $cfg->{_}->{port};
    $self->{test_url} = $cfg->{_}->{test_url};
    $self->{test_ssl_url} = $cfg->{_}->{test_ssl_url};
    
	#set_speed
	$self->{set_speed} = $cfg->{_}->{set_speed};
	#set_timeout
	$self->{set_timeout} = $cfg->{_}->{set_timeout};	
	    
    $self->{browser} =
        Test::WWW::Selenium->new(
            host        => $self->{host},
            port        => $self->{port},
            browser     => $self->{browser_type},
            browser_url => $self->{test_url},
    );
 
	$self->{browser}->start();
	$self->{browser}->set_timeout($self->{set_timeout});
 	
	$self->{browser}->open("/wap");
    
    $self->{browser}->wait_for_text_present("Rent.com", $self->{set_timeout});
  	$self->{browser}->set_speed($self->{set_speed});    
	$self->{browser}->set_timeout($self->{set_timeout});
 	   
    #check if signed in.
    if ( $self->{browser}->is_element_present("link=Sign Out") ) {
        $self->{browser}->click("link=Sign Out");
        $self->{browser}->wait_for_page_to_load($self->{set_timeout});
    }
    $self->{browser}->open( $self->{browser_url} );
}


=head3 teardown()

Stops the Selenium RC server.

=cut

sub teardown : Test( teardown ) {

    my ($self) = @_;

    $self->{browser}->close();
    $self->{browser}->stop();

}

1;

