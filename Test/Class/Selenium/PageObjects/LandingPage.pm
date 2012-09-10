package Test::Class::Selenium::PageObjects::LandingPage;

use strict;
use warnings;

use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	TFIELD_CITY           => "freeform_submarket_nm",
	DDOWN_STATE           => "state_nb",
	DDOWN_MINRENT         => "minimumrent_at",
	DDOWN_MAXRENT         => "maximumrent_at",
	DDOWN_BEDROOMS        => "bedroom_nb",
	TFIELD_EMAIL          => "email",
	BUTTON_VIEWLISTINGS   => "fsubmit",
	LINK_LISTYOURPROPERTY => "link=List Your Property",
	PRIVACYFOOTER => "//div[\@id='main_footer']/a[2]",
	PRIVACYREGLINK => "//div[\@class='privacy-copy']/div/a",
	PROPERTYTAB =>"//div[\@id='top_nav_mainLink_wrapper']/div[2]/a",
	POPULARLINK => "//div[\@id='left_nav']/div[2]/ul/li/a",	
};

=head1 NAME

LandingPage

=head1 SYNOPSIS

pageobjects::LandingPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the LandingPage page.  The page
allows users to enter their email address and search for various properties.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= pageobjects::LandingPage-E<gt>new( %args )

Constructs a new C<pageobjects::LandingPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };
   bless $self, $class or die "Can't bless $class: $!";
   return $self;
}	

=item $landingpage-E<gt>view_the_latest_listings($city, $state, $minprice, $maxprice, $bedrooms, $emailaddress)

Enter form information

=cut	

sub view_the_latest_listings {
    my ( $self, $city, $state, $minprice, $maxprice, $bedrooms, $emailaddress ) = @_;
   
    $self->enter_city($city);
    $self->select_state($state);
    $self->select_min_price($minprice);
    $self->select_max_price($maxprice);
    $self->select_bedrooms($bedrooms);
    $self->select_email_address($emailaddress);
	$self->click_view_listings();
	$self->wait_for_page_to_load($self->get_page_timeout());   
 
};

=item $landingpage-E<gt>enter_city($city)

Type in city

=cut
		
sub enter_city {
	my ( $self, $city ) = @_;
	
	$self->wait_for_element_present(TFIELD_CITY, $self->get_page_timeout());
	$self->type(TFIELD_CITY, $city);
};

=item $landingpage-E<gt>select_state($state)

Select state

=cut
	
sub select_state {
	my ( $self, $state ) = @_;

	$self->select(DDOWN_STATE, "label=".$state);	
};

=item $landingpage-E<gt>select_min_price($minprice)

Select min price

=cut

sub select_min_price {
	my ( $self, $minprice ) = @_;

	$self->select(DDOWN_MINRENT , "label=".$minprice);	
};

=item $landingpage-E<gt>select_max_price($maxprice)

Select max price

=cut			

sub select_max_price {
	my ( $self, $maxprice ) = @_;

	$self->select(DDOWN_MAXRENT  , "label=".$maxprice);		
};

=item $landingpage-E<gt>select_bedrooms($bedrooms)

Select bedrooms

=cut
		
sub select_bedrooms {
	my ( $self, $bedrooms ) = @_;
	
	$self->select(DDOWN_BEDROOMS  , "label=".$bedrooms);	
	
};

=item $landingpage-E<gt>select_email_address($emailaddress)

Select email address

=cut
		
sub select_email_address {
	my ( $self, $emailaddress ) = @_;
	
	$self->type(TFIELD_EMAIL, $emailaddress);
	
};

=item $landingpage-E<gt>}click_view_listings()

Click View listings

=cut
		
sub click_view_listings {
	my ( $self ) = @_;
	
	$self->click(BUTTON_VIEWLISTINGS);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $landingpage-E<gt>}click_list_your_property()

Click List Your Property

=cut

sub click_list_your_property {
	my ( $self ) = @_;
	
	$self->click(LINK_LISTYOURPROPERTY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $landingpage-E<gt>}click_property_tab()

Click Property Tab

=cut

sub click_property_tab{
		my ($self) = @_;
		$self->click(PROPERTYTAB);
		$self->wait_for_page_to_load( $self->get_page_timeout() );
	}

=item $landingpage-E<gt>}click_pol_footer()

Click Privacy Policy link at bottom of page

=cut

sub click_pol_footer{
		my ($self) = @_;
		$self->click(PRIVACYFOOTER);
		$self->wait_for_page_to_load( $self->get_page_timeout() );
	}

=item $landingpage-E<gt>}click_pol_regLink()

Click Privacy Policy link at bottom of registration box

=cut

sub click_pol_regLink{
		my ($self) = @_;
		$self->click(PRIVACYREGLINK);
		$self->wait_for_page_to_load( $self->get_page_timeout() );
	}

1;

}
