package Test::Class::Selenium::PageObjects::B::SearchResultsPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {

	TFIELD_CITYSTATEZIP => "combined_location_field",
	DDOWN_MINRENT => "minimumrent_at",
	DDOWN_MAXRENT => "maximumrent_at",
	DDOWN_BEDROOMS => "filter-beds-val",
	DDOWN_BATHS => "filter-baths-val",
	BUTTON_SEARCH => "update-btn-input",

        BUTTON_PROPERTYTYPE => "filter-property-type-val",
        BUTTON_MINSQUARE => "filter-min-sqft-val",
        BUTTON_AMENITIES => "filter-amenities-val",
        BUTTON_SAVEAMENITIES => "SRP_NewAmenities_submit_button",
        BUTTON_PETPOLICY => "filter-pets-val",
        BUTTON_SAVEPETPOLICY => "SRP_NewPetpolicy_submit_button",

        BUTTON_NEIGHBORHOODS => "//div[\@id='filter-neighborhoods']/div/em",
        BUTTON_UPDATENEIGHBORHOODS => "link=UPDATE",
        BUTTON_CANCELNEIGHBORHOODS => "//div[\@id='opts-neighborhoods']/div[2]/div/a[2]",

        BUTTON_HOUSINGTYPE => "filter-housing-type-val",
        BUTTON_SAVEHOUSINGTYPE => "SRP_NewHousingtype_submit_button",


        BUTTON_RESETFILTER => "advanced-filter-reset",
        BUTTTON_HIDEFILTER => "hide-filters",
        BUTTON_SHOWFILTER => "show-advanced-filters",
        BUTTON_MOREINFORMATION => "//img[\@alt='More Information']",

	
	
};



=head1 NAME

SearchResultsPage

=head1 SYNOPSIS

pageobjects::SearchResultsPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the new SearchResultsPage page.  

=cut

=head2 METHODS


The following methods are available:

=over

=cut

{
	
=item $loginpage= pageobjects::LoginPage-E<gt>new( %args )

Constructs a new C<pageobjects::LoginPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $searchresultspage-E<gt>get_search_results($citystatezip, $minprice, $maxprice, $bedrooms, $baths)

Enter form information

=cut

sub get_search_results {
    my ($self, $citystatezip, $minprice, $maxprice, $bedrooms, $baths) = @_;

    $self->enter_city_state_zip($citystatezip);
    $self->select_min_price($minprice);
    $self->select_max_price($maxprice);
    $self->select_bedrooms($bedrooms);
    $self->select_baths($baths);
	$self->click_search();
	$self->wait_for_page_to_load($self->get_page_timeout());   
};

=item $searchresultspage-E<gt>enter_city_state_zip($citystatezip)

Types in city & state, or zip

=cut

sub enter_city_state_zip {
	my 
	( $self, $citystatezip ) = @_;
	
	$self->type(TFIELD_CITYSTATEZIP, $citystatezip);
};

=item $searchresultspage-E<gt>select_min_price($minprice)

Selects minprice

=cut
		
sub select_min_price {
	my ( $self, $minprice ) = @_;

	$self->select(DDOWN_MINRENT , "label=".$minprice);	
};

=item $searchresultspage-E<gt>select_max_price($maxprice)

Selects maxprice

=cut
		
sub select_max_price {
	my ( $self, $maxprice ) = @_;

	$self->type(DDOWN_MAXRENT  , $maxprice);		
};

=item $searchresultspage-E<gt>select_bedrooms($bedrooms)

Select number of bedrooms

=cut

sub select_bedrooms {
	my ( $self, $bedrooms ) = @_;
	
	$self->select(DDOWN_BEDROOMS  , "label=".$bedrooms);	
	
};

=item $searchresultspage-E<gt>select_baths($baths)

Select number of baths

=cut


sub select_baths {
	my ( $self, $baths ) = @_;
	
	$self->select(DDOWN_BATHS, "label=".$baths);
	
};

=item $searchresultspage-E<gt>click_search()

Click search

=cut
	
		
sub click_search {
	my ( $self ) = @_;
	
	$self->click(BUTTON_SEARCH);
};

=item $searchresultspage-E<gt>click_on_first_property_more_info_button()
ok($searchresultspage)
Click on the first search property in a search, if search is empty return error.

=cut
	

sub click_on_first_property_more_info_button(){
	my ( $self ) = @_;
	
	#if more information button is present
	if($self->is_element_present(BUTTON_MOREINFORMATION)){
		$self->click(BUTTON_MOREINFORMATION);
		$self->wait_for_page_to_load($self->get_page_timeout());
	}	
	else {
		print "\n===Your search produced no results, please modify search Criteria===\n";
		return 0;
	}
}

=item $
searchresultspage-E<gt>submit_password()

Enters password as 'qatest11'

=cut

sub submit_password(){
	my ( $self, $password ) = @_;	
	
	$self->select_frame("name=message_box_ifr");
	
	if (!defined $password ){
		$password =  "qatest11";
	}
	
	$self->type("password", $password);	
			
	#print '#\n password: '.$password.'\n ';
	
	$self->click("//input[\@type='image']");

	#pause for 20 seconds	
	$self->pause("60000");

	#might have to implement an if condition for ie and ff		
	#$self->select_frame("relative=top");
	
	$self->select_window("");
}

=item $searchresultspage-E<gt>goto_property()

Goto a propety page

=cut

sub goto_property(){
	my ( $self, $property_id ) = @_;	

	print "#Goto property: ".$property_id."\n";
	$self->open("/rentals/".$property_id."/
	");
	$self->pause("30000");

	#$self->wait_for_page_to_load("30000");
}



1;

}