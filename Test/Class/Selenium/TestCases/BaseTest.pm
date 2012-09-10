package Test::Class::Selenium::TestCases::BaseTest;


use warnings;
use Time::HiRes qw(sleep);
use Test::WWW::Selenium;
use Test::Most;
use Test::Exception;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::PageObjects::BasePage;
use Spreadsheet::WriteExcel;
use Test::WWW::Selenium;
use Config::Tiny;
use Test::More;
use DateTime;
use base qw(Test::Class Class::Data::Inheritable);

=head1 NAME

BaseTest - setup and teardown methods for Test::Class-derived Selenium tests.

=head1 SYNOPSIS

use base ( BaseTest) ;

=head1 DESCRIPTION

Tests based upon Test::Class may invoke methods to set up and tear down test fixtures.

=head1 TESTCASES

=cut

=head3 startup()

Reads configuration, creates a BasePage object, and starts up the Selenium RC server.

=cut

our $excelReport;
our $i = 1;
our $sheet;
sub startup : Test( startup ) {

    my ($self) = @_;
    my $arg = shift;
   
    my $cfg = Config::Tiny->new;
    
	$cfg = Config::Tiny->read($arg->{config_file});    
  	   
    #coa username
    $self->{cpa_username} = $cfg->{_}->{cpa_username};
    
    #cpa password
    $self->{cpa_password} = $cfg->{_}->{cpa_password};
   
    #ppl username
    $self->{ppl_username} = $cfg->{_}->{ppl_username};
    
    #ppl password
    $self->{ppl_password} = $cfg->{_}->{ppl_password};

    #plt username
    $self->{plt_username} = $cfg->{_}->{plt_username};

    #plt password
    $self->{plt_password} = $cfg->{_}->{plt_password};

    #renter username
    $self->{renter_username} = $cfg->{_}->{renter_username};

    #renter password
    $self->{renter_password} = $cfg->{_}->{renter_password};

    #cs tool username
    $self->{cs_username} = $cfg->{_}->{cs_username};

    #cs tool password
    $self->{cs_password} = $cfg->{_}->{cs_password};

    #firstname
    $self->{firstname} = $cfg->{_}->{firstname};

    #lastname
    $self->{lastname} = $cfg->{_}->{lastname};

    #browser type
    $self->{browser_type} = $arg->{browser};

    #file path
    $self->{filepath} = $cfg->{_}->{photo};
    
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
            browser     => "*".$self->{browser_type},
            browser_url => $self->{test_url},
    );
 
	$self->ie_pause();
	$self->{browser}->start();
	$self->{browser}->set_timeout($self->{set_timeout});
 	
	$self->{browser}->open("/");
	$self->ie_pause();
	
	
	my $dt = DateTime->now( time_zone  => 'local',);
    my $fname = $arg->{report};  
   
	
	$excelReport  = Spreadsheet::WriteExcel->new($fname);
    $sheet = $excelReport->add_worksheet();
    $sheet->write(0, 0, 'Serial No.');
    $sheet->write(0, 1, 'Testcase Name');
    $sheet->write(0, 2, 'Execution Status');
    $sheet->write(0, 3, 'Message');
	
}

=head3 setup()

Perform the operations that are required to be done before a Testcase
Generally Opening the home page, Maximize browser window
=cut

sub setup : Test( setup ) {
	
	my ($self) = @_;
	
    $self->{browser}->wait_for_text_present("Rent.com", $self->{set_timeout});
  	$self->{browser}->set_speed($self->{set_speed});    
	$self->{browser}->set_timeout($self->{set_timeout});
 	   
    #check if signed in.
    if ( $self->{browser}->is_element_present("link=Sign Out") ) {
        $self->{browser}->click("link=Sign Out");
        $self->{browser}->wait_for_page_to_load($self->{set_timeout});
    }

    my $basepage = Test::Class::Selenium::PageObjects::BasePage->new( $self );  
	#$basepage->clear_cookies();
    $basepage->certificate_error_handler();

    if($self->{browser_type} ne "*iexplore")
    {
    	#Maximize window
    	$self->{browser}->window_maximize();
    	$self->{browser}->window_focus();
	}
	$self->{browser}->open( $self->{browser_url} );
	
	$sheet->write($i,0,$i);
	
	$ENV{tc_name}= '';
	$ENV{tc_stat}='Passed';
	$ENV{tc_comment}='';
}

=head3 teardown()

Performs the operations that are generally done after the end of a test case
Generally include clearing the cookies, Refreshing the page
=cut

sub teardown : Test( teardown ) {

    my ($self) = @_;
    $self->{browser}->delete_all_visible_cookies();
    $sheet->write($i, 1, $ENV{tc_name});
    $sheet->write($i, 2, $ENV{tc_stat});
    $sheet->write($i, 3, $ENV{tc_comment});
   $i++;
}

=head3 shutdown()

Stops the Selenium RC server. Closes the browser

=cut

sub shutdown : Test( shutdown ) {

    my ($self) = @_;
	$self->{browser}->close();
	$self->ie_pause();
    $self->{browser}->stop();
	$self->ie_pause();
	$excelReport->close();
	
}

=head3 ie_pause()

Pause for internet explorer,since it takes longer to run.

=cut

sub ie_pause{
	
	my ($self) = @_;

    if($self->{browser_type} eq "*iexplore")
    {
    	$self->{browser}->pause('30000');
	}
}

1;

