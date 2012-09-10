package Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	TFIELD_EMAIL => "Person-email",
	TFIELD_PASSWORD => "Person-password",
	TFIELD_RPASSWORD => "Person-password_confirm",
	
	DDOWN_PROPERTYTYPE => "Property-PropertyContact-type_nm",
	TFIELD_UNITS => "totalunits",
	TFIELD_UNITSMANAGED => "unitsmanaged",
	
	RBUTTON_SENIORHOUSINGYES =>"senior_housing_yes",
	RBUTTON_SENIORHOUSINGNO =>"senior_housing_no",
	
	RBUTTON_INCOMERESTYES => "income_rest_yes",
	RBUTTON_INCOMERESTNO => "income_rest_no",

	TFIELD_STREET => "street",		
	TFIELD_CITY => "city",
	DDOWN_STATE => "state",
	TFIELD_ZIP => "zip",	
	
	DDOWN_FLOORPLANS => "floorplan_types",
	DDOWN_BEDROOMS  => "Property-Units-0-bedroom_nb",
	DDOWN_BATHS => "Property-Units-0-minimumbathroom_nb",
	
	TFIELD_MINRENT => "Property-Units-0-minimumrent_at",
	TFIELD_MAXRENT => "Property-Units-0-maximumrent_at",
	
	TFIELD_MINSQFEET => "Property-Units-0-minimumsquarefeet_nb",
	TFIELD_MAXSQFEET => "Property-Units-0-maximumsquarefeet_nb",
	
	DDOWN_BEDROOMS_1  => "Property-Units-1-bedroom_nb",
	DDOWN_BATHS_1 => "Property-Units-1-minimumbathroom_nb",
	
	TFIELD_MINRENT_1 => "Property-Units-1-minimumrent_at",
	TFIELD_MAXRENT_1 => "Property-Units-1-maximumrent_at",
	
	TFIELD_MINSQFEET_1 => "Property-Units-1-minimumsquarefeet_nb",
	TFIELD_MAXSQFEET_1 => "Property-Units-1-maximumsquarefeet_nb",
	
	DDOWN_BEDROOMS_2  => "Property-Units-2-bedroom_nb",
	DDOWN_BATHS_2 => "Property-Units-2-minimumbathroom_nb",
	
	TFIELD_MINRENT_2 => "Property-Units-2-minimumrent_at",
	TFIELD_MAXRENT_2 => "Property-Units-2-maximumrent_at",
	
	TFIELD_MINSQFEET_2 => "Property-Units-2-minimumsquarefeet_nb",
	TFIELD_MAXSQFEET_2 => "Property-Units-2-maximumsquarefeet_nb",
	
	
	BUTTON_STEPTWO => "//button[\@type='submit']"

};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

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

=item $landingpage-E<gt>continue_to_step_two($self, $email, $password, $street_address)

Enter form information for new user

=cut	

