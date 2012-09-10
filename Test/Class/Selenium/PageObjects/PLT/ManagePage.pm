package Test::Class::Selenium::PageObjects::PLT::ManagePage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	# BUTTON_PLT => "//div[\@id='manageOut']/div[1]/div[2]/div/div[4]/a/img",
	# IB-4558 (Splash Page Changes)
	BUTTON_PLT_SINGLEVACANCY => "name=propTypeZipCodeSubmit",
	BUTTON_PLT_MULTIVACANCY => "//div[\@id='propTypeMed']/div[1]/form/input[\@name='propTypeZipCodeSubmit']",
	BUTTON_MANAGERS => "//li[\@id='li_managers']/div/a",
	BUTTON_HOWITWORKS => "//li[\@id='li_howitworks']/div/a",
	BUTTON_WHYITWORKS => "//li[\@id='li_whyitworks']/div/a",
	BUTTON_THERENTDOTCOMDIFFERENCE => "//li[\@id='li_difference']/div/a",
	BUTTON_FIFTYORMOREUNITS => "//div[\@id='mgrBotLinks']/div[1]/div/div/span[2]/a/img",

	TFIELD_PLT_SINGLEVACANCYZIP => "name=propTypeZipCode",
	TFIELD_PLT_MULTIVACANCYZIP => "//div[\@id='propTypeMed']/div[1]/form/input[\@name='propTypeZipCode']"
};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= pageobjects::ManagePage-E<gt>new( %args )

Constructs a new C<pageobjects::ManagePage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub start_plt_singlevacancy {
    my ( $self, $zipcode ) = @_;
   
	#$self->{selenium}->{browser}->wait_for_element_present(BUTTON_PPL, "30000");
	$self->type(TFIELD_PLT_SINGLEVACANCYZIP, $zipcode); 
	$self->click(BUTTON_PLT_SINGLEVACANCY);  
	$self->wait_for_page_to_load($self->get_page_timeout());   
};

sub start_plt_multivacancy {
    my ( $self, $zipcode ) = @_;
   
	#$self->{selenium}->{browser}->wait_for_element_present(BUTTON_PPL, "30000");
	$self->type(TFIELD_PLT_MULTIVACANCYZIP, $zipcode); 
	$self->click(BUTTON_PLT_MULTIVACANCY);  
	$self->wait_for_page_to_load($self->get_page_timeout());   
};

sub click_managers {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_MANAGERS);  
	$self->wait_for_text_present("where renters look!");   
};

sub click_how_it_works {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_HOWITWORKS);  
	$self->wait_for_text_present("Create your listing.");   
};

sub click_why_it_works {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_WHYITWORKS);  
	$self->wait_for_text_present("On Rent.com, there's no need to pay a flat fee upfront!");   
};

sub click_the_rentdotcom_difference {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_THERENTDOTCOMDIFFERENCE);  
	$self->wait_for_text_present("#1 in unique visitors");   
};

sub click_fifty_or_more_units {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_FIFTYORMOREUNITS);  
	$self->wait_for_page_to_load($self->get_page_timeout());   
};

1

}