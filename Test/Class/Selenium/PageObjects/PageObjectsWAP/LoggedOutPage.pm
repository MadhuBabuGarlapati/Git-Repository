package Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::PageObjectsWAP::BasePage';

use constant {
	#State
	BUTTON_WHATTOEXPECT => "css=span.plusminus",
	BUTTON_WHATTOEXPLORE => "css=#2 > span.plusminus",
	BUTTON_MOVERSANDQUOTES=> "css=#3 > span.plusminus",
	BUTTON_FEATUREDPROPERTIES=> "css=#featured-properties-handle > span.plusminus",	
	BUTTON_INSTATE => "//div[7]/span",
	
	#City
	BUTTON_COSTOFLIVING => "css=span.plusminus",
	BUTTON_QUALITYOFLIFE => "css=#2 > span.plusminus",
	BUTTON_WHERETHEJOBSARE => "css=#3 > span.plusminus",
	BUTTON_MOVERSANDQUOTES => "css=#mover-handle-1 > span.plusminus",
	#BUTTON_FEATUREDPROPERTIES => "css=#featured-properties-handle > span.plusminus",
	BUTTON_RENTDOTCOMHASAPARTMENTS => "//div[11]/span",
	BUTTON_SEARCHNEARBYZIPS => "//div[11]/span"
};

=head1 NAME

LoggedOutPage

=head1 SYNOPSIS

PageObjects::PageObjectsWAP::LoggedOutPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the WAP logged out pages

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $loggedoutpage=LoggedOutPage-E<gt>new( %args )

Constructs a new C<pageobjects::LoggedOutPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=item $loggedoutpage-E<gt>click_what_to_expect()

=cut	

sub click_what_to_expect {
    my ( $self ) = @_;

	$self->click(BUTTON_WHATTOEXPECT);

};

=item $loggedoutpage-E<gt>click_what_to_explore()

=cut	

sub click_what_to_explore {
    my ( $self ) = @_;

	$self->click(BUTTON_WHATTOEXPLORE);

};

=item $loggedoutpage-E<gt>click_movers_and_quotes()

=cut	

sub click_movers_and_quotes {
    my ( $self ) = @_;

	$self->click(BUTTON_MOVERSANDQUOTES);

};

=item $loggedoutpage-E<gt>click_featured_properties()

Navigate to forgot password page.

=cut	

sub click_featured_properties {
    my ( $self ) = @_;

	$self->click(BUTTON_FEATUREDPROPERTIES);

};

=item $loggedoutpage-E<gt>click_in_state()

=cut	

sub click_in_state {
    my ( $self ) = @_;

	$self->click(BUTTON_INSTATE);

};

=item $loggedoutpage-E<gt>click_cost_of_living()

=cut	

sub click_cost_of_living{
    my ( $self ) = @_;

	$self->click(BUTTON_COSTOFLIVING);

};

=item $loggedoutpage-E<gt>click_quality_of_life()

=cut	

sub click_quality_of_life{
    my ( $self ) = @_;

	$self->click(BUTTON_QUALITYOFLIFE);

};

=item $loggedoutpage-E<gt>click_where_the_jobs_are()

=cut	

sub click_where_the_jobs_are{
    my ( $self ) = @_;

	$self->click(BUTTON_WHERETHEJOBSARE);

};

=item $loggedoutpage-E<gt>click_rent_dot_com_has_aparments()

=cut	

sub click_rent_dot_com_has_aparments{
    my ( $self ) = @_;

	$self->click(BUTTON_RENTDOTCOMHASAPARTMENTS);

};

=item $loggedoutpage-E<gt>click_search_near_by_zips()

=cut	

sub click_search_nearby_zips{
    my ( $self ) = @_;

	$self->click(BUTTON_SEARCHNEARBYZIPS);

};

=item $loggedoutpage-E<gt>click_city_link()

=cut	

sub click_city_link{
    my ( $self, $city ) = @_;

	$self->click("link=".$city);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

=item $loggedoutpage-E<gt>click_zip_link()

=cut	

sub click_zip_link{
    my ( $self, $zip ) = @_;

	$self->click("link=".$zip);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

1;

}