sub continue_to_step_two {
    my ( $self, $email, $password, $street_address, $city, $state, $zip, $minrent) = @_;
 	$self->fill_create_account($email, $password);
 	$self->fill_property_information($street_address, $city, $state, $zip);
 	$self->fill_floor_plan_info($minrent);
 	$self->click_step_two_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $landingpage-E<gt>continue_to_step_two_existing_user($street_address)

Enter form information for existing user

=cut

sub continue_to_step_two_existing_user {
    my ( $self, $street_address, $city, $state, $zip, $minrent) = @_;
 	$self->fill_property_information($street_address, $city, $state, $zip);
 	$self->fill_floor_plan_info($minrent);
 	$self->click_step_two_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

#Added this subroutine for QA-910 - Income Restricted

sub continue_to_step_two_income_restricted {
    my ( $self, $email, $password, $street_address, $city, $state, $zip, $minrent) = @_;
 	$self->fill_create_account($email, $password);
 	$self->fill_property_information_income_restricted($street_address, $city, $state, $zip);
 	$self->fill_floor_plan_info($minrent);
 	$self->click_step_two_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

#Added this subroutine for QA-913 - Multiple Floor Plans

sub continue_to_step_two_multiple_floor_plans {
    my ( $self, $email, $password, $street_address, $city, $state, $zip, $minrent) = @_;
 	$self->fill_create_account($email, $password);
 	$self->fill_property_information($street_address, $city, $state, $zip);
 	$self->fill_multiple_floor_plan_info($minrent);
 	$self->click_step_two_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

# IB-4506 (Pricing Changes):  single floor plan option default for single vacancy version of PLT Reg
sub continue_to_step_two_single_floor_plan {
    my ( $self, $email, $password, $street_address, $city, $state, $zip, $minrent) = @_;
 	$self->fill_create_account($email, $password);
 	$self->fill_property_information($street_address, $city, $state, $zip);
 	$self->fill_floor_plan_info($minrent);
 	$self->click_step_two_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

		
sub fill_create_account {
	my ( $self, $email, $password ) = @_;

	$self->type(TFIELD_EMAIL, $email);
	$self->type(TFIELD_PASSWORD, $password);
	$self->type(TFIELD_RPASSWORD, $password);
#	$self->type(TFIELD_EMAIL, $email);
#	$self->type(TFIELD_PASSWORD, $password);
#	$self->type(TFIELD_RPASSWORD, $password);
};

sub fill_property_information{
	my ( $self, $street_address, $city, $state, $zip) = @_;
	
	# IB-4506 (Pricing changes):  Apartment option now appears on multi-vacancy version of PLT Reg
	# $self->select(DDOWN_PROPERTYTYPE , "label=Apartment");
	$self->select(DDOWN_PROPERTYTYPE , "label=Condo");

	# IB-4506 (Pricing changes):  Units Managed now appears on multi-vacancy version of PLT Reg
	# $self->type(TFIELD_UNITS, "1");
	# $self->type(TFIELD_UNITSMANAGED, "1");
	$self->click(RBUTTON_SENIORHOUSINGYES);
	$self->click(RBUTTON_INCOMERESTNO);
	$self->type(TFIELD_STREET, $street_address);
	
	$self->type(TFIELD_CITY, $city);
	$self->select(DDOWN_STATE, "label=".$state);
	$self->type(TFIELD_ZIP, $zip);
	
}

#Added this subroutine for QA-910 - Income Restricted

sub fill_property_information_income_restricted{
	
	my ( $self, $street_address, $city, $state, $zip) = @_;
	
	# IB-4506 (Pricing changes): Apartment option now appears on multi-vacancy version of PLT Reg
	# $self->select(DDOWN_PROPERTYTYPE , "label=Apartment");
	$self->select(DDOWN_PROPERTYTYPE , "label=Condo");
	
	# IB-4506 (Pricing changes): Units Managed now appears on multi-vacancy version of PLT Reg
	# $self->type(TFIELD_UNITS, "1");
	# $self->type(TFIELD_UNITSMANAGED, "1");
	$self->click(RBUTTON_SENIORHOUSINGYES);
	$self->click(RBUTTON_INCOMERESTYES);
	$self->type(TFIELD_STREET, $street_address);
	
	$self->type(TFIELD_CITY, $city);
	$self->select(DDOWN_STATE, "label=".$state);
	$self->type(TFIELD_ZIP, $zip);
	
	
}

sub fill_floor_plan_info{
	my ( $self, $minrent) = @_;
	
	# IB-4506 (Pricing changes):  Number of Floorplans option now appears on multi-vacancy version of PLT Reg
	# $self->select(DDOWN_FLOORPLANS, "label=1");
	$self->select(DDOWN_BEDROOMS, "label=Loft");
	$self->select(DDOWN_BATHS, "label=1.75");
	$self->type(TFIELD_MINRENT, $minrent);
	# IB-4506 (Pricing changes):  Max Rent no longer an option on single vacancy version of PLT Reg
	# $self->type(TFIELD_MAXRENT, "1200");
	$self->type(TFIELD_MINSQFEET , "1300");
	# IB-4506 (Pricing changes):  Max Square Feet no longer an option on single vacancy version of PLT Reg
	# $self->type(TFIELD_MAXSQFEET, "1400");	
}

# Added this subroutine for QA-913 - Create new floorplans
# IB-4506 (Pricing Changes):  Applicable only on multi-vacancy version of PLT Reg

sub fill_multiple_floor_plan_info{
	my ( $self, $minrent) = @_;
	
	$self->select(DDOWN_FLOORPLANS, 3);
	$self->select(DDOWN_BEDROOMS, "label=Loft");
	$self->select(DDOWN_BATHS, "label=1.75");
	$self->type(TFIELD_MINRENT, $minrent);
	$self->type(TFIELD_MAXRENT, "1200");
	$self->type(TFIELD_MINSQFEET , "1300");
	$self->type(TFIELD_MAXSQFEET, "1400");	
	
	$self->select(DDOWN_BEDROOMS_1, "label=1");
	$self->select(DDOWN_BATHS_1, "label=2");
	$self->type(TFIELD_MINRENT_1, $minrent);
	$self->type(TFIELD_MAXRENT_1, "1300");
	$self->type(TFIELD_MINSQFEET_1 , "1400");
	$self->type(TFIELD_MAXSQFEET_1, "1500");	
	
	$self->select(DDOWN_BEDROOMS_2, "label=2");
	$self->select(DDOWN_BATHS_2, "label=2.5");
	$self->type(TFIELD_MINRENT_2, $minrent);
	$self->type(TFIELD_MAXRENT_2, "1400");
	$self->type(TFIELD_MINSQFEET_2 , "1500");
	$self->type(TFIELD_MAXSQFEET_2, "1600");	
}

sub click_step_two_button {
 	my ( $self) = @_;	
 	
 	$self->click(BUTTON_STEPTWO);
}
sub click_emailaddress_field {
 	my ( $self) = @_;	
 	
 	$self->click(TFIELD_EMAIL);

}
sub get_password {
 	my ( $self) = @_;	
 	my $pass1= "";
 	my $pass2 = "";
 	
 	$pass1 = $self->get_text(TFIELD_PASSWORD);
 	$pass2 = $self->get_text(TFIELD_RPASSWORD);
    return ($pass1,$pass2);
}

sub select_floor_plan_dropdown {
 	my ( $self) = @_;	
 	
 	$self->select(DDOWN_FLOORPLANS, 2);
}


1;

}
