package Test::Class::Selenium::PageObjects::ManagePage;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::BasePage;

use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	BUTTON_PPL => "//div[\@id='bluebox']/div[4]/div[3]/a/img",
	#This is for future I
	#BUTTON_PPL => "//div[\@id='manageOut']/div[1]/div[2]/div/div[4]/a/img",
	BUTTON_MANAGERS => "//li[\@id='li_managers']/div/a",
	BUTTON_HOWITWORKS => "//li[\@id='li_howitworks']/div/a",
	BUTTON_WHYITWORKS => "//li[\@id='li_whyitworks']/div/a",
	BUTTON_THERENTDOTCOMDIFFERENCE => "//li[\@id='li_difference']/div/a",
	BUTTON_FIFTYORMOREUNITS => "//div[\@id='mgrBotLinks']/div[1]/div/div/span[2]/a/img"
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
    my ($class, %args) = @_;
    my $self = {    # default args:
       	selenium                 => undef,
       	%args,
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

sub start_pay_per_lead {
    my ( $self ) = @_;
   
	#$self->{selenium}->{browser}->wait_for_element_present(BUTTON_PPL, "30000");
	$self->{selenium}->{browser}->click(BUTTON_PPL);  
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());   
};

sub click_managers {
    my ( $self ) = @_;
   
   	$self->{selenium}->{browser}->click(BUTTON_MANAGERS);  
	$self->{selenium}->{browser}->wait_for_text_present("where renters look!");   
};

sub click_how_it_works {
    my ( $self ) = @_;
   
   	$self->{selenium}->{browser}->click(BUTTON_HOWITWORKS);  
	$self->{selenium}->{browser}->wait_for_text_present("Create your listing.");   
};

sub click_why_it_works {
    my ( $self ) = @_;
   
   	$self->{selenium}->{browser}->click(BUTTON_WHYITWORKS);  
	$self->{selenium}->{browser}->wait_for_text_present("On Rent.com, there's no need to pay a flat fee upfront!");   
};

sub click_the_rentdotcom_difference {
    my ( $self ) = @_;
   
   	$self->{selenium}->{browser}->click(BUTTON_THERENTDOTCOMDIFFERENCE);  
	$self->{selenium}->{browser}->wait_for_text_present("#1 in unique visitors");   
};

sub click_fifty_or_more_units {
    my ( $self ) = @_;
   
   	$self->{selenium}->{browser}->click(BUTTON_FIFTYORMOREUNITS);  
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());   
};


1

}