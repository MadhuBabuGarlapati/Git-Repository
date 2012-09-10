package Test::Class::Selenium::PageObjects::SearchResultsPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	TFIELD_CITYSTATEZIP => "combined_location_field",
	DDOWN_MINRENT => "minimumrent_at",
	DDOWN_MAXRENT => "maximumrent_at",
	DDOWN_BEDROOMS => "bedroom_nb",
	DDOWN_BATHS => "bathroom_nb",
	BUTTON_SEARCH => "toggleSearchBtn",
	BUTTON_MOREOPTIONS => "uni_search_btn_expand",
	DDOWN_DOGSCATS => "dogscats",
	TFIELD_PROPERTYNAME => "propertykeywords_nm",

	#BUTTON_MOREINFORMATION => "//div[\@id='results_column_loggedin']/div[2]/div/div[3]/div/div[2]/div[5]/div[2]/a",
	BUTTON_MOREINFORMATION => "//div[\@class='more-btn padBot2 floatRt']/a",
    BUTTON_MOREINFORMATION_FL => "//div[\@class='more-btn featured_moreBtn_pad floatRt']/a",
    
	BUTTON_AMENITIES => "//table[\@id='table_popupLinks']/tbody/tr/td[1]/a[2]",
	BUTTON_SAVEAMENITIES => "//div[\@id='uni_search_popup_amenities']/div/div[3]",
	BUTTON_NEIGHBORHOODS => "nbrLink",
	BUTTON_SAVENEIGHBORHOODS => "//div[\@id='uni_search_popup_neighborhoods']/div/div[3]",
	#DDOWN_SORTBY_HIGH_TO_LOW=> "label=Price: Highest to Lowest"
	
	
};



=head1 NAME

SearchResultsPage

=head1 SYNOPSIS

pageobjects::SearchResultsPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the SearchResultsPage page.  The page
allows users to search for properties with various search criteria.

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

	$self->select(DDOWN_MAXRENT  , "label=".$maxprice);		
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
	
	$self->click(BUTTON_MOREINFORMATION);
	$self->wait_for_page_to_load($self->get_page_timeout());

}

=item $searchresultspage-E<gt>click_on_featured_listing_info_button()
ok($searchresultspage)
Click on the first featured listing more info button

=cut	

sub click_on_featured_listing_info_button(){
	my ( $self ) = @_;
	
	$self->click(BUTTON_MOREINFORMATION_FL);
	$self->wait_for_page_to_load($self->get_page_timeout());

}

=item $
searchresultspage-E<gt>submit_password()

Enters password as 'qatest11'

=cut

sub submit_password(){
	my ( $self, $password ) = @_;	
	
	my $message_box = "name=message_box_ifr";
	if ($self->is_element_present($message_box)){
		$self->select_frame($message_box);
		
		if (!defined $password ){
			$password =  "qatest11";
		}
		
		$self->type("password", $password);	
		#print '#\n password: '.$password.'\n ';	
		$self->click("//input[\@type='image']");
		#pause for 45 seconds	
		$self->pause("45000");	
		$self->select_window("");
	}
	else {
		print "#no password entered \n";
	}
	
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

=item $searchresultspage-E<gt>select_amenities()

Select one or more amenities on the page; select Pet Policy

=cut

sub select_amenities()
{
	my ( $self ) = @_;
	my $i = 1;
	my $amenities = $self->get_xpath_count("//div[\@class='padLeft5 padTop10']/input");
	my $amenity;
	my @chkd_amenities;
	
	
	# click "More Options" button
	$self->click(BUTTON_MOREOPTIONS);
	
	# click "Amenities" button
	$self->click(BUTTON_AMENITIES);
	
	# select all amenities and save in an array
	while ( $i < $amenities )
	{
		$self->click("//div[\@class='padLeft5 padTop10']/input[$i]");
		$amenity =  $self->get_text("//div[\@class='padLeft5 padTop10']/label[$i]");
		
		# special exceptions for the Parking and Washer/Dryer amenities
		# label in amenities selection box not exact match in PDP
		if ($amenity =~ m/parking/i)
		{
			$amenity = 'Parking';
		
		}
		
		if  ($amenity =~ m/washer/i)
		{
			$amenity = 'Washer and Dryer';
		}
		
		$chkd_amenities[$i] = $amenity;
		$i++;
		
	}
	
	$self->pause("5000");
	# save selected amenities
	$self->click(BUTTON_SAVEAMENITIES);
	# click search button
	$self->click_search();
	$self->wait_for_page_to_load($self->get_page_timeout());

	
	return ( @chkd_amenities );
}

=item $searchresultspage-E<gt>select_pet_policy()

Selects a Pet Policy

=cut


sub select_pet_policy()
{
	my ( $self,$policy ) = @_;
	
	
	$self->click(DDOWN_DOGSCATS);
	$self->select(DDOWN_DOGSCATS , "label=".$policy);	
}

=item $
searchresultspage-E<gt>search_by_property_name()

Executes a search using a specified property name

=cut

sub search_by_property_name()
{
	my ( $self, $property_name ) = @_;
	
	# click "More Options" button
	$self->click(BUTTON_MOREOPTIONS);
	
	# specify property name
	$self->type(TFIELD_PROPERTYNAME, $property_name);
	
	# click search button
	$self->click_search();
	$self->wait_for_page_to_load($self->get_page_timeout());

}


=item $searchresultspage-E<gt>select_neighborhoods()

Executes a search using neighborhoods option

=cut


sub select_neighborhoods()
{
	my ( $self, $neighborhood ) = @_;
	
	# click "More Options" button
	$self->click(BUTTON_MOREOPTIONS);
	
	# click "Neighborhoods"
	$self->click(BUTTON_NEIGHBORHOODS);
	$self->click($neighborhood);
	$self->click(BUTTON_SAVENEIGHBORHOODS);
	
	# click search button
	$self->click_search();
	$self->wait_for_page_to_load($self->get_page_timeout());

}


#sub sort_highest_to_lowest()
#{
#	my ( $self ) = @_;
	
#	$self->selectAndWait('sorttype');
#	$self->pause("10000");
	
	# click search button
#	$self->click_search();
#	$self->wait_for_page_to_load($self->get_page_timeout());

	
#}

1;

}
